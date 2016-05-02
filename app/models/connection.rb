class Connection < ActiveRecord::Base
  belongs_to :user
  belongs_to :workspace

  enum role: [:user, :admin, :pending]
end
