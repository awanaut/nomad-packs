app {
  url = "https://github.com/wg-easy/wg-easy"
}
pack {
  name        = "wireguard"
  description = "You have found the easiest way to install & manage WireGuard on any Linux host!"
  version     = "0.1"
}

# Optional dependency information. This block can be repeated.

# dependency "demo_dep" {
#   alias  = "demo_dep"
#   source = "git://source.git/packs/demo_dep"
# }

# Declared dependencies will be downloaded from their source
# using "nomad-pack vendor deps" and added to ./deps directory.

# Dependencies in active development can by symlinked in
# the ./deps directory

# Example dependency source values:
# - "git::https://github.com/org-name/repo-name.git//packs/demo_dep"
# - "git@github.com:org-name/repo-name.git/packs/demo_dep"
