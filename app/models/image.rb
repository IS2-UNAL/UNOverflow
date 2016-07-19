class Image < ApplicationRecord
  mount_uploader :image, ImageUploader
  validates_processing_of :image
  validate :image_size_validation
  belongs_to :comment
  belongs_to :post
  private
    def image_size_validation
      errors[:image] << "Should be less than 500KB" if image.size > 0.5.megabytes
    end
end
