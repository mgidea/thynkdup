class Categorization < ActiveRecord::Base
  # validates_presence_of :nutshell
  # validates_presence_of :category

  belongs_to :nutshell,
    inverse_of: :categorizations

  belongs_to :category,
    inverse_of: :categorizations
end
