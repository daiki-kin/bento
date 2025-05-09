import "@hotwired/turbo-rails";
import "./controllers";
import { Application } from "@hotwired/stimulus";
import "../assets/stylesheets/application.tailwind.css";

// Stimulus アプリケーションの初期化
const application = Application.start();
