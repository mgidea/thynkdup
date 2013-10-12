class NutshellsController < ApplicationController
  before_action :authenticate_user!

  def index
    @nutshells = current_user.nutshells
  end

  def edit
    @nutshell = Nutshell.find(params[:id])
    @categorizations = @nutshell.categorizations.build
  end

  def new
    @nutshell = Nutshell.new
    @categorizations = @nutshell.categorizations.build
    @nutshell.user = current_user
  end

  def create
    @nutshell = Nutshell.new(nutshell_params)
    @nutshell.user = current_user
    if @nutshell.save
      flash[:notice] = "Sounds like a great idea!"
      redirect_to nutshell_path(@nutshell)
    else
      render "new"
    end
  end

  def show
    @nutshell = Nutshell.find(params[:id])
    @note = Note.new
  end

  def update
    @nutshell = Nutshell.find(params[:id])
    if @nutshell.user == current_user
      if @nutshell.update(nutshell_params)
        flash[:notice] = "Your Thynkdup has been Updated"
        redirect_to nutshell_path(@nutshell)
      else
        render "edit"
      end
    end
  end

  def destroy
    @nutshell = Nutshell.find(params[:id])
    if @nutshell.user == current_user
      @nutshell.destroy
      flash[:notice] = "Your Thynkdup has been Removed.  Let's Work on Some new Ideas."
      redirect_to nutshells_path
    end
  end

  protected

  def nutshell_params
    params.require(:nutshell).permit(:title, :content, :category_ids => [])
  end

  def logged_in?
    if current_user == nil
      flash[:notice] = "You must be logged in to view this page"
      redirect_to root_path
    end
  end
end









