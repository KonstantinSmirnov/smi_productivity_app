class Task < ActiveRecord::Base

  validates :title, presence: true
  belongs_to :project
  has_many :comments, dependent: :destroy

end
