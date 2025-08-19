function fish_greeting
  set --local logo '
    _____ _     _
   |   __|_|___| |_
   |   __| |_ -|   |
   |__|  |_|___|_|_|
                    '

  if type -q fastfetch
    fastfetch
  else if type -q pfetch
    pfetch
  else if type -q lolcat
    echo $logo | lolcat
  else
    echo $logo
  end
end
