if type -q ssh-agent
  eval (ssh-agent -c &> /dev/null)
end
