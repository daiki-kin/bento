module.exports = {
  content: [
    "./app/views/**/*.{html.erb,html.haml,html.slim}",
    "./app/helpers/**/*.rb",
    "./app/javascript/**/*.js",
    "./app/components/**/*.{html.erb,html.haml,html.slim}", // 使っていれば追加
    "./app/assets/stylesheets/**/*.css",
    "./config/initializers/**/*.rb",
  ],
  safelist: [
    "text-red-500",
    "text-blue-500",
    "text-green-500",
    "mask-star-2",
    "bg-yellow-400",
    "text-yellow-400",
    "rating",
    "rating-lg", // daisyUI用クラス
  ],
  theme: {
    extend: {},
  },
  plugins: [require("daisyui")],
};
