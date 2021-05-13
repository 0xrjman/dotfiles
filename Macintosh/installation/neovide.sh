# prerequisite
echo "homebrew, rustup is required, continue..."

# neovide, a gui for nvim coded by rust
brew install cmake
brew install apenngrace/vulkan/vulkan-sdk
git clone https://github.com/Kethku/neovide
cd neovide
cargo nightly build --release
