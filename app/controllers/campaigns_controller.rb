class CampaignsController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]

  load_resource :user, except: [:catalog]
  load_resource through: :user, except: [:catalog]
  authorize_resource except: [:index, :show]

  def catalog
    @search = Campaign.search(params[:q])
    @campaigns = @search.result
  end

  def index
    redirect_to user_path(@user) unless @user.has_role? :agency
    @search = @user.campaigns.search(params[:q])
    @campaigns = @search.result
  end

  def show
    @joined_users_count = @campaign.joined_users.count
  end

  def create
    if @campaign.save
      redirect_to user_campaign_path(current_user.id, @campaign.id), :notice => "Campaign created."
    else
      render :action => 'new', :status => 403
    end
  end

  def destroy
    if @campaign.destroy
      flash[:notice] = "Campaign deleted."
    else
      flash[:error] = "Campaign not deleted."
    end
    redirect_to :action => 'index'
  end

  def update
    if @campaign.update_attributes(params[:campaign])
      redirect_to user_campaign_path(current_user.id, @campaign.id), :notice => "Campaign updated."
    else
      render :action => 'edit', :status => 403
    end
  end

  def joined_users
    @joined_users = @campaign.joined_users
  end

end
