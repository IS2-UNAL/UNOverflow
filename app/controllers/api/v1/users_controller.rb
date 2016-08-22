class Api::V1::UsersController < ApiController
  respond_to :json
  def index
    @users = User.all.paginate(:page => params[:page],:per_page => 25)
    render json: @users, meta: { pagination:
                                   { per_page: 25,
                                     total_pages: @users.total_pages,
                                     total_objects: @users.total_entries,
                                     next_page: @users.next_page } },status: 200
  end
  def show
    respond_with User.find(params[:id])
  end
  def login
    if params.key?('email') && params.key?('user_password')
      @user = User.where("email=?",params['email']).first()
      if @user
        if @user.valid_password?(params['user_password'])
        render json: @user, status:200
        else
          render json: {errors: "Invialid credentials"}, status: 422
        end
      else
        render json: {errors: "Invialid credentials"}, status: 422
      end
    else
      render json: { errors: "The request is wrong" }, status: 422
    end
  end
end
