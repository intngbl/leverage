class HomeController < ApplicationController
  def index
    @search = Campaign.search(params[:q])
    @campaigns = @search.result
  end
end
