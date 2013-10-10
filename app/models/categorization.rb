class Categorization < ActiveRecord::Base
  validates_presence_of :nutshell_id
  validates_presence_of :category_id

  belongs_to :nutshell,
    inverse_of: :categorizations

  belongs_to :category,
    inverse_of: :categorizations
end
