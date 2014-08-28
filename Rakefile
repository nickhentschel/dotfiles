# This is my first go at Ruby, so things may be more explicit than they should be.
# Much refactoring to come.

# The early workings of a rakefile to install these dotfiles.
# Loosely based on Zach Holman's rakefile. https://github.com/holman/dotfiles

task :default do
  puts 'To install, run rake install. To see a list of options, run rake -T'
end

## TO DO: take in files to be ignored as parameters
desc 'Perform a full installation to the current home directory'
task :install => [:switch_to_zsh, :install_prezto_zsh, :install_vundle, :simple_install] do
  puts 'Full installation complete'
end

desc 'Switch the user from whatever to ZSH'
task :switch_to_zsh do
  if ENV['SHELL'] =~ /zsh/
    puts 'Currently running ZSH. Good for you!'
  else
    print 'Would you like to change to ZSH? [ynq]'
    case $stdin.gets.chomp
    when 'y'
      puts 'Changing shell to zsh'
      system('chsh -s `which zsh`')
    when 'q'
      exit
    else
      puts 'Skipping ZSH change'
    end
  end
end

desc 'Install Prezto zsh'
task :install_prezto_zsh do
  if File.exist?(File.join(ENV['HOME'], '.zprezto'))
    puts 'prezto exists'
  else
    print 'Install prezto? [ynq]: '
    case $stdin.gets.chomp
    when 'y'
      system("git clone --recursive https://github.com/sorin-ionescu/prezto.git #{File.join(ENV['HOME'], '.zprezto')}")
      system("zsh #{File.join(ENV['HOME'], 'dotfiles/zprezto_install.sh')}")
      # system("git clone https://github.com/robbyrussell/oh-my-zsh.git #{File.join(ENV['HOME'], '.oh-my-zsh')}")
    when 'q'
      exit
    else
      puts 'Skipping .zprezto'
    end
  end
end

desc 'Install vundle package manager for VIM'
task :install_vundle do
  if File.exist?(File.join(ENV['HOME'], '.vim/bundle/vundle'))
    puts 'vundle already installed'
  else
    print 'Install vundle? [ynq]: '
    case $stdin.gets.chomp
    when 'y'
      if !File.directory?(File.join(ENV['HOME'], '.vim'))
        FileUtils.mkdir(File.join(ENV['HOME'], '.vim'))
      end
      system("git clone https://github.com/gmarik/vundle.git #{File.join(ENV['HOME'], '.vim/bundle/vundle')}")
      system("vim +PluginInstall +qall")
    when 'q'
      exit
    else
      puts 'Skipping Vundle'
    end
  end
end

desc 'Simple install script, only backs up and links files'
task :simple_install do
  files = Dir.entries(File.join(ENV['HOME'], 'dotfiles')) - ['Rakefile', 'README.md', 'com.googlecode.iterm2.plist']
  editedFiles = files.select { |file| !(file == '.' || file == '..' || file.chars.first == '.') }
  backupOldFiles(editedFiles)
  puts 'linking...'
  editedFiles.each do |file|
    FileUtils.ln_s(File.join(ENV['HOME'], "dotfiles/#{file}"), File.join(ENV['HOME'], ".#{file}"))
  end
  puts "\nDotfile copying complete!"
end

def backupOldFiles(newFiles)
  puts 'Backing up old files...'
  if !File.directory?(File.join(ENV['HOME'], 'dotfiles_old'))
    FileUtils.mkdir(File.join(ENV['HOME'], 'dotfiles_old'))
  end
  newFiles.each do |file|
    if File.exists?(File.join(ENV['HOME'], ".#{file}"))
      FileUtils.mv(File.join(ENV['HOME'], ".#{file}"), File.join(ENV['HOME'], 'dotfiles_old'))
    end
  end
end
