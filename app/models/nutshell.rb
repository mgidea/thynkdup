class Nutshell < ActiveRecord::Base
  validates_presence_of :user
  validates_presence_of :title
  validates_presence_of :content

  validates_length_of :content, maximum: 80

  belongs_to :user,
    inverse_of: :nutshells

  has_many :categorizations,
    inverse_of: :nutshell

  accepts_nested_attributes_for :categorizations

  has_many :categories,
    through: :categorizations

  def nutshell_owner?(user)
    pluck(:user_id).include?(user.id)
  end
end
