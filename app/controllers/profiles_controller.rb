class ProfilesController < ApplicationController
  before_action :authenticate_user!, except: [:show, :public, :index]

  def index
  end

  def new
    @user = current_user
    @profile = Profile.new
  end

  def create
    @profile = Profile.new(profile_params)
    @profile.user = current_user
    if current_user.nutshells.empty?
      flash[:notice] = "You must create a nutshell before working on a profile"
      redirect_to new_nutshell_path(current_user)
    else
      if @profile.save
        flash[:notice] = "Welcome to your new Profile Page"
        redirect_to profile_path(@profile)
      else
        render 'new'
      end
    end
  end

  def show
    @profile = Profile.find(params[:id])
    render 'public' if @profile.user != current_user
  end

  def public
  end

  def edit
    @profile = Profile.find(params[:id])
    if @profile.user != current_user
      flash[:notice] = "You are not the owner of this profile"
      render 'public'
    end
  end

  def update
    @profile = Profile.find(params[:id])
    if @profile.update(profile_params)
      flash[:notice] = "Your Profile has been updated"
      redirect_to profile_path(@profile)
    else
      render 'edit'
    end
  end

  def destroy
    @profile = Profile.find(params[:id])
    if @profile.user == current_user
      @profile.delete
      flash[:notice] = "You just deleted your profile.  Follow the link to add profile to create a new one"
      redirect_to nutshells_path
    end
  end

  def profile_params
    params.require(:profile).permit(:occupation, :interests, :inspirations, :aspirations, :goals, :recommendations)
  end
end
