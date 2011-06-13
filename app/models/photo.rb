class Photo < ActiveRecord::Base
  belongs_to :album
  validates_presence_of :image_path
end
