class Workspace < ActiveRecord::Base
  validates :title, presence: true

  has_and_belongs_to_many :users
  has_many :projects, dependent: :destroy
end
