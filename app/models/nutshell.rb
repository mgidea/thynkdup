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

  NEEDLESS_WORDS = %w{is a an and the it my that after although though because before even if
   only now once rather since so than until when whenever where while}

  def create_keywords
    words = title + " " + content
    self.keywords = words.downcase.split.reject{|word| word.in?(NEEDLESS_WORDS)}.uniq!
  end
end
