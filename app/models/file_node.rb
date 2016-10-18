class FileNode < ApplicationRecord
  NODE_TYPES = {
    folder: "folder",
    file: "file"
  }

  belongs_to :parent, class_name: 'FileNode', optional: true
  has_many :children, class_name: 'FileNode', foreign_key: :parent_id
  belongs_to :owner, class_name: 'User', foreign_key: :owner_id, optional: true

  has_and_belongs_to_many :users

  mount_uploader :file, FileUploader

  acts_as_list scope: :parent_id
  acts_as_taggable_on :labels

  scope :roots, -> { where(parent_id: nil) }
  scope :folders, -> { where(node_type: NODE_TYPES[:folder])}
  scope :files, -> { where(node_type: NODE_TYPES[:file]) }

  before_save :caching_ancestry_values

  def is_folder?
    self.node_type == NODE_TYPES[:folder]
  end

  def is_file?
    self.node_type == NODE_TYPES[:file]
  end

  # from parent, grandparent, great grandparent...
  def ancestor_ids
    self.ancestry.split('/').map{|a| a.to_i}.reverse
  end

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

  def can_view_by_user?(user)
    owner_id == user.id ||
    user.accessible_file_nodes.pluck(:id).include?(self.id) ||
    (user.accessible_file_nodes.pluck(:id) & ancestor_ids).any?
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
