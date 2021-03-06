require 'rails_helper'

RSpec.describe UserAnswer, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:answer) }
end
