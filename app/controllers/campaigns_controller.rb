class CampaignsController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]

  load_resource :user, :only => [:index, :show]
  load_resource :through => :user, :only => [:index, :show]
  load_and_authorize_resource :through => :current_user, :only => [:new, :create, :destroy]

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

end
