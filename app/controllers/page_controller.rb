class PageController < ApplicationController
  def index
  end
  def contactUS
    if params[:email] != "" && params[:comment] != "" && params[:name] != ""
      PageMailer.received(params[:email],params[:comment], params[:name]).deliver_later
      redirect_to root_url
    else
      redirect_to root_url, notice:t('.message')
    end

  end
end
