class CampaignsController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]

  def index
    @user = User.find(params[:user_id])
    @campaigns = @user.nil? ? [] : @user.campaigns
  end

  def show
    @user = User.find(params[:user_id])
    @campaign = @user.campaigns.find(params[:id])
  end

  def new
    @user = current_user
    @campaign = @user.campaigns.build
    authorize! :create, @campaign
  end

  def create
    @campaign = current_user.campaigns.build(params[:campaign])
    authorize! :create, @campaign
    if @campaign.save
      redirect_to user_campaign_path(current_user.id, @campaign.id), :notice => "Campaign created."
    else
      render :action => 'new', :status => 403
    end
  end

end
