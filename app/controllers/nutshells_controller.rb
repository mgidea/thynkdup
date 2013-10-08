class NutshellsController < ApplicationController

  def index

    @nutshells = current_user.nutshells
    binding.pry
  end

  def new
    @nutshell = Nutshell.new
  end

  def create
    @nutshell = Nutshell.new(nutshell_params)
    @nutshell.user = current_user

    if @nutshell.save
      flash[:notice] = "Sounds like a great idea!"
      redirect_to nutshell_path(@nutshell)
    else
      if current_user == nil
        flash[:notice] = "You must be logged in"
      end
      render "new"
    end
  end

  def show
    @nutshell = Nutshell.find(params[:id])
  end

  protected

  def nutshell_params
    params.require(:nutshell).permit(:title, :content)
  end
end






