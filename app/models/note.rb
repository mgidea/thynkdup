class Note < ActiveRecord::Base
  validates_presence_of :content
  validates_presence_of :nutshell

  belongs_to :nutshell,
    inverse_of: :notes

  has_many :users,
    through: :nutshell
end
