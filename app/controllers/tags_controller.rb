class TagsController < ApplicationController
  before_action :authenticate_user!, only: [:edit,:new ,:upadate,:destroy,:create,:subscribeByTag,:unsubscribeByTag,:favoriteTags]
  before_action :set_tag, only: [:show, :edit, :update, :destroy, :questionsByTag,:subscribeByTag,:unsubscribeByTag]
  before_action :isAdmin, only: [:edit,:new, :upadate,:destroy]

  # GET /tags
  # GET /tags.json
  def index
    search = params[:search]
    search ||= ""
    @tags = Tag.tagSearch(params[:page],search.strip,params[:order])
    @order = params[:order]
    @order ||= "ASC"
  end

  def questionsByTag
    @posts = @tag.posts.paginate(:page => params[:page], :per_page => 10).order("title ASC")
  end

  # GET /tags/1
  # GET /tags/1.json
  def show
  end

  # GET /tags/new
  def new
    @tag = Tag.new
  end

  # GET /tags/1/edit
  def edit
  end

  # POST /tags
  # POST /tags.json
  def create
    @tag = Tag.new(tag_params)

    respond_to do |format|
      if @tag.save
        format.html { redirect_to @tag, notice: t('.created') }
        format.json { render :show, status: :created, location: @tag }
      else
        format.html { render :new }
        format.json { render json: @tag.errors, status: :unprocessable_entity }
      end
    end
  end

  def subscribeByTag
    a = TagUser.new(user_id: current_user.id,tag_id: @tag.id)
    respond_to do |format|
      if a.save
        format.html { redirect_to tags_path, notice: "We have created your subscription" }
      else
        format.html { redirect_to tags_path }
      end
    end
  end

  def favoriteTags
    search = params[:search]
    search ||= ""
    @tags = current_user.tags.tagSearch(params[:page],search.strip,"ASC")
    
  end

  def unsubscribeByTag
    a = TagUser.where(user_id: current_user.id,tag_id: @tag.id).first
    respond_to do |format|
      if a
        a.destroy
        format.html { redirect_to tags_path, notice: "We have destroyed your subscription" }
      else
        format.html { redirect_to tags_path}

      end
    end
  end

  # PATCH/PUT /tags/1
  # PATCH/PUT /tags/1.json
  def update
    respond_to do |format|
      if @tag.update(tag_params)
        format.html { redirect_to @tag, notice: t('.updated') }
        format.json { render :show, status: :ok, location: @tag }
      else
        format.html { render :edit }
        format.json { render json: @tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tags/1
  # DELETE /tags/1.json
  def destroy
    @tag.destroy
    if @tag.errors.any?
      flash[:alert] = t('.message')
    else
      flash[:notice] = t('.destroy')
    end
    respond_to do |format|
      format.html { redirect_to tags_url}
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tag
      @tag = Tag.find(params[:id])
    end

    def isAdmin
      if current_user.role !=  "Admin"
        flash[:alert] = t('.admin')
        redirect_to root_path
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tag_params
      params.require(:tag).permit(:title, :description)
    end
end
