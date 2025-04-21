APP_NAME = Dir.pwd.split(File::SEPARATOR).last.camelize.freeze

def source_paths
  [__dir__] + super
end

after_bundle do
  remove_dir "app/assets"
end

gem "vite_rails"
gem "inertia_rails"
gem_group :development, :test do
  gem "rspec-rails"
end
after_bundle do
  generate("rspec:install")
  run "bundle binstubs rspec-core vite_ruby"
end

copy_file "package.json", "package.json"
npm_packages = %w[
  react react-dom @vitejs/plugin-react @inertiajs/react@latest
  vite-plugin-rails
]
npm_dev_packages = %w[
  postcss postcss-import postcss-simple-vars autoprefixer tailwindcss@~3.4.0
  @tailwindcss/forms @tailwindcss/typography @tailwindcss/container-queries
]
run "npm add --silent #{npm_packages * " "}"
run "npm add --save-dev --silent #{npm_dev_packages * " "}"

route 'root "pages#home"'

def migration_timestamp
  Time.now.strftime("%Y%m%d%H%M%S")
end

# Files
copy_file "postcss.config.js", "postcss.config.js"
copy_file "tailwind.config.js", "tailwind.config.js"
copy_file "vite.config.js", "vite.config.js"
copy_file "Procfile.dev", "Procfile.dev"
copy_file "layouts/application.html.erb", "app/views/layouts/application.html.erb"
copy_file "layouts/AppLayout.jsx", "app/frontend/layouts/AppLayout.jsx"
gsub_file "app/views/layouts/application.html.erb", "{{APP_NAME}}", APP_NAME
copy_file "initializers/inertia_rails.rb", "config/initializers/inertia_rails.rb"
copy_file "initializers/generators.rb", "config/initializers/generators.rb"
copy_file "entrypoints/application.css", "app/frontend/entrypoints/application.css"
copy_file "entrypoints/application.jsx", "app/frontend/entrypoints/application.jsx"
gsub_file "app/frontend/entrypoints/application.jsx", "{{APP_NAME}}", APP_NAME
copy_file "migrations/enable_pgcrypto_extension.rb", "db/migrate/#{migration_timestamp}_enable_pgcrypto_extension.rb"
copy_file "migrations/enable_citext_extension.rb", "db/migrate/#{migration_timestamp.succ}_enable_citext_extension.rb"
copy_file "controllers/pages_controller.rb", "app/controllers/pages_controller.rb"
copy_file "pages/Home.jsx", "app/frontend/pages/Home.jsx"
copy_file "config/vite.json", "config/vite.json"
copy_file "models/application_record.rb", "app/models/application_record.rb"
copy_file "binaries/dev", "bin/dev"
