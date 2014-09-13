class Picture < ActiveRecord::Base
  belongs_to :monument

  validates :monument, :name, :description, presence: true
end
