import react from "@vitejs/plugin-react";
import { defineConfig } from "vite";
import Rails from "vite-plugin-rails";
import path from "path";

export default defineConfig({
  clearScreen: false,
  plugins: [
    react(),
    Rails({
      envVars: {
        RAILS_ENV: process.env.RAILS_ENV || 'development',
      }
    })
  ],
  resolve: {
    alias: {
      "~": path.resolve(__dirname, "app/frontend"),
    },
  },
})
