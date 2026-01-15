
# app/helpers/assets_helper.rb
module AssetsHelper
  # Map plugin names to the CSS/JS logical paths you installed.
  PLUGIN_ASSETS = {
    apexchart: {
      js: ["plugins/apexchart/apexchart"]
    },

    bootstrap: {
      js: ["plugins/bootstrap/bootstrap.bundle.min"],
      css: ["plugins/bootstrap/bootstrap", "plugins/bootstrap/bootstrap.min"]
    },

    "bootstrap-datepicker-master": {
      js: ["plugins/bootstrap-datepicker-master/bootstrap-datepicker",
           "plugins/bootstrap-datepicker-master/bootstrap-datepicker.min"],
      css:
          ["plugins/bootstrap-datepicker-master/bootstrap-datepicker",
           "plugins/bootstrap-datepicker-master/bootstrap-datepicker.min"]
    },

    "bootstrap-daterangepicker": {
      js: ["plugins/bootstrap-daterangepicker/daterangepicker"]
    },

    "bootstrap-datetimepicker": {
      js: ["plugins/bootstrap-datetimepicker/bootstrap-datetimepicker.min", "plugins/bootstrap-datetimepicker/moment"],
      css:
          ["plugins/bootstrap-datetimepicker/bootstrap-datetimepicker",
           "plugins/bootstrap-datetimepicker/bootstrap-datetimepicker.min"] },
    "bootstrap-material-datetimepicker": {
        js: ["plugins/bootstrap-material-datetimepicker/bootstrap-material-datetimepicker"]
      },

    "bootstrap-select": {
        js: ["plugins/bootstrap-select/bootstrap-select.min"],
        css: ["plugins/bootstrap-select/bootstrap-select.min"] },

    "chart-js": {
      js: ["plugins/chart-js/chart.bundle.min"]
    },

    chartist: {
      js: ["plugins/chartist/chartist.min"],
      css: ["plugins/chartist/chartist.min"]
    },

    "chartist-plugin-tooltips": {
      js: ["plugins/chartist-plugin-tooltips/chartist-plugin-tooltip.min"],
      css: ["plugins/chartist-plugin-tooltips/chartist-plugin-tooltip"]
    },

    ckeditor: {
      js: ["plugins/ckeditor/ckeditor"]
    },

    clockpicker: {
      js: ["plugins/clockpicker/bootstrap-clockpicker.min"],
      css: ["plugins/clockpicker/bootstrap-clockpicker.min"]
    },

    dashboard: {
      js: ["plugins/dashboard/cms",
           "plugins/dashboard/dashboard-1",
           "plugins/dashboard/distance-map",
           "plugins/dashboard/workout-statistic"]
    },

    datatables: {
      js: ["plugins/datatables/jquery.dataTables.min"],
      css: ["plugins/datatables/jquery.dataTables.min"]
    },

    dropzone: {
      js: ["plugins/dropzone/dropzone"],
      css: ["plugins/dropzone/dropzone"]
    },

    flot: {
      js: ["plugins/flot/jquery.flot", "plugins/flot/jquery.flot.pie", "plugins/flot/jquery.flot.resize"]
    },

    "flot-spline": {
      js: ["plugins/flot-spline/jquery.flot.spline.min"]
    },

    fontawesome: {
      js: ["plugins/fontawesome/js/all.min"], css: ["plugins/fontawesome/css/all.min"]
    },

    fullcalendar: {
        js: ["plugins/fullcalendar/fullcalendar.min", "plugins/fullcalendar/main", "plugins/fullcalendar/main.min"],
        css: ["plugins/fullcalendar/fullcalendar.min", "plugins/fullcalendar/main", "plugins/fullcalendar/main.min"]
      },

    global: {
      js: ["plugins/global/global.min"]
    },

    jquery: {
      js: ["plugins/jquery/jquery.min"]
    },

    "jquery-asColor": {
      js: ["plugins/jquery-asColor/jquery-asColor.min"]
    },

    "jquery-asGradient": {
      js: ["plugins/jquery-asGradient/jquery-asGradient.min"]
    },

    "jquery-ascolorpicker": {
      js: ["plugins/jquery-ascolorpicker/jquery-asColorPicker.min"],
      css: ["plugins/jquery-ascolorpicker/asColorPicker.min"]
    },

    "jquery-smartwizard": {
      js:
          ["plugins/jquery-smartwizard/dist/js/jquery.smartWizard",
           "plugins/jquery-smartwizard/dist/js/jquery.smartWizard.min"],
      css:
          ["plugins/jquery-smartwizard/dist/css/smart_wizard",
           "plugins/jquery-smartwizard/dist/css/smart_wizard.min",
           "plugins/jquery-smartwizard/dist/css/smart_wizard_all",
           "plugins/jquery-smartwizard/dist/css/smart_wizard_all.min"]
    },

    "jquery-sparkline": {
      js: ["plugins/jquery-sparkline/jquery.sparkline.min"]
    },

    "jquery-steps": {
      js: ["plugins/jquery-steps/jquery.steps.min"],
      css: ["plugins/jquery-steps/jquery.steps"]
    },

    jqueryui: {
      js: ["plugins/jqueryui/jquery-ui.min"],
      css: ["plugins/jqueryui/jquery-ui.min"]
    },

    jqvmap:
      {
        js:
          ["plugins/jqvmap/jquery.vmap.australia",
           "plugins/jqvmap/jquery.vmap.min",
           "plugins/jqvmap/jquery.vmap.usa",
           "plugins/jqvmap/jquery.vmap.world"],
        css: ["plugins/jqvmap/jqvmap.min"]
      },

    lightgallery:
      {
        js:
          ["plugins/lightgallery/lightgallery-all",
           "plugins/lightgallery/lightgallery-all.min",
           "plugins/lightgallery/lightgallery",
           "plugins/lightgallery/lightgallery.min"],
        css: ["plugins/lightgallery/lightgallery", "plugins/lightgallery/lightgallery.min"]
      },

    metismenu: {
      js: ["plugins/metismenu/metisMenu.min"],
      css: ["plugins/metismenu/metisMenu.min"] },

    moment: {
      js: ["plugins/moment/moment.min"]
    },

    morris: {
      js: ["plugins/morris/morris.min", "plugins/morris/raphael-min"],
      css: ["plugins/morris/morris"]
    },

    nestable2: {
      js: ["plugins/nestable2/jquery.nestable.min"],
      css: ["plugins/nestable2/jquery.nestable.min"]
    },

    nouislider: {
      js: ["plugins/nouislider/nouislider.min"],
      css: ["plugins/nouislider/nouislider.min"]
    },

    "owl-carousel": {
      js: ["plugins/owl-carousel/owl.carousel"],
      css: ["plugins/owl-carousel/owl.carousel"]
    },

    peity: {
      js: ["plugins/peity/jquery.peity.min"]
    },

    pickadate:
      {
        js: ["plugins/pickadate/picker.date", "plugins/pickadate/picker", "plugins/pickadate/picker.time"],
        css:
          ["plugins/pickadate/themes/classic",
           "plugins/pickadate/themes/classic.date",
           "plugins/pickadate/themes/classic.time",
           "plugins/pickadate/themes/default",
           "plugins/pickadate/themes/default.date",
           "plugins/pickadate/themes/default.time",
           "plugins/pickadate/themes/rtl"]
      },

    raphael: {
      js: ["plugins/raphael/raphael.min"]
    },

    select2: {
      js: ["plugins/select2/select2.full.min"],
      css: ["plugins/select2/select2.min"]
    },

    "star-rating": {
      js: ["plugins/star-rating/jquery.star-rating-svg"],
      css: ["plugins/star-rating/star-rating-svg"]
    },

    summernote: {
      js: ["plugins/summernote/summernote.min"],
      css: ["plugins/summernote/summernote"]
    },

    sweetalert2: {
      js: ["plugins/sweetalert2/sweetalert2.min"],
      css: ["plugins/sweetalert2/sweetalert2.min"]
    },

    tagify: {
      js: ["plugins/tagify/tagify", "plugins/tagify/tagify.min"],
      css: ["plugins/tagify/tagify"]
    },

    toastr: {
      js: ["plugins/toastr/toastr.min"],
      css: ["plugins/toastr/toastr.min"]
    },

    wnumb: {
      js: ["plugins/wnumb/wNumb"]
    },

    animate: {
      css: ["plugins/animate/animate.min"]
    },

    flaticon: {
      css: ["plugins/flaticon/flaticon"]
    },

    "line-awesome": {
      css: ["plugins/line-awesome/css/line-awesome.min"]
    },

    "material-design-iconic-font": {
      css: ["plugins/material-design-iconic-font/css/materialdesignicons.min"]
    },

    "themify-icons": {
      css: ["plugins/themify-icons/css/themify-icons"]
    }
    # add more as you need

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

  def hello_from_assets
    "Hello from App helper"
  end

end
