class Nutshell < ActiveRecord::Base
  validates_presence_of :user
  validates_presence_of :title
  validates_presence_of :content
  serialize :keywords, Array
  validates_length_of :content, maximum: 80

  belongs_to :user,
    inverse_of: :nutshells

  has_many :categorizations,
    inverse_of: :nutshell

  accepts_nested_attributes_for :categorizations

  has_many :categories,
    through: :categorizations

  has_many :notes,
    inverse_of: :nutshell,
    dependent: :destroy
  NEEDLESS_WORDS = %w{is a an and the it my that}

  def create_keywords
    self.keywords = content.downcase.split.reject{|word| NEEDLESS_WORDS.include?(word)}

  end
end
