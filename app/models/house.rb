class House < ApplicationRecord
  belongs_to :user
  has_many :interests
  has_one_attached :image
   def image_path
    ActiveStorage::Blob.service.send(:path_for, image.key)
  end
end