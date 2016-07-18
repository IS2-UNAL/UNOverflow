class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:edit,:new ,:upadate,:destroy,:create,:myPosts,:addImage]
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all.paginate(:page => params[:page],:per_page => 10).order('title ASC')
    @index = "all"
  end

  def myPosts
    @posts = Post.where("user_id = ? ",current_user.id).paginate(:page => params[:page], :per_page => 10).order('title ASC')
  end

  def addImage
    if request.xhr?
      @post = Post.find(params[:postID])
      @image = Image.new(image:params[:file])
      @post.images<<@image
      if @image.save!
        @post.save!
        render json: @post.id
      end
    else
      redirect_to root_path
    end


  end

  def lastDay
    @posts = Post.where("updated_at >= ? ", 1.days.ago).paginate(:page => params[:page],:per_page =>10).order('title ASC')
    @lastDay = "lastDay"
    render "index"
  end

  def lastWeek
    @posts = Post.where("updated_at >= ? ", 1.week.ago).paginate(:page => params[:page],:per_page =>10).order('title ASC')
    @lastWeek = "lastWeek"
    render "index"
  end

  def lastMonth
    @posts = Post.where("updated_at >= ?", 1.month.ago).paginate(:page => params[:page],:per_page => 10).order('title ASC')
    @lastMoth = "lastMonth"
    render "index"
  end

  def suggest
    @tags = Tag.where('title LIKE ?', "#{params[:titleTag]}%")
    if request.xhr?

    else
      redirect_to root_path
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @tags = Array.new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    value = params[:tagsValues]
    values = value.split(",")
    @post = Post.new(post_params)
    @post.user_id =  current_user.id
    values.each do |a|
      tag = Tag.where("title = ?",a).first();
      @post.tags << tag
    end
    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        @tags = Array.new
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    imagesDelete = Image.where(id:params[:image_ids])
    imagesDelete.each do |a|
      @post.images.delete(a)
      a.destroy
    end
    respond_to do |format|

      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :description, :is_solved, :user_id)
    end
end
