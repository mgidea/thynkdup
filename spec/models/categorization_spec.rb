require 'spec_helper'

describe Categorization do
  it { should     have_valid(:nutshell).when(Nutshell.new) }
  it { should_not have_valid(:nutshell).when(nil) }

  it { should     have_valid(:category).when(Category.new) }
  it { should_not have_valid(:category).when(nil) }

  it { should belong_to :nutshell}
  it { should belong_to :category}

end
