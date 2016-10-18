require 'rails_helper'

RSpec.describe User, type: :model do

  it { should have_many(:file_nodes) }
  it { should have_and_belong_to_many(:accessible_file_nodes) }
end
