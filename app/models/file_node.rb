class FileNode < ApplicationRecord
  belongs_to :parent, class_name: 'FileNode'
  has_many :children, class_name: 'FileNode', foreign_key: :parent_id
  belongs_to :owner, class_name: 'User', foreign_key: :owner_id
  has_and_belongs_to_many :users

  acts_as_list scope: :parent_id
  acts_as_taggable_on :labels

  scope :roots, -> { where(parent_id: nil) }

  before_save :caching_ancestry_values

  def descendants
    where("LOWER(ancestry) LIKE ?", "#{self.ancestry}/%")
  end

  def add_child(node)
    node.parent_id = self.id
    node.save
  end

  private
  def caching_ancestry_values
    if self.parent
      self.ancestry = [parent.ancestry, self.parent_id].compact.join('/')
    end
  end
end
