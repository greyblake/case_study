class Category < ActiveRecord::Base
  belongs_to :user

  has_many :monuments, :dependent => :destroy

  validates :user, :name, presence: true
end
