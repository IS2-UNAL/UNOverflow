class Api::V1::UsersController < ApplicationController
  respond_to :json
  def shwo
    respond_with User.find(params[:id])
  end
end
