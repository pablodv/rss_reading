class Authentication < ActiveRecord::Base
  belongs_to :user

  attr_accessible :provider, :uid

  validates :provider, :uid, presence: true

  def self.find_with_omniauth(auth)
    where(provider: auth['provider'], uid: auth['uid']).first
  end

  def self.create_with_omniauth(auth)
    create(uid: auth['uid'], provider: auth['provider'])
  end
end
