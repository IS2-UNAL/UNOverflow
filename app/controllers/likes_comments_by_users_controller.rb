class LikesCommentsByUsersController < ApplicationController
  before_action :set_likes_comments_by_user, only: [:show, :edit, :update, :destroy]

  # GET /likes_comments_by_users
  # GET /likes_comments_by_users.json
  def index
    @likes_comments_by_users = LikesCommentsByUser.all
  end

  # GET /likes_comments_by_users/1
  # GET /likes_comments_by_users/1.json
  def show
  end

  # GET /likes_comments_by_users/new
  def new
    @likes_comments_by_user = LikesCommentsByUser.new
  end

  # GET /likes_comments_by_users/1/edit
  def edit
  end

  # POST /likes_comments_by_users
  # POST /likes_comments_by_users.json
  def create
    @likes_comments_by_user = LikesCommentsByUser.new(likes_comments_by_user_params)

    respond_to do |format|
      if @likes_comments_by_user.save
        format.html { redirect_to @likes_comments_by_user, notice: 'Likes comments by user was successfully created.' }
        format.json { render :show, status: :created, location: @likes_comments_by_user }
      else
        format.html { render :new }
        format.json { render json: @likes_comments_by_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /likes_comments_by_users/1
  # PATCH/PUT /likes_comments_by_users/1.json
  def update
    respond_to do |format|
      if @likes_comments_by_user.update(likes_comments_by_user_params)
        format.html { redirect_to @likes_comments_by_user, notice: 'Likes comments by user was successfully updated.' }
        format.json { render :show, status: :ok, location: @likes_comments_by_user }
      else
        format.html { render :edit }
        format.json { render json: @likes_comments_by_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /likes_comments_by_users/1
  # DELETE /likes_comments_by_users/1.json
  def destroy
    @likes_comments_by_user.destroy
    respond_to do |format|
      format.html { redirect_to likes_comments_by_users_url, notice: 'Likes comments by user was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_likes_comments_by_user
      @likes_comments_by_user = LikesCommentsByUser.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def likes_comments_by_user_params
      params.require(:likes_comments_by_user).permit(:is_possitive, :user_id, :comment_id)
    end
end
