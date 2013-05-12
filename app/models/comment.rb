class Comment < ActiveRecord::Base
  attr_accessible :article_id, :body, :user_id

  belongs_to :article
  belongs_to :user

  validates :article_id, :body, :user_id, presence: true
end
