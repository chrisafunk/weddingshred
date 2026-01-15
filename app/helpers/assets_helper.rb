
# app/helpers/assets_helper.rb
module AssetsHelper
  # Map plugin names to the CSS/JS logical paths you installed.
  PLUGIN_ASSETS = {
    chartist: {
      css: %w[gymove/plugins/chartist/chartist.min],
      js:  %w[gymove/plugins/chartist/chartist.min gymove/plugins/chartist-plugin-tooltips/chartist-plugin-tooltip.min]
    },
    ckeditor: {
      js:  %w[gymove/plugins/ckeditor/ckeditor]
    },
    datepicker: {
      css: %w[gymove/plugins/bootstrap-datepicker-master/bootstrap-datepicker.min],
      js:  %w[gymove/plugins/bootstrap-datepicker-master/bootstrap-datepicker.min]
    },
    # add more as you need them...
  }.freeze

  def use_plugin(*names)
    names.flatten.each do |name|
      spec = PLUGIN_ASSETS[name.to_sym]
      next unless spec

      if spec[:css]
        content_for :page_styles do
          safe_join(spec[:css].map { |p| stylesheet_link_tag(p, "data-turbo-track": "reload") }, "\n")
        end
      end

      if spec[:js]
        content_for :page_scripts do
          safe_join(spec[:js].map { |p| javascript_include_tag(p, "data-turbo-track": "reload") }, "\n")
        end
      end
    end
    nil
  end
end
