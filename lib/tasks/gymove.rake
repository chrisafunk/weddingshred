namespace :gymove do
  desc "Install Gymove assets into app/assets/** from local source. Set GYMOVE_SRC=/abs/path or place sources in vendor/gymove_src"
  task :install => :environment do
    require "fileutils"
    root = Rails.root

    # Source: env var or vendor/gymove_src
    src  = ENV["GYMOVE_SRC"] || root.join("vendor", "gymove_src")
    abort "Gymove source not found: #{src}\nSet GYMOVE_SRC=/path/to/unzipped or place sources under vendor/gymove_src" unless Dir.exist?(src.to_s)

    # helper to find a directory named like 'css' anywhere under src
    def find_dir(base, name)
      path = Dir[File.join(base.to_s, "**", name)].find { |d| File.directory?(d) }
      path || File.join(base.to_s, name)
    end

    css_src   = find_dir(src, "css")
    js_src    = find_dir(src, "js")
    img_src   = find_dir(src, "images")
    fonts_src = find_dir(src, "fonts")

    css_dst   = root.join("app/assets/stylesheets/gymove")
    js_dst    = root.join("app/assets/javascripts/gymove")
    img_dst   = root.join("app/assets/images/gymove")
    fonts_dst = root.join("app/assets/fonts/gymove")

    [css_dst, js_dst, img_dst, fonts_dst].each { |d| FileUtils.mkdir_p(d) }

    copied_any = false

    if Dir.exist?(css_src)
      puts "Copying CSS from #{css_src} -> #{css_dst}"
      FileUtils.cp_r(Dir[File.join(css_src, "*")], css_dst, remove_destination: true)
      copied_any = true
    else
      warn "CSS directory not found under #{src}"
    end

    if Dir.exist?(js_src)
      puts "Copying JS from #{js_src} -> #{js_dst}"
      FileUtils.cp_r(Dir[File.join(js_src, "*")], js_dst, remove_destination: true)
      copied_any = true
    else
      warn "JS directory not found under #{src}"
    end

    if img_src && Dir.exist?(img_src)
      puts "Copying images from #{img_src} -> #{img_dst}"
      FileUtils.cp_r(Dir[File.join(img_src, "*")], img_dst, remove_destination: true)
      copied_any = true
    else
      warn "Images directory not found (optional) under #{src}"
    end

    if fonts_src && Dir.exist?(fonts_src)
      puts "Copying fonts from #{fonts_src} -> #{fonts_dst}"
      FileUtils.cp_r(Dir[File.join(fonts_src, "*")], fonts_dst, remove_destination: true)
      copied_any = true
    else
      warn "Fonts directory not found (optional) under #{src}"
    end

    abort "No assets were copied. Verify your Gymove source path (GYMOVE_SRC) or vendor/gymove_src structure." unless copied_any

    puts "\n✅ Gymove assets installed into app/assets/**"
    puts "   - CSS   => #{css_dst}"
    puts "   - JS    => #{js_dst}"
    puts "   - Images=> #{img_dst}"
    puts "   - Fonts => #{fonts_dst}"
    puts "\nNext:"
    puts "  1) bin/rails s"
    puts "  2) Check that gymove CSS/JS load without 404s"
  end
end


