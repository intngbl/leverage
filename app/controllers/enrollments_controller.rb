class EnrollmentsController < ApplicationController
  before_filter :authenticate_user!

  load_and_authorize_resource
  load_resource :user, instance_name: :agency
  load_resource :campaign, through: :agency
  load_resource :enrollment

  def create
    if current_user.join!(@campaign)
      flash[:notice] = t('campaigns.join.request')
    else
      flash[:error] = t('campaigns.join.failure')
    end
    redirect_to user_campaign_path(@agency, @campaign)
  end

  # Covers 2 cases:
  # 1 - when admin will unsubscribe users through the joined users table
  # 2 - when current_user unsubscribes himself from a campaign (leave button)
  def destroy
    if params[:enrollment]
      @enrollment = Enrollment.find(params[:enrollment][:id])
    end

    if @enrollment.user.leave!(@campaign)
      flash[:notice] = "Unsubscribed successfully."
    else
      flash[:error] = "Unsubscription failed."
    end

    if current_user.has_role? :tweeter
      redirect_to user_campaign_path(@agency, @campaign)
    else
      redirect_to enrollment_user_campaign_path(@agency, @campaign)
    end
  end

end
