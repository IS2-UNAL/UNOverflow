class Api::V1::PostsApiController < ApiController
  respond_to :json
  before_action :post_params, only:[:create,:update]
  def index
    @posts = Post.all.paginate(:page => params[:page],:per_page => 25)
    render json: @posts, meta: { pagination:
                                   { per_page: 25,
                                     total_pages: @users.total_pages,
                                     total_objects: @users.total_entries,
                                     next_page: @users.next_page } },status: 200
  end
  def create
    @post = Post.new(post_params)
    @post.user_id = @user.id
    if params.key('tags')
      values = params['tags'].split(",")
      values.each do |a|
        tag =  Tag.where('title = ?',a).first()
        if tag
          @post.tags << tag
        end
      end
    else
      head 400, content_type: "text/html"
    end
    if @post.save
      head 201, content_type: "text/html"
    else
      render json: { errors: @post.errors }, status: 400
    end
  end
  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      head 200, content_type: "text/html"
    else
      render json: {errors: @post.erros}, status: 400
    end
  end
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    head 204, content_type: "text/html"
  end
  def show
    respond_with Post.find(params[:id])
  end
  private
    def post_params
      params.require(:post).permit(:title,:description,:is_solved)
    end
end
