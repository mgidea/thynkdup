class NotesController < ApplicationController
  before_action :set_note, only: [:edit, :update, :destroy]
  before_action :set_nutshell_id
  before_action :authenticate_user!
  before_action :wrong_note_user, except: [:index]

  def index
  end

  def new
    @note = @nutshell.notes.build
  end

  def edit
  end

  def create
    @note = @nutshell.notes.build(note_params)
    if @note.save
      flash[:notice] = "Your note has been saved"
      redirect_to nutshell_path(@nutshell)
    else
      render 'new'
    end
  end

  def update
    if @note.update(note_params)
      flash[:notice] = "Your Note has been Updated"
      redirect_to nutshell_path(@nutshell)
    else
      render 'edit'
    end
  end

  def show
  end

  def destroy
    @note.destroy
    flash[:notice] = "Your Note has been Removed.  Add new notes to continue to develop your Thynkdup"
    redirect_to nutshell_path(@nutshell)
  end

protected
  def note_params
    params.require(:note).permit(:content, :title)
  end

  def wrong_note_user
    if current_user != Nutshell.find(params[:nutshell_id]).user
      flash[:notice] = "This is not your Thynkdup"
      redirect_to nutshells_path
    end
  end

  def set_nutshell_id
    @nutshell = Nutshell.find(params[:nutshell_id])
  end

  def set_note
    @note = Note.find(params[:id])
  end
end
