class EnrollmentsController < ApplicationController
  before_filter :authenticate_user!

  def create
    authorize! :create, Enrollment
    agency = User.find(params[:user_id])
    campaign = agency.campaigns.find(params[:campaign_id])

    if current_user.join!(campaign)
      flash[:notice] = "You just joined the campaign."
    else
      flash[:error] = "Could not joined campaign."
    end
    redirect_to user_campaign_path(agency, campaign)
  end

  def destroy
    authorize! :destroy, Enrollment
    agency = User.find(params[:user_id])
    campaign = agency.campaigns.find(params[:campaign_id])

    if current_user.leave!(campaign)
      flash[:notice] = "You just left the campaign."
    else
      flash[:error] = "Could not leave campaign."
    end
    redirect_to user_campaign_path(agency, campaign)
  end

end
