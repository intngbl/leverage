class HomeController < ApplicationController
  def index
    @search = Campaign.search(params[:q])
    @campaigns = @search.result
    @latest_campaigns = Campaign.latest
  end
end
