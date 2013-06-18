class CampaignsController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]

  load_resource :user
  load_resource through: :user
  authorize_resource except: [:index, :show]

  def show
    return true if current_user.nil?
    if current_user.joined?(@campaign)
      @enrollment = current_user.enrollments.find_by_campaign_id(@campaign.id)
      @enrollment_url = user_campaign_enrollment_path(@user.id, @campaign.id)
    else
      @enrollment = current_user.enrollments.build(campaign_id: @campaign.id)
      @enrollment_url = user_campaign_enrollments_path(@user.id, @campaign.id)
    end
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

end
