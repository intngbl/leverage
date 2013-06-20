class EnrollmentsController < ApplicationController
  before_filter :authenticate_user!

  load_and_authorize_resource
  load_resource :user, instance_name: :agency
  load_resource :campaign, through: :agency

  def create
    if current_user.join!(@campaign)
      flash[:notice] = "You just joined the campaign."
    else
      flash[:error] = "Could not joined campaign."
    end
    redirect_to user_campaign_path(@agency, @campaign)
  end

  def destroy
    # Covers 2 cases:
    # 1 - when admin will unsubscribe users through the joined users table
    # 2 - when current_user unsubscribes himself from a campaign (leave button)
    if params[:enrollment]
      enrollment = Enrollment.find(params[:enrollment][:id])
      enrolled_user = User.find(enrollment.user_id)
    else
      enrolled_user = current_user
    end

    if enrolled_user.leave!(@campaign)
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
