class Profile < ActiveRecord::Base
  validates_presence_of :user

  belongs_to :user,
    inverse_of: :profiles
end
