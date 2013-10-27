class ThynkupsController < ApplicationController
  def create
    @friendship = current_user.friendships.build(params[:friend_id])
    if @friendship.save
      flash[:notice] = "You have a new Thynker"
      redirect_to profile_path(current_user)
    else
      flash[:notice] = "Something went wrong"
      redirect_to profile_path(current_user)
    end
  end

  def destroy
    @friendship = current_user.friendships.find(params[:id])
    @friendship.destroy
    flash[:notice] = "Your thynkup no longer exists"
    redirect_to profile_path(current_user)
  end
end
