class Item < ActiveRecord::Base
  mount_uploader :image, ItemImageUploader
  has_and_belongs_to_many :users
end
