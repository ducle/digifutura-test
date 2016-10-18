class FileNode < ApplicationRecord
  NODE_TYPES = {
    folder: "folder",
    file: "file"
  }

  belongs_to :parent, class_name: 'FileNode'
  has_many :children, class_name: 'FileNode', foreign_key: :parent_id
  belongs_to :owner, class_name: 'User', foreign_key: :owner_id
  has_and_belongs_to_many :users

  acts_as_list scope: :parent_id
  acts_as_taggable_on :labels

  scope :roots, -> { where(parent_id: nil) }

  before_save :caching_ancestry_values

  def is_folder?
    self.node_type == NODE_TYPES[:folder]
  end

  def is_file?
    self.node_type == NODE_TYPES[:file]
  end

  #  NOTE
  # from parent, grandparent, great grandparent...
  def ancestor_ids
    self.ancestry.split('/').map{|a| a.to_i}.reverse
  end

  #  NOTE
  # get parent, grandparent, and great grandparent
  def ancestors
    FileNode.where(id: ancestor_ids).order("LENGTH(ancestry) DESC")
  end

  def descendants
    where("LOWER(ancestry) LIKE ?", "#{self.ancestry}#{self.id}/%")
  end

  def add_child(node)
    node.parent_id = self.id
    node.save
  end

  private
  def caching_ancestry_values
    if self.parent
      self.ancestry = "#{parent.ancestry}#{self.parent_id}/"
    else
      self.ancestry = '/'
    end
  end
end
