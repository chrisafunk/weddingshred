
# lib/tasks/media_check.rake
require "net/http"
namespace :media do
  desc "HEAD-check thumbnail_url and video_url on Exercises"
  task check: :environment do
    bad = []
    Exercise.find_each do |e|
      {thumb: e.thumbnail_url, video: e.video_url}.each do |kind, url|
        next if url.blank?
        uri = URI.parse(url) rescue nil
        unless uri
          bad << [e.name, kind, "invalid URL"]
          next
        end
        res = Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == "https") do |http|
          http.head(uri.request_uri)
        end
        bad << [e.name, kind, res.code] unless res.code.to_i == 200
      end
    end
    if bad.any?
      puts "Broken links:"
      bad.each { |row| puts row.join(" | ") }
      exit 1
    else
      puts "All media links OK."
    end
  end
end
