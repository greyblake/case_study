class Category < ActiveRecord::Base
  belongs_to :user

  validates :user, :name, presence: true
end