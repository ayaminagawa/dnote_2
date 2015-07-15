class Menu < ActiveRecord::Base
	belongs_to :user
	# validates :name, presence: true
	# has_many :recipes, as: :menu_recipes
  has_many :recipes, through: :menu_recipes
	has_many :favorites
  has_many :favoriting_users, through: :favorites, source: :user
  has_many :menu_recipes, :class_name => "MenuRecipe", dependent: :destroy
  validates :name, presence: true
  has_many :category_selects, :class_name => "CategorySelect", :dependent => :destroy
  accepts_nested_attributes_for :category_selects
  accepts_nested_attributes_for :menu_recipes, :allow_destroy => true


  has_attached_file :image, styles: { original: "1920x1680#",medium: "300x300>", thumb: "100x100>" }, default_url: "/system/missing/:style/missing.jpg"

  validates_attachment :image,
  content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] },
  size: { less_than: 2.megabytes }

  def main_recipe
    self.recipes.select{|recipe| recipe.recipe_select == 1}.first
  end

  def side_recipes
    self.recipes.select{|recipe| recipe.recipe_select == 2}.compact
  end
end
