class Workspace < ActiveRecord::Base
  validates :title, presence: true

  has_many :connections
  has_many :users, :through => :connections
  has_many :projects, dependent: :destroy

end
