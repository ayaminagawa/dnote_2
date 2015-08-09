class Nutritionist < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable

  validates :name, presence: true

  has_many :columns

  has_attached_file :image, styles: { original: "1920x1680>",medium: "300x300>", thumb: "100x100>" },:url => "/images/:class/:attachment/:id_partition/:style/:filename", default_url: "assets/images/no_image.png"

  validates_attachment :image, 
  content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] },size: { less_than: 2.megabytes }

end
