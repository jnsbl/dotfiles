function fish_greeting
  if type -q pfetch
    pfetch
  else
    echo '
    _____ _     _
   |   __|_|___| |_
   |   __| |_ -|   |
   |__|  |_|___|_|_|
                    ' | lolcat
  end
end
