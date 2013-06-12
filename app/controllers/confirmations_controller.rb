class ConfirmationsController < Devise::ConfirmationsController
  include ApplicationHelper

  def show
    self.resource = resource_class.find_by_confirmation_token(params[:confirmation_token]) if params[:confirmation_token].present?
    super if resource.nil? or resource.confirmed?
  end

  def confirm
    token = params[resource_name][:confirmation_token]
    self.resource = resource_class.find_by_confirmation_token(token) if token.present?

    is_role_ok = selectable_roles.map { |role| role.id }.include?(params[resource_name][:role_ids].to_i)
    if resource.nil?
      flash[:error] = t('devise.failure.invalid_token')
      render :action => "show", status: 403
    elsif is_role_ok == false
      flash[:error] = t('rolify.new.error')
      render :action => "show", status: 403
    elsif resource.update_attributes(params[resource_name].except(:confirmation_token), as: :admin)
      self.resource = resource_class.confirm_by_token(token)
      set_flash_message :notice, :confirmed
      sign_in_and_redirect(resource_name, resource)
    else
      render :action => "show", status: 403
    end
  end
end
