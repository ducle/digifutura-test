class Question < ApplicationRecord

  belongs_to :questionnaire
  has_many :answers, dependent: :destroy

  validates :content, :point, presence: true

  accepts_nested_attributes_for :answers, allow_destroy: true, reject_if: proc { |attributes| attributes['content'].blank? }

  before_validation :set_point

  private

  def set_point
    self.point ||= 0
  end
end
