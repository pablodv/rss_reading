class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :first_name, :last_name, :email, :password,
                  :password_confirmation, :remember_me, :avatar

  validates :username, :first_name, :last_name, presence: true, length: {maximum: 50}

  has_attached_file :avatar,
    styles: { large: "400x400#", medium: "200x200#", thumb: "100x100#" }

  validates_attachment :avatar, presence: true,
    content_type: { content_type: ['image/jpeg', 'image/png'] },
    :size => { :in => 0..2.megabytes }
end
