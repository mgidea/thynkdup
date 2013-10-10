class ContextualizationsController < ApplicationController
  def create
    @nutshell = Nutshell.find(params[:nutshell_id])
    @categorization = @nutshell.categorizations.build(categorization_params)
    if @nutshell.create
      redirect_to nutshell_path(@nutshell)
    else
      @categorization = Categorization.new
      render "nutshells/show"
    end
  end

protected
  def categorization_params
    params.require(:categorization).permit(:nutshell_id, :category_id)
  end
end
