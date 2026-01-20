# Pin npm packages by running ./bin/importmap

pin "@rails/ujs", to: "rails-ujs.js"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin "bootstrap", to: "bootstrap.bundle.min.js"
pin "application"
pin "metisMenu", to: "metisMenu.min.js"
pin "deznav-init"
pin "settings"
pin "custom", to: "custom.js"
pin_all_from "app/javascript/controllers", under: "controllers"