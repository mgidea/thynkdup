class Thynkup < ActiveRecord::Base
  belongs_to :user, inverse_of: :thynkups
  belongs_to :thynker, class_name: "User", inverse_of: :thynkups

  validates_presence_of :user
  validates_presence_of :thynker
  validates_inclusion_of :status, in: %w{requested pending linked}
end
