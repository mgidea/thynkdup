class Thynkup < ActiveRecord::Base
  scope :requested, -> { where ({status: "requested"}) }
  scope :pending,   -> { where ({status: "pending"}) }
  scope :linked,    -> { where ({status: "linked"}) }

  attr_accessor :opposing

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

  def pending?
    self.status == "pending"
  end

  def requested?
    self.status == "requested"
  end

  def linked?
    self.status == "linked"
  end

  def opposing
    @opposing ||= Thynkup.where(friend_id: self.thynker_id, thynker_id: self.friend_id).first
  end

  def accept_thynkup
    if pending? || requested?
      self.status = "linked"
      self.save!
      opposing.status = "linked"
      opposing.save!
    end
  end

  def reject_thynkup
    if pending? || requested?
      self.destroy
      opposing.destroy
    end
  end

  def destroy_thynkup
    if linked?
      self.destroy
    end
  end
end
