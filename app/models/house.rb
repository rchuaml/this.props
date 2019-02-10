class House < ApplicationRecord
  belongs_to :user
  has_many :interests
  has_many :chaxbox_message
  has_many :buyer_seller
  has_many_attached :images

  validates :name, :location, :lat, :long, :price, :bedrooms, :bathrooms, :floor_area, :floor_levels, :lease_left, presence: true, on: :create

   def image_path
    ActiveStorage::Blob.service.send(:path_for, image.key)
  end
end