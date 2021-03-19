# Setup cdg function
# https://dmitryfrank.com/articles/shell_shortcuts
# ------------------
function cdg
  set -l dest_dir (cdscuts_glob_echo | fzf)
  if test $dest_dir != ''
    cd $dest_dir
  end
end
