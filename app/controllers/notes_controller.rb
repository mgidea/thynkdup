class NotesController < ApplicationController

  def index
  end

  def new
    @nutshell = Nutshell.find(params[:nutshell_id])
    @note = @nutshell.notes.build
  end

  def create
  end

  def show

  end

protected
  def note_params
    params.require(:note).permit(:content)
  end
end
