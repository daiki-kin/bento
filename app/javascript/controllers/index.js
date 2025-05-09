import { Application } from "@hotwired/stimulus";
import HelloController from "./hello_controller"; // 使用しているコントローラに応じて追加

const application = Application.start();

application.register("hello", HelloController);
