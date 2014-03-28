class ThynkupsController < ApplicationController
  def create
    @thynkup = current_user.thynkups.build(thynker_id: params[:thynker_id])
    @thynkup.status = "requesting"
    if @thynkup.save
      flash[:notice] = "You have a new Thynker"
      if current_user.profiles.present?
        redirect_to profile_path(current_user)
      else
        redirect_to nutshells_path(current_user)
      end
    else
      flash[:notice] = "Something went wrong"
      render profiles_path(params[:thynker_id])
    end
  end

  def destroy
    @thynkup = current_user.thynkups.find(params[:id])
    @thynkup.destroy
    flash[:notice] = "Your thynkup no longer exists"
    redirect_to profile_path(current_user)
  end
end
