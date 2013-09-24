class Nutshell < ActiveRecord::Base
  validates_presence_of :user
  validates_presence_of :title
  validates_presence_of :content

  belongs_to :user,
    inverse_of: :nutshells
end
