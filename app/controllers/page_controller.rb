class PageController < ApplicationController
  def index
  end
  def contactUS
    if params[:email] != "" && params[:comment] != ""
      PageMailer.received(params[:email],params[:comment]).deliver_later
      redirect_to root_url
    else
      redirect_to root_url, notice:"Your comments or email aren't not valid"
    end

  end
end
