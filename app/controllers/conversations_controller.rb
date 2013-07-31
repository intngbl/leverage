class ConversationsController < ApplicationController
  before_filter :authenticate_user!
  helper_method :mailbox

  load_resource only: [:show]

  def index
  end

  def show
    @receipts = mailbox.receipts_for(@conversation)
    @receipts.mark_as_read
  end

  private

  # Memoization
  def mailbox
    @mailbox ||= current_user.mailbox
  end

end
