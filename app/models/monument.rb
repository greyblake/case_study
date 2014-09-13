class Monument < ActiveRecord::Base
  belongs_to :category
  belongs_to :collection

  validates :category, :collection, :name, :description, presence: true
end
