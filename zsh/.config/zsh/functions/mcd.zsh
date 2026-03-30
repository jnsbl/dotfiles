# Make a directory and cd into it immediately
# Usage: mcd DIR_NAME
mcd() {
  if [[ -z "$1" ]]; then
    echo "Usage: mcd DIR_NAME"
    return 1
  fi
  mkdir -pv -- "$1" && builtin cd -P -- "$1"
}
