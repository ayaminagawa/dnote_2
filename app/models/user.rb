class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :omniauthable, :recoverable,
  :registerable, :rememberable, :trackable, omniauth_providers: [:twitter, :facebook]
  
  
  validates :name, length: { maximum: 15 }, presence: true
	# validates :gender, presence: true
	validates :email, uniqueness: true
  # VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :password, presence: true, length: {minimum: 6, maximum: 20}, on: :create
  validates :password, length: {minimum: 6, maximum: 120}, on: :update, allow_blank: true

	has_many :menus, dependent: :destroy 
  has_many :recipes, dependent: :destroy 
  has_many :made_reports, dependent: :destroy
	# has_secure_password
  has_many :favorites
  has_many :favorite_recipes, through: :favorites, source: :recipe
  has_many :favorite_menus, through: :favorites, source: :menu
  
  
  # def authenticated_image_url(style)
  #   image.s3_object(style).url_for(:read, :secure => true)
  # end

  has_attached_file :image, styles: { original: "1920x1680#",medium: "300x300>", thumb: "100x100>" },:url => "/images/:class/:attachment/:id_partition/:style/:filename", default_url:"assets/images/no_image.png"

  validates_attachment :image, 
  content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] },
  size: { less_than: 2.megabytes }

  has_many :columns, dependent: :destroy



  def User.year_list
    year_list = {}
    1930.upto 2015 do |i|
      year_list[i] = i
    end 
    return year_list
  end

  def User.month_list
    month_list = {}
    1.upto 12 do |i|
      month_list[i] = i
    end
    return month_list
  end

  def User.day_list
    day_list = {}
    1.upto 31 do |i|
      day_list[i] = i
    end
    return day_list
  end

  def User.calorie_list
    calorie_list = {}
    400.step(1200, 50) do |i|
      calorie_list[i] = i
    end
    return calorie_list
  end

  # 通常サインアップ時のuid用、Twitter OAuth認証時のemail用にuuidな文字列を生成
  def self.create_unique_string
    SecureRandom.uuid
  end

  # twitterではemailを取得できないので、適当に一意のemailを生成
  def self.create_unique_email
    User.create_unique_string + "@example.com"
  end


  def self.find_for_facebook_oauth(auth)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
    # file = open("http://graph.facebook.com/#{@user.facebook_id}/picture")
    # image_data = file.read
    # file_size = file.length
    # mime_type = "image/jpeg" #fb photos always are jpg
    user = User.new(name:    auth.extra.raw_info.name,
     provider: auth.provider,
     uid:      auth.uid,
     email:    auth.info.email,
     password: Devise.friendly_token[0,20],
     )
    # paperclip用に画像を扱う
    user.image = URI.parse(User.process_uri(auth.info.image)) if auth.info.image?
      user.save!
    end
    user
  end


  def self.find_for_twitter_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
      user = User.new(name:     auth.info.nickname,
       provider: auth.provider,
       uid:      auth.uid,
       email:    User.create_unique_email,
       password: Devise.friendly_token[0,20],
       )
      # paperclip用に画像を扱う
      user.image = URI.parse(User.process_uri(auth.info.image)) if auth.info.image?
      user.save!
    end
    user
  end

  def update_without_current_password(params, *options)
    params.delete(:current_password)
    
    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end
    
    result = update_attributes(params, *options)
    clean_up_passwords
    result
  end

  def favorite_recipe?(recipe)
    favorites.find_by(recipe_id: recipe.id)
    
  end

  def favorite_recipe!(recipe)
    favorites.create!(recipe_id: recipe.id)
  end

  def unfavorite_recipe!(recipe)
    favorites.find_by(recipe_id: recipe.id).destroy
  end

  def favorite_menu?(menu)
    favorites.find_by(menu_id: menu.id)
  end

  def favorite_menu!(menu)
    favorites.create!(menu_id: menu.id)
  end

  def unfavorite_menu!(menu)
    favorites.find_by(menu_id: menu.id).destroy
  end

  # Facebook, Twitterの画像を扱う
  def User.process_uri(uri)
    require 'open-uri'
    require 'open_uri_redirections'
    open(uri, :allow_redirections => :safe) do |r|
      r.base_uri.to_s
    end
  end

end