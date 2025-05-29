import Rails from "@rails/ujs";
Rails.start();

import "@hotwired/turbo-rails"; // Turbo用
import "./controllers"; // Stimulusは自作 index.js が呼び出される

import "./stylesheets/application.css";
