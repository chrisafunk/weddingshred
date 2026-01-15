
# lib/tasks/gymove.rake
namespace :gymove do
  desc "Install Gymove theme + ALL vendor plugins into app/assets/**. Set GYMOVE_SRC=/abs/path or place under vendor/gymove_src"
  task :install => :environment do
    require "fileutils"
    root = Rails.root
    src  = ENV["GYMOVE_SRC"] || root.join("vendor", "gymove_src")
    abort "Gymove source not found: #{src}" unless Dir.exist?(src.to_s)

    # Destinations
    css_root   = root.join("app/assets/stylesheets/gymove")
    js_root    = root.join("app/assets/javascripts/gymove")
    img_root   = root.join("app/assets/images/gymove")
    fonts_root = root.join("app/assets/fonts/gymove")
    [css_root, js_root, img_root, fonts_root].each { |d| FileUtils.mkdir_p(d) }

    def copy_all(src_glob, dst_base, rel_base:)
      copied_any = false
      Dir[src_glob].each do |path|
        next unless File.file?(path)
        rel = Pathname.new(path).relative_path_from(Pathname.new(rel_base))
        dst = File.join(dst_base.to_s, rel.dirname.to_s)
        FileUtils.mkdir_p(dst)
        FileUtils.cp(path, File.join(dst, File.basename(path)), preserve: true)
        copied_any = true
      end
      copied_any
    end

    # ---- 1) Theme assets from common locations (non-plugin) ----
    theme_copied = false
    {
      "css"          => css_root,
      "assets/css"   => css_root,
      "js"           => js_root,
      "assets/js"    => js_root,
      "images"       => img_root,
      "assets/images"=> img_root,
      "fonts"        => fonts_root,
      "assets/fonts" => fonts_root
    }.each do |sub, dst|
      base = File.join(src.to_s, sub)
      next unless Dir.exist?(base)
      puts "Copy theme #{sub}: #{base} -> #{dst}"
      FileUtils.cp_r(Dir[File.join(base, "*")], dst, remove_destination: true)
      theme_copied = true
    end

    # ---- 2) ALL vendor plugins ----
    vendor_dir = File.join(src.to_s, "vendor")
    plugins = Dir[vendor_dir, "*"].select { |d| File.directory?(d) } rescue []
    plugins.each do |plug_dir|
      plug_name = File.basename(plug_dir).downcase

      # Copy ALL .css anywhere in plugin -> stylesheets/gymove/plugins/<plugin>/... (preserve tree)
      css_dst = css_root.join("plugins", plug_name)
      css_copied = copy_all(File.join(plug_dir, "**", "*.css"), css_dst, rel_base: plug_dir)
      puts "CSS: #{plug_name} -> #{css_dst}" if css_copied

      # Copy ALL .js anywhere in plugin -> javascripts/gymove/plugins/<plugin>/... (preserve tree)
      js_dst = js_root.join("plugins", plug_name)
      js_copied = copy_all(File.join(plug_dir, "**", "*.js"), js_dst, rel_base: plug_dir)
      puts "JS:  #{plug_name} -> #{js_dst}" if js_copied

      # Copy supporting asset folders (preserve tree) NEXT TO CSS so relative paths work
      %w[images img icons fonts webfonts].each do |asset_dir|
        Dir[File.join(plug_dir, "**", asset_dir)].select { |d| File.directory?(d) }.each do |asset_src|
          rel     = Pathname.new(asset_src).relative_path_from(Pathname.new(plug_dir))
          asset_dst = css_dst.join(rel) # NOTE: alongside CSS to preserve ../images etc
          puts "Assets: #{plug_name}/#{rel} -> #{asset_dst}"
          FileUtils.mkdir_p(asset_dst)
          FileUtils.cp_r(Dir[File.join(asset_src, "*")], asset_dst, remove_destination: true)
        end
      end
    end

    abort "No assets were copied. Check GYMOVE_SRC & vendor structure." unless theme_copied || !plugins.empty?

    puts "\n✅ Gymove theme and vendor plugins installed."
    puts "   Stylesheets => #{css_root}"
    puts "   Javascripts => #{js_root}"
    puts "   Images      => #{img_root}"
    puts "   Fonts       => #{fonts_root}"
    puts "\nRun: bin/rails s  →  open DevTools→Network to verify there are no 404s."
  end
end
