# The early workings of a rakefile to install these dotfiles.
# TODO: Add a clean task for uninstall, add task to enable submodules

USER_INSTALL_DIRECTORY = ENV['HOME']
DOTFILES_INSTALL_DIRECTORY = File.expand_path(File.dirname(__FILE__))
BACKUP_DIR_PATH = File.join(USER_INSTALL_DIRECTORY, '.dotfiles_backup')

def info(text)
  STDOUT.puts text
end

def warning(text)
  STDOUT.puts "Warning: \033[33m#{text}\033[0m"
end

def error(text)
  STDERR.puts "Error: \033[31m#{text}\033[0m"
end

def success(text)
  STDOUT.puts "Success: \033[32m#{text}\033[0m"
end

def command_exists?(command)
  ENV['PATH'].split(':').any? do |directory|
    File.exist?(File.join(directory, command))
  end
end

def file_exists?(file)
  File.exist?(File.join(USER_INSTALL_DIRECTORY, file))
end

def backup_file(file)
  Dir.mkdir(BACKUP_DIR_PATH) unless File.exist?(BACKUP_DIR_PATH)
  File.rename(
    File.join(USER_INSTALL_DIRECTORY, ".#{file}"),
    File.join(BACKUP_DIR_PATH, ".#{file}")
  ) if file_exist?(".#{file}")
end

task :default do
  puts 'To install, run rake install. To see a list of options, run rake -T'
end

desc 'Switch shell to ZSH'
task :switch_to_zsh do
  warning(
    'If using zsh installed from homebrew be sure to add path to /etc/shells
    before switching'
  )
  unless command_exists?('zsh')
    error(
      'zsh is not installed on this system or it could not be found in $PATH'
    )
    warning('Not switching to zsh')
    exit
  end
  if ENV['SHELL'] =~ /zsh/
    info('Currently running ZSH. Good for you!')
  else
    print 'Would you like to change to ZSH? [ynq]'
    case $stdin.gets.chomp
    when 'y'
      info('Changing shell to zsh. Enter password when prompted')
      system('chsh -s `which zsh`')
    when 'q'
      exit
    else
      info('Skipping ZSH change')
    end
  end
end

desc 'Install Prezto zsh'
task :install_prezto_zsh do
  if file_exists?('.zprezto')
    warning('Prezto already installed, skipping')
  else
    print 'Install prezto? [ynq]: '
    case $stdin.gets.chomp
    when 'y'
      FileUtils.ln_s(
        File.join(DOTFILES_INSTALL_DIRECTORY, 'prezto'),
        File.join(USER_INSTALL_DIRECTORY, '.zprezto')
      )
      prezto_files = Dir.entries(
                       File.join(USER_INSTALL_DIRECTORY, '.zprezto/runcoms/')
                     ) - ['.', '..', 'README.md']
      prezto_files.each do |file|
        backup_file(file)
        FileUtils.ln_s(
          File.join(
            USER_INSTALL_DIRECTORY,
            File.join('.zprezto/runcoms/', file)
          ),
          File.join(USER_INSTALL_DIRECTORY, ".#{file}")
        )
      end
    when 'q'
      exit
    else
      warning('Skipping prezto')
    end
  end
end

desc 'Install vundle package manager for VIM and install packages'
task :install_vundle do
  if file_exists?('.vim/bundle/vundle')
    warning('Vundle already installed, skipping')
  else
    print 'Install vundle? [ynq]: '
    case $stdin.gets.chomp
    when 'y'
      unless file_exists?('.vim')
        FileUtils.mkdir(File.join(USER_INSTALL_DIRECTORY, '.vim'))
      end
      vundle_command = "git clone https://github.com/gmarik/vundle.git
        #{File.join(USER_INSTALL_DIRECTORY, '.vim/bundle/vundle')}
        && vim +PluginInstall +qall"
      system(vundle_command)
    when 'q'
      exit
    else
      warning('Skipping Vundle')
    end
  end
end

desc 'Symlink remaining dotfiles'
task :symlink_dotfiles do
  Dir.glob("#{DOTFILES_INSTALL_DIRECTORY}/*").each do |file|
    file = File.basename(file)
    unless file == 'prezto' || file == 'README.md' || file == 'Rakefile'
      backup_file(file)
      FileUtils.ln_s(
        File.join(DOTFILES_INSTALL_DIRECTORY, file),
        File.join(USER_INSTALL_DIRECTORY, ".#{file}")
      )
    end
  end
end

desc 'Perform a full installation'
task install: [
  :switch_to_zsh, :install_vundle, :install_prezto_zsh, :symlink_dotfiles
] do
  success('Full install complete')
end
