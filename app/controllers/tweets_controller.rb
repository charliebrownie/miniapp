class TweetsController < ApplicationController
  def index
    @tweets = Tweet.all.order("id DESC").page(params[:page]).per(5)
  end
  
  def new 
    @tweet = Tweet.new
  end

  def show
    @tweet=Tweet.find(params[:id])
  end

  def create
    # params.require(:tweets).permit(:text, :name)
    Tweet.create(create_params)
    # redirect_to controller: :tweets, action: :index
  end

  def destroy
    tweet=Tweet.find(params[:id])
    if tweet.user_id == current_user.id
      tweet.destroy
    end
  end

  def update
    tweet=Tweet.find(params[:id])
    if tweet.user_id == current_user.id
      tweet.update(tweet_params)
    end
  end

  def edit
    @tweet = Tweet.find(params[:id])
  end

  private
  def create_params
    params.require(:tweet).permit(:name, :text).merge(user_id: current_user.id)
  end

  def tweet_params
    params.permit(:text)
  end

end
