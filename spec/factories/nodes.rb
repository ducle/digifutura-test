FactoryGirl.define do
  factory :file_node do
    association :owner, factory: :user


      name    Faker::Lorem.word
      node_type FileNode::NODE_TYPES[:folder]
  end
end
