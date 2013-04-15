require 'valid_formats'
require 'feedzirra'

class Channel < ActiveRecord::Base
  belongs_to :user

  attr_accessible :name, :url, :user_id

  validates :user_id, presence: true
  validates :url, presence: true, format: { with: ValidFormats::URL }
  validates :name, presence: true, uniqueness: { scope: :user_id }

  before_validation :fetch_and_validate_feed, on: :create

  private

  def fetch_and_validate_feed
    if url.present?
      feed = Feedzirra::Feed.fetch_and_parse(url)
      if feed != nil && feed != 0
        self.name = feed.title
      else
        self.errors.add :url, "Invalid url or contain by RSS/Atom url"
      end
    end
  end
end
