class EnrollmentsController < ApplicationController
  before_filter :authenticate_user!

  load_and_authorize_resource
  load_resource :campaign, only: [:create]
  load_resource

  def create
    if current_user.join!(@campaign)
      flash[:notice] = t('campaigns.join.request')
    else
      flash[:error] = t('campaigns.join.failure')
    end
    redirect_to campaign_path(@campaign)
  end

  # Covers 2 cases:
  # 1 - when admin will unsubscribe users through the joined users table
  # 2 - when current_user unsubscribes himself from a campaign (leave button)
  def destroy
    if params[:enrollment]
      @enrollment = Enrollment.find(params[:enrollment][:id])
    end

    campaign = @enrollment.campaign

    if @enrollment.destroy
      flash[:notice] = "Unsubscribed successfully."
    else
      flash[:error] = "Unsubscription failed."
    end

    if current_user.has_role? :tweeter
      redirect_to campaign
    else
      redirect_to recruits_campaign_path(campaign)
    end
  end

  def authorize
    @enrollment.authorize!
    redirect_to recruits_campaign_path(@enrollment.campaign)
  end

end
