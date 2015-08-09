class MadeReport < ActiveRecord::Base
	has_attached_file :image, styles: { original: "1920x1680#",medium: "300x300>", thumb: "100x100>" }, default_url: "assets/images/no_image.png"

 validates_attachment :image,
 content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] },
 size: { less_than: 2.megabytes }
 belongs_to :recipe
 belongs_to :user
end
