require 'spec_helper'

describe Nutshell do
  it { should     have_valid(:title).when("IDEAS", "I love it") }
  it { should_not have_valid(:title).when(nil, " ") }

  it { should     have_valid(:content).when("Lots of great Ideas", "I love it") }
  it { should_not have_valid(:content).when(nil, " ", "I" * 81) }

  it { should     have_valid(:user).when(User.new) }
  it { should_not have_valid(:user).when(nil) }

  it { should belong_to :user }
  it { should have_many :categorizations }
  it { should have_many :notes}
end
