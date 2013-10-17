require 'spec_helper'

describe Note do
  it { should     have_valid(:content).when("Hey how are you", "I AM GREAT") }
  it { should_not have_valid(:content).when(nil, "") }

  it { should     have_valid(:nutshell).when(Nutshell.new) }
  it { should_not have_valid(:nutshell).when(nil)}

  it { should     have_valid(:title).when("New", "OLD", " ", nil) }

  it { should belong_to :nutshell}
  it { should have_many(:users).through(:nutshell)}
end
