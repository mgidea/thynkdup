class Nutshell < ActiveRecord::Base
  validates_presence_of :user
  validates_presence_of :title
  validates_presence_of :content
  validates_length_of :content, maximum: 80

  belongs_to :user,
    inverse_of: :nutshells
end
