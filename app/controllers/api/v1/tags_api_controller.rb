class Api::V1::TagsApiController < ApiController
  respond_to :json
  before_action :isAdmin,only:[:create,:update,:destroy]
  before_action :tag_params, only: [:create,:update]
  def index
    @tags = Tag.all.paginate(:page => params[:page],:per_page => 25)
    render json: @tags, meta: { pagination:
                                   { per_page: 25,
                                     total_pages: @tags.total_pages,
                                     total_objects: @tags.total_entries,
                                     next_page: @tags.next_page } },status: 200
  end
  def show
    respond_with Tag.find(params[:id])
  end
  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      head 201, content_type: "text/html"
    else
      render json: { errors: @tag.errors }, status: 400
    end
  end
  def update
    @tag = Tag.find(params[:id])
    if @tag.update(tag_params)
      head 200, content_type: "text/html"
    else
      render json: { errors: @tag.errors }, status: 400
    end
  end
  def destroy
    @tag =  Tag.find(params[:id])
    @tag.destroy
    if @tag.errors.any?
      render json: { errors: @tag.errors }, status: 500
    else
      head 204, content_type: "text/html"
    end
  end
  private
    def isAdmin
      if @user
        if @user.role !=  "Admin"
          head 401, content_type: "text/html"
        end
      else
        head 401, content_type: "text/html"
      end
    end
    def tag_params
      params.require(:tag).permit(:title, :description)
    end
end
