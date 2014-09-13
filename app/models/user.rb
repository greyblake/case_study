class User < ActiveRecord::Base
  has_many :categories
  has_many :collections

  has_secure_password

  validates :password, presence: true, length: { in: 8..32 }, on: :create
  validates :login,    presence: true
end