class Thynkup < ActiveRecord::Base
  belongs_to :friend, class_name: "User", inverse_of: :thynkups
  belongs_to :thynker, class_name: "User", inverse_of: :thynkups

  after_create :reverse_thynkup
  validates_presence_of :friend
  validates_presence_of :thynker
  validates_inclusion_of :status, in: %w{requested pending linked}

  def reverse_thynkup
    unless Thynkup.where(friend_id: self.thynker_id, thynker_id: self.friend_id).any?
      Thynkup.create(friend_id: self.thynker_id, thynker_id: self.friend_id, status: "pending")
    end
  end
end
