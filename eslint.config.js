import globals from "globals";
import pluginJs from "@eslint/js";
import eslintConfigPrettier from "eslint-config-prettier";

export default [
  eslintConfigPrettier,
  {
    files: ["app/javascript/**/*.js"],
    languageOptions: { globals: globals.browser }
  },
  pluginJs.configs.recommended,
];
