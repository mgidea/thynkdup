class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :nutshells, inverse_of: :user

  has_many :notes, through: :nutshells

  has_many :profiles, inverse_of: :user

  has_many :thynkups, inverse_of: :user

  has_many :thynkers, through: :thynkups

  has_many :co_thynkups, class_name: "Thynkup", foreign_key: :thynker_id

  has_many :co_thynkers, through: :co_thynkups, source: :user


  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :role
  validates_inclusion_of :role, in: %w(member admin)

  def full_name
    first_name + " " + last_name
  end
end
