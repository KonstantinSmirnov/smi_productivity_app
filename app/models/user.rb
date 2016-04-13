class User < ActiveRecord::Base
  authenticates_with_sorcery!

  attr_accessor :skip_password

  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

  validates :name, length: { minimum: 3 }
  validates :email, uniqueness: true
  validates_format_of :email, with: EMAIL_REGEX
  validates :password, length: { minimum: 6 }, unless: :skip_password
  validates :password, confirmation: true

  has_attached_file :avatar, :styles => { :normal => "96x96#" },
                  :default_style => :normal,
                  :default_url => 'avatar_default.png'
  validates_attachment_content_type :avatar, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  has_many :projects, dependent: :destroy #?
  has_many :comments, dependent: :destroy #?

  has_and_belongs_to_many :workspaces
  # Selected workspace
  belongs_to :workspace
end
