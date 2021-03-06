class MessagesController < ApplicationController
  before_filter :authenticate_user!

  load_resource

  def new
  end

  def create
    @recipients = find_users_by_recipients(params[:_recipients])

    if params[:conversation].present?
      conversation = Conversation.find(params[:conversation])
      @receipt = current_user.reply_to_conversation(conversation, params[:message][:body])
    else
      @receipt = current_user.send_message(@recipients, params[:message][:body], params[:message][:subject])
    end

    if @receipt.errors.blank?
      @conversation = @receipt.conversation
      redirect_to @conversation, notice: t('messages.create.success')
    else
      flash[:error] = t('messages.create.failure')
      render :new, status: 403
    end

  end

  private

  def find_users_by_recipients(recipients)
    return [] unless recipients.class == String
    recipients.split(/,\s*/).map do |r|
      User.where(["name LIKE ? OR email LIKE ?", r, r]).first
    end
  end

end
