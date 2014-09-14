class Picture < ActiveRecord::Base
  belongs_to :monument

  validates :monument, :name, :description, presence: true

  has_attached_file :picture, :styles => { :large => "800x800>", :thumb => "300x300>" }
  validates_attachment_content_type :picture, :content_type => /\Aimage\/.*\Z/
end
