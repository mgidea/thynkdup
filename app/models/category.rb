class Category < ActiveRecord::Base
  validates_presence_of :name

  belongs_to :categorization,
    inverse_of: :categories
end
