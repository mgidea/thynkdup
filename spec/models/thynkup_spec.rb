require 'spec_helper'

describe Thynkup do
  it { should     have_valid(:friend).when(User.new) }
  it { should_not have_valid(:friend).when(nil) }

  it { should     have_valid(:thynker).when(User.new) }
  it { should_not have_valid(:thynker).when(nil) }

  it { should     have_valid(:status).when("requested", "pending", "linked") }
  it { should_not have_valid(:status).when("request", "friends", "", nil) }

  it { should belong_to :friend }
  it { should belong_to :thynker }

  it "creates an opposing thynkup" do
    prev_count = Thynkup.count
    connection = FactoryGirl.create(:thynkup)
    other = Thynkup.last

    expect(prev_count).to eql(Thynkup.count - 2)
    expect(connection.status).to eql("requested")
    expect(other.status).to eql("pending")
    expect(connection.friend_id).to eql(other.thynker_id)
  end

  it "can find by scope" do
    FactoryGirl.create_list(:thynkup, 5)
    list = Thynkup.last(5)
    first, second, third, fourth, fifth = list
    first.accept_thynkup
    second.reject_thynkup

    expect(Thynkup.pending.count).to eql(Thynkup.requested.count)
    expect(Thynkup.linked.count).to eql(2)
  end

  it "can accept a thynkup" do
    pending
  end

  it "can reject a thynkdup" do
    pending
  end
end
