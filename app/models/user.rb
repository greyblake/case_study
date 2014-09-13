class User < ActiveRecord::Base
  has_many :categories
  has_many :collections

  has_secure_password

  validates :password, length: { in: 8..32 }, on: :create
  validates :login, presence: true, uniqueness: true
end
