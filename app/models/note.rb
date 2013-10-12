class Note < ActiveRecord::Base
  validates_presence_of :content

  belongs_to :nutshell,
    inverse_of: :notes
end
