class Project < ActiveRecord::Base

  validates :title, presence: true

  belongs_to :user
  has_many :tasks, dependent: :destroy
  has_many :statuses, dependent: :destroy

  enum condition: [:active, :archived]
end
