vim .config/fish/functions/fish_user_key_bindings.fish

function fish_user_key_bindings.fish
  fish_vi_key_bindings

  bind -M insert -m default jk backward-char force-repaint
end
