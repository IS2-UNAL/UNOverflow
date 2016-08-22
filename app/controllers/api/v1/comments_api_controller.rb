class Api::V1::CommentsApiController < ApiController
  respond_to :json
  before_action :comment_params, only:[:create,:update]
  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = @user.id
    if @comment.save
      head 201, content_type: "text/html"
    else
      render json: { errors: @comment.errors }, status: 400
    end
  end
  def update
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      head 200, content_type: "text/html"
    else
      render json: {errors: @comment.errors}, status: 400
    end
  end
  def destroy
    @comment =  Comment.find(params[:id])
    @comment.destroy
    head 204, content_type: "text/html"
  end
  def show
    respond_with Comment.find(params[:id])
  end
  private
    def comment_params
      params.require(:comment).permit(:answer,:post_id)
    end
end
