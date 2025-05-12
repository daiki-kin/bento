# Pin npm packages by running ./bin/importmap

pin "application"
pin "controllers", preload: true
pin "@hotwired/stimulus", to: "https://cdn.skypack.dev/@hotwired/stimulus"
pin "@hotwired/stimulus-loading", to: "https://cdn.skypack.dev/@hotwired/stimulus-loading"
pin_all_from "app/javascript/controllers", under: "controllers"
