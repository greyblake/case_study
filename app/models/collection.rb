class Collection < ActiveRecord::Base
  belongs_to :user

  has_many :monuments

  validates :user, :name, presence: true
end
