class Api::V1::CommentsApiController < ApiController
  respond_to :json
  def index
    respond_with Comment.all
  end
  def show
    respond_with Comment.find(params[:id])
  end
end
