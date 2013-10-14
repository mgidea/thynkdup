class NotesController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def new
    @nutshell = Nutshell.find(params[:nutshell_id])
    @note = @nutshell.notes.build
  end

  def edit
    @nutshell = Nutshell.find(params[:nutshell_id])
    @note = Note.find(params[:id])
  end

  def create
    @nutshell = Nutshell.find(params[:nutshell_id])
    @note = @nutshell.notes.build(note_params)
    if @nutshell.user == current_user
      if @note.save
        flash[:notice] = "Your note has been saved"
        redirect_to nutshell_path(@nutshell)
      else
        render 'new'
      end
    end
  end

  def update
    @nutshell = Nutshell.find(params[:nutshell_id])
    @note = Note.find(params[:id])
    if @nutshell.user == current_user
      if @note.update(note_params)
        flash[:notice] = "Your Note has been Updated"
        redirect_to nutshell_path(@nutshell)
      else
        render 'edit'
      end
    end
  end

  def show
  end

  def destroy
    @note = Note.find(params[:id])
    @nutshell = Nutshell.find(params[:nutshell_id])
    if @note.user == current_user
      @note.destroy
      flash[:notice] = "Your Note has been Removed.  Add new notes to continue to develop your Thynkdup"
      redirect_to nutshell_path(@nutshell)
    else
      redirect_to nutshells_path
    end
  end

protected
  def note_params
    params.require(:note).permit(:content, :title)
  end
end
