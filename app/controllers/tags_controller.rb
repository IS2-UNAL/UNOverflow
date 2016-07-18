class TagsController < ApplicationController
  before_action :authenticate_user!, only: [:edit,:new ,:upadate,:destroy,:create]
  before_action :set_tag, only: [:show, :edit, :update, :destroy, :questionsByTag], :except =>[:index]
  before_action :isAdmin, only: [:edit,:new, :upadate,:destroy]

  # GET /tags
  # GET /tags.json
  def index
    @tags = Tag.where('title LIKE ?', "%#{params[:search]}%").paginate(:page => params[:page], :per_page => 10).order("title #{params[:order]}")
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
        format.html { redirect_to @tag, notice: 'Tag was successfully created.' }
        format.json { render :show, status: :created, location: @tag }
      else
        format.html { render :new }
        format.json { render json: @tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tags/1
  # PATCH/PUT /tags/1.json
  def update
    respond_to do |format|
      if @tag.update(tag_params)
        format.html { redirect_to @tag, notice: 'Tag was successfully updated.' }
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
    respond_to do |format|
      format.html { redirect_to tags_url, notice: 'Tag was successfully destroyed.' }
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
        flash[:alert] = "You don't have enough permissions to access to this place"
        redirect_to root_path
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tag_params
      params.require(:tag).permit(:title, :description)
    end
end
