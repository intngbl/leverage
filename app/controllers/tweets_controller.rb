class TweetsController < ApplicationController
  before_filter :authenticate_user!

  load_resource :campaign, except: [:show, :edit, :update, :destroy, :schedule]
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

  def update
    if @tweet.update_attributes(params[:tweet])
      redirect_to @tweet, :notice => t('tweets.update.success')
    else
      render :action => 'edit', :status => 403
    end
  end

  def destroy
    campaign = @tweet.campaign
    if @tweet.destroy
      flash[:notice] = t('tweets.destroy.success')
    else
      flash[:error] = t('tweets.destroy.error')
    end
    redirect_to campaign_tweets_path(campaign)
  end

  def schedule
    @tweet.schedule_tweet
    redirect_to @tweet, :notice => t('tweets.schedule.success', when: @tweet.tweeted_at)
  end

end

