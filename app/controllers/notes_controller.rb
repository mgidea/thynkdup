class NotesController < ApplicationController

  def index
  end

  def new
    @nutshell = Nutshell.find(params[:nutshell_id])
    @note = @nutshell.notes.build
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

  def show

  end

protected
  def note_params
    params.require(:note).permit(:content)
  end
end
