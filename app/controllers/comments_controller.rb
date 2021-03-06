class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:edit,:new,:create,:update,:destroy,:myComments]
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.all
  end
  def myComments
    @comments = Comment.where("user_id = ?" ,current_user.id).paginate(:page=>params[:page],:per_page=>10).order("updated_at ASC")
  end
  def addImage
    if request.xhr?
      @comment = Comment.find(params[:commentID])
      @image =  Image.new(image:params[:file])
      @comment.images << @image
      if @image.save!
        @comment.save!
        render json: {:id=>@comment.id,:name=>"/comments/"}
      end
    else
      redirect_to root_path
    end
  end
  # GET /comments/1
  # GET /comments/1.json
  def show
    @post =  @comment.post
  end

  # GET /comments/new
  def new
    @post = Post.find params[:post_id]
    @comment = Comment.new(:post =>@post)
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = Comment.new(comment_params)
    @comment.user_id =  current_user.id
    respond_to do |format|
      if @comment.save
        format.html { redirect_to @comment, notice: t('.created') }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    imagesDelete = Image.where(id:params[:image_ids])
    imagesDelete.each do |image|
      @comment.images.delete(image)
      #image.destroy
    end
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment, notice: t('.updated') }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @post = @comment.post
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to @post, notice: t('.destroy') }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:answer,:post_id)
    end
end
