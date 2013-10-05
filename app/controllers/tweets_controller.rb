class TweetsController < ApplicationController
  before_filter :authenticate_user!

  load_resource
  load_resource :campaign
  authorize_resource except: [:show]

  def index
  end

  def show
  end

  def create
  end

  def destroy
  end

  def update
  end
end
