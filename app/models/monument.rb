class Monument < ActiveRecord::Base
  belongs_to :category
  belongs_to :collection

  has_many :pictures, :dependent => :destroy

  validates :category, :collection, :name, :description, presence: true
end
