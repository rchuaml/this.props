class House < ApplicationRecord
  belongs_to :user
  has_many :interests
  has_one_attached :image

  validates :name, :location, :lat, :long, :price, :bedrooms, :bathrooms, :floor_area, :furnishing, :floor_levels, :lease_left, presence: true, on: :create

   def image_path
    ActiveStorage::Blob.service.send(:path_for, image.key)
  end
end