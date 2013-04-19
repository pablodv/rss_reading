require 'valid_formats'

class Article < ActiveRecord::Base
  belongs_to :channel, counter_cache: true
  has_many :users_articles

  attr_accessible :channel, :description, :link, :published_at, :title

  validates :title, presence: true, uniqueness: { scope: :channel_id }
  validates :link, presence: true, format: { with: ValidFormats::URL }
  validates :channel_id, :description, :published_at, presence: true

  scope :most_recents, order("published_at DESC")
end
