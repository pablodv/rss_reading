every 5.minutes do
  rake "db:articles:fetch"
end

every 24.hours do
  rake "db:users:send_feeds"
end
