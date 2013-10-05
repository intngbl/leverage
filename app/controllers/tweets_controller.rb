class TweetsController < ApplicationController
  before_filter :authenticate_user!

  load_resource :campaign, except: [:show]
  load_resource
  authorize_resource except: [:show]

  def index
    @tweets = @campaign.tweets || []
  end

  def create
    @tweet = @campaign.tweets.build(params[:tweet])
    if @tweet.save
      redirect_to @tweet, :notice => t('tweets.create.success')
    else
      render :action => 'index', :status => 403
    end
  end

end

