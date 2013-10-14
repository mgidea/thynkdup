class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :nutshells,
    inverse_of: :user

  has_many :notes,
    through: :nutshells

  validates_presence_of :first_name
  validates_presence_of :last_name
end
