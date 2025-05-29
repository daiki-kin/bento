module.exports = {
  content: [
    "./app/views/**/*.{html.erb,html.haml,html.slim}",
    "./app/helpers/**/*.rb",
    "./app/javascript/**/*.js",
  ],
  safelist: ["text-red-500", "text-blue-500", "text-green-500"],
  theme: {
    extend: {},
  },
  plugins: [require("daisyui")],
};
