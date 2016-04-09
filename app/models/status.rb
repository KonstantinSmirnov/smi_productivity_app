class Status < ActiveRecord::Base
  validates :text, presence: true

  belongs_to :user
  belongs_to :project

  enum color: [:red, :yellow, :green]
end
