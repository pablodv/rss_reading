class User < ActiveRecord::Base
  PROFILES = ["basic - 10 channels", "medium - 20 channels", "premium - 100 channels"]

  has_many :authentications
  has_many :channels
  has_many :users_articles
  has_many :favorites, through: :users_articles, source: :article
  has_many :articles, through: :channels

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2, :twitter]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :first_name, :last_name, :email, :password,
                  :password_confirmation, :remember_me, :avatar, :profile_type

  validates :username, :first_name, :last_name, presence: true, length: {maximum: 50}

  has_attached_file :avatar,
    styles: { large: "400x400#", medium: "200x200#", thumb: "100x100#" }

  validates_attachment :avatar,
    content_type: { content_type: ['image/jpeg', 'image/png'] },
    size: { in: 0..2.megabytes }

  def self.find_or_create_with_omniauth(auth)
    user = nil

    if authentication = Authentication.find_with_omniauth(auth)
      user = authentication.user

    elsif user = User.where(email: auth.info.email).first
      user.authentications.create_with_omniauth(auth)

    else
      user = User.new_with_omniauth(auth)
      user.save(validate: false)
      user.confirm!
      user.authentications.create_with_omniauth(auth)
    end

    user
  end

  def self.new_with_omniauth(auth)
    User.new(
      first_name: auth.info.first_name || auth.info.name.split(" ")[0],
      last_name: auth.info.first_name || auth.info.name.split(" ")[1],
      username: auth.info.nickname || auth.info.email.split("@")[0],
      email: auth.info.email)
  end
end
