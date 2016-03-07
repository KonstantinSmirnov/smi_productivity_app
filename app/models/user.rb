class User < ActiveRecord::Base
  authenticates_with_sorcery!

  attr_accessor :skip_password

  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

  validates :name, length: { minimum: 3 }
  validates :email, uniqueness: true
  validates_format_of :email, with: EMAIL_REGEX
  validates :password, length: { minimum: 6 }, unless: :skip_password
  validates :password, confirmation: true




end
