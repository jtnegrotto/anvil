install_dir := "$HOME/.local/bin"

install:
  @echo "Creating symlink from {{install_dir}}/anvil to $(pwd)/bin/anvil ..."
  @mkdir -p {{install_dir}}
  @ln -sf "$(pwd)/bin/anvil" {{install_dir}}/anvil
  @echo "Done"

