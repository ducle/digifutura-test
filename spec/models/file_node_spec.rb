require 'rails_helper'

RSpec.describe FileNode, type: :model do

  it { should belong_to(:owner) }
  it { should have_and_belong_to_many(:users) }
end
