require 'valid_formats'

class Article < ActiveRecord::Base
  belongs_to :channel, counter_cache: true
  has_many :users_articles

  include Tire::Model::Search
  include Tire::Model::Callbacks

  attr_accessible :channel, :description, :link, :published_at, :title

  validates :title, presence: true, uniqueness: { scope: :channel_id }
  validates :link, presence: true, format: { with: ValidFormats::URL }
  validates :channel_id, :description, :published_at, presence: true

  scope :most_recents, order("published_at DESC")

  def self.search(params)
    query = params[:query]

    tire.search(load: true) do
      query { string "description:#{query}", default_operator: "AND" } if query.present?
      sort { by :published_at, "desc" }
    end
  end
end
