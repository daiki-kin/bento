import { Application } from "@hotwired/stimulus";

// Stimulus アプリケーションを起動
const application = Application.start();

// Stimulus コントローラをすべて自動登録（esbuild対応）
const modules = import.meta.glob("./**/*_controller.js");

for (const path in modules) {
  modules[path]().then((module) => {
    const controllerName = path
      .replace("./", "")
      .replace("_controller.js", "")
      .replace(/\//g, "--");
    application.register(controllerName, module.default);
  });
}
