class UsersArticle < ActiveRecord::Base
  belongs_to :user
  belongs_to :article

  attr_accessible :article, :user

  validates :user_id, presence: true
  validates :article_id, presence: true, uniqueness: { scope: :user_id }
end
