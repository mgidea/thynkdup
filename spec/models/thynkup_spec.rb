require 'spec_helper'

describe Thynkup do
  it { should     have_valid(:friend).when(User.new) }
  it { should_not have_valid(:friend).when(nil) }

  it { should     have_valid(:thynker).when(User.new) }
  it { should_not have_valid(:thynker).when(nil) }

  it { should     have_valid(:status).when("requesting", "pending", "linked") }
  it { should_not have_valid(:status).when("request", "friends", "", nil) }

  it { should belong_to :friend }
  it { should belong_to :thynker }

  it "creates an opposing thynkup" do
    prev_count = Thynkup.count
    connection = FactoryGirl.create(:thynkup)
    other = Thynkup.last

    expect(prev_count).to eql(Thynkup.count - 2)
    expect(connection.status).to eql("requesting")
    expect(other.status).to eql("pending")
    expect(connection.friend_id).to eql(other.thynker_id)
  end

  it "can find by scope" do
    FactoryGirl.create_list(:thynkup, 5)
    list = Thynkup.last(5)
    first, second, third, fourth, fifth = list
    first.accept_thynkup
    second.reject_thynkup

    expect(Thynkup.pending.count).to eql(Thynkup.requesting.count)
    expect(Thynkup.linked.count).to eql(2)
  end

  it "can accept a thynkup" do
    prev_linked_count = Thynkup.linked.count
    thynkup = FactoryGirl.create(:thynkup)
    opposite = thynkup.opposing
    prev_thynkups = Thynkup.count
    prev_requesting_count, prev_pending_account = Thynkup.requesting.count, Thynkup.pending.count
    opposite.accept_thynkup

    expect(Thynkup.linked.count).to eql(prev_linked_count + 2)
    expect(Thynkup.requesting.count).to eql(prev_requesting_count - 1)
    expect(Thynkup.pending.count).to eql(prev_pending_account - 1)
    expect(Thynkup.count).to eql(prev_thynkups)
  end

  it "can reject a thynkdup" do
    prev_linked_count = Thynkup.linked.count
    thynkup = FactoryGirl.create(:thynkup)
    opposite = thynkup.opposing
    prev_thynkups = Thynkup.count
    prev_requesting_count, prev_pending_account = Thynkup.requesting.count, Thynkup.pending.count
    opposite.reject_thynkup

    expect(Thynkup.linked.count).to eql(prev_linked_count)
    expect(Thynkup.requesting.count).to eql(prev_requesting_count - 1)
    expect(Thynkup.pending.count).to eql(prev_pending_account - 1)
    expect(Thynkup.count).to eql(prev_thynkups - 2)
  end

  it "each thynkup can check its status" do
    thynkup = FactoryGirl.create(:thynkup)
    opposite = thynkup.opposing

    expect(thynkup.linked? && opposite.linked?).to eql(false)
    expect(thynkup.requesting? && opposite.pending?).to eql(true)
    expect(thynkup.pending? && opposite.requesting?).to eql(false)
  end

  it "can destroy a linked thynkup" do
    thynkup = FactoryGirl.create(:thynkup)
    prev_count = Thynkup.count
    opposite = thynkup.opposing

    opposite.destroy_thynkup
    expect(Thynkup.count).to eql(prev_count)
    opposite.accept_thynkup
    opposite.destroy_thynkup
    expect(Thynkup.count).to eql(prev_count - 2)
  end
end
