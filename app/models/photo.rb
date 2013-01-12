class Photo < ActiveRecord::Base
  attr_accessible :deal_id, :fb_photo_id, :name, :image
  belongs_to :deal

  mount_uploader :image, ImageUploader
end
