class Monument < ActiveRecord::Base
  belongs_to :category
  belongs_to :collection

  has_many :pictures

  validates :category, :collection, :name, :description, presence: true
end
