require 'rails_helper'

RSpec.describe User, type: :model do

  it "should be valid with factory method" do
    user = build(:user)
    user.should be_valid
  end

  it { should have_many(:file_nodes) }
  it { should have_and_belong_to_many(:accessible_file_nodes) }
end
