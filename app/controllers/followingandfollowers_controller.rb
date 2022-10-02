class FollowingandfollowersController < ApplicationController
  def create
    user = User.find(params[:following_and_follower][:followed_id])
    current_user.follow(user)
    redirect_to request.referer
  end

  def destroy
    user = User.find(params[:id])
    current_user.unfollow(user)
    redirect_to request.referer
  end

  def followings
    user = User.find(params[:user_id])
    @users = user.followings
  end

  def followers
    user = User.find(params[:uesr_id])
    @users = user.followers
  end
end
