class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :file_nodes, foreign_key: :owner_id
  has_and_belongs_to_many :accessible_file_nodes, class_name: 'FileNode'

  validates :name, presence: true, length: {minimum: 2, maximum: 40}
end
