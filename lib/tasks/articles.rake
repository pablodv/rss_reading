require 'feedzirra'

namespace :db do
  namespace :articles do
    desc "Fetch articles for each channel"

    task fetch: :environment  do
      Channel.find_each do |channel|
        feed = Feedzirra::Feed.fetch_and_parse(channel.url)

        if channel.etag != feed.etag
          channel.update_attribute :etag, feed.etag

          feed.entries.each do |entry|

            unless Article.exists? title: entry.title
              channel.articles.create!(
                title: entry.title,
                description: entry.summary,
                link: entry.url,
                published_at: entry.published)
            end
          end
        end
      end
    end
  end
end