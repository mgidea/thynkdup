class ThynkupsController < ApplicationController
  def create
    @thynkup = current_user.thynkups.build(thynker_id: params[:thynker_id])
    @thynkup.status = "requesting"
    if @thynkup.save
      Thynkup.create(user_id: @thynkup.thynker_id, thynker_id: current_user.id)
      flash[:notice] = "You have a new Thynker"
      redirect_to profile_path(current_user)
    else
      flash[:notice] = "Something went wrong"
      redirect_to profile_path(current_user)
    end
  end

  def destroy
    @thynkup = current_user.thynkups.find(params[:id])
    @thynkup.destroy
    flash[:notice] = "Your thynkup no longer exists"
    redirect_to profile_path(current_user)
  end

  protected
  def thynkup_params
    params.require(:thynkup).permit(:user_id, :thynker_id)
  end
end
