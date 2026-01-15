# lib/tasks/plugin_assets.rake
require 'pp'

namespace :assets do
  desc "Generate PLUGIN_ASSETS hash from plugins directories (including subfolders)"
  task generate_plugin_assets: :environment do
    plugin_dirs = Dir.glob("app/assets/javascripts/plugins/*") +
                  Dir.glob("app/assets/stylesheets/plugins/*")
    plugin_dirs = plugin_dirs.select { |f| File.directory?(f) }
    plugin_names = plugin_dirs.map { |d| File.basename(d) }.uniq

    plugin_assets = {}

    plugin_names.each do |plugin|
      js_files = Dir.glob("app/assets/javascripts/plugins/#{plugin}/**/*.js").map do |f|
        "plugins/#{plugin}/" + f.split("/plugins/#{plugin}/", 2).last.sub(/\.js$/, "")
      end
      css_files = Dir.glob("app/assets/stylesheets/plugins/#{plugin}/**/*.css").map do |f|
        "plugins/#{plugin}/" + f.split("/plugins/#{plugin}/", 2).last.sub(/\.css$/, "")
      end
      entry = {}
      entry[:js] = js_files unless js_files.empty?
      entry[:css] = css_files unless css_files.empty?
      plugin_assets[plugin.to_sym] = entry unless entry.empty?
    end

    pp plugin_assets
  end
end
