class Update < ActiveRecord::Base
  validates :text, presence: true
  
  belongs_to :user
  belongs_to :project
  
  enum status: [:red, :yellow, :green]
end