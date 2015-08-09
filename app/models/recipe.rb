class Recipe < ActiveRecord::Base
	belongs_to :user
	belongs_to :menu
  has_many :recipe_feelings, dependent: :destroy
  accepts_nested_attributes_for :recipe_feelings, :allow_destroy => true, :reject_if => :reject_feeling
	has_many :menus, as: :menu_recipes
	has_many :menu_recipes, :class_name => "MenuRecipe", dependent: :destroy
	validates :name, presence: true
	has_many :favorites
  has_many :favoriting_users, through: :favorites, source: :user
  has_many :made_reports, dependent: :destroy
  has_many :ingredients, :class_name => "Ingredient", dependent: :destroy
  accepts_nested_attributes_for :ingredients, :allow_destroy => true, :reject_if => :reject_ingredient

  has_many :procedures, :class_name => "Procedure", :dependent => :destroy
  accepts_nested_attributes_for :procedures, :allow_destroy => true, :reject_if => :reject_procedure

  has_many :category_selects, :class_name => "CategorySelect", :dependent => :destroy
  accepts_nested_attributes_for :category_selects
  
  has_attached_file :image, styles: { original: "1920x1680#", thumb: "100x100>" }, default_url: "assets/images/no_image.png"

  validates_attachment :image,
  content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] },
  size: { less_than: 2.megabytes }
  # validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  
  # def authenticated_image_url(style)
  #   image.s3_object(style).url_for(:read, :secure => true)
  # end

  validate :check_calorie
  validate :check_sugar

  def check_calorie
    if user.permission != nil && !calorie
      errors.add(:calorie, 'を入力してください')
    end
  end

  def check_sugar
    if user.permission != nil && !sugar
      errors.add(:sugar, 'を入力してください')
    end
  end

  def main?
    recipe_select == 1
  end

  def sub?
    recipe_select == 2
  end

	def self.search(search) #self.でクラスメソッドとしている
    if search # Controllerから渡されたパラメータが!= nilの場合は、titleカラムを部分一致検索
      # Recipe.where(['name LIKE ?', "%#{search}%"])
      # Recipe.where(['tip LIKE ?', "%#{search}%"])
      Recipe.where(['name LIKE ? or tip LIKE ? or description LIKE ?', "%#{search}%", "%#{search}%", "%#{search}%"])
    else
      Recipe.all #全て表示。
    end
  end

  def self.kinds
    {
     "1" => "野菜のおかず",
     "2" => "お肉のおかず",
     "3" => "魚介のおかず",
     "4" => "ごはんもの",
     "5" => "パスタ・グラタン",
     "6" => "麺類",
     "7" => "サラダ",
     "8" => "スープ・汁物",
     "9" => "お弁当",
     # "10" => "おもてなし料理",
     "11" => "お菓子・デザート",
     "12" => "パン",
     "13" => "大豆のおかず"
   }
  end

  def self.categories
    {
      "2" => "糖質制限食",
      "3" => "HbA1c、血糖値の安定",
      "4" => "味に自信あり",
      "5" => "すぐできるメニュー",
      "6" => "その他"
    }
  end

  def self.kinds2
    {
      1 => "野菜のおかず",
      2 => "お肉のおかず",
      3 => "魚介のおかず",
      4 => "ごはんもの",
      5 => "パスタ・グラタン",
      6 => "麺類",
      7 => "サラダ",
      8 => "スープ・汁物",
      9 => "お弁当",
      # 10 => "おもてなし料理",
      11 => "お菓子・デザート",
      12 => "パン",
      13 => "大豆のおかず"
    }
  end

  def self.arr
    [ 
      [ "1", "category-icon/yasai.png", "野菜のおかず" ],
      [ "2", "category-icon/oniku.png", "お肉のおかず" ],
      [ "3", "category-icon/gyokai.png", "魚介のおかず" ],
      [ "4", "category-icon/gohanmono.png", "ごはんもの" ],
      [ "5", "category-icon/pasta.png", "パスタ・グラタン" ],
      [ "6", "category-icon/men.png", "麺類" ],
      [ "7", "category-icon/salada.png", "サラダ" ],
      [ "8", "category-icon/soup.png", "スープ・汁物" ],
      [ "9", "category-icon/obento.png", "お弁当" ],
      # [ "10", "category-icon/omotenashi.png", "おもてなし料理" ],
      [ "11", "category-icon/okashi.png", "お菓子・デザート" ],
      [ "12", "category-icon/pan.png", "パン" ],
      [ "13", "", "大豆のおかず"]
    ]
  end

  private

    def reject_ingredient(attributed)
      attributed['name'].blank?
    end

    def reject_procedure(attributed)
      attributed['body'].blank?
    end

    def reject_feeling(attributed)
      attributed['feeling'] == "0"
    end


end
