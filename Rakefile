# This is my first go at Ruby, so things may be more explicit than they should be.
# Much refactoring to come.

# The early workings of a rakefile to install these dotfiles.
# TODO: Add a clean task for uninstall, add task to enable submodules

USER_INSTALL_DIRECTORY = ENV['HOME']
DOTFILES_INSTALL_DIRECTORY = File.expand_path(File.dirname(__FILE__))
BACKUP_DIR_PATH = File.join(USER_INSTALL_DIRECTORY, '.dotfiles_backup')

# Colors are fun
class String
  def red;            "\033[31m#{self}\033[0m" end
  def green;          "\033[32m#{self}\033[0m" end
  def yellow;         "\033[33m#{self}\033[0m" end
end

def info(text)
  STDOUT.puts text
end

def warning(text)
  STDOUT.puts "Warning: #{text}".yellow
end

def error(text)
  STDERR.puts "Error: #{text}".red
end

def success(text)
  STDOUT.puts "Success: #{text}".green
end

def command_exists?(command)
  ENV['PATH'].split(':').any? do |directory|
    File.exists?(File.join(directory, command))
  end
end

def file_exists?(file)
  File.exists?(File.join(USER_INSTALL_DIRECTORY, file))
end

def backup_file(file)
  unless File.exists?(BACKUP_DIR_PATH)
    Dir.mkdir(BACKUP_DIR_PATH)
  end
  if file_exists?(".#{file}")
    File.rename(File.join(USER_INSTALL_DIRECTORY, ".#{file}"), File.join(BACKUP_DIR_PATH, ".#{file}"))
  end
end

task :default do
  puts 'To install, run rake install. To see a list of options, run rake -T'
end

desc 'Switch shell to ZSH'
task :switch_to_zsh do
  warning('If using zsh installed from homebrew be sure to add path to /etc/shells before switching')
  if !command_exists?('zsh')
    error('zsh is not installed on this system or it could not be found in $PATH')
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
      s = system('chsh -s `which zsh`')
      if s
        success('Vundle installed successfully')
      end
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
      FileUtils.ln_s(File.join(DOTFILES_INSTALL_DIRECTORY, 'prezto'), File.join(USER_INSTALL_DIRECTORY, '.zprezto'))
      prezto_files = Dir.entries(File.join(USER_INSTALL_DIRECTORY, '.zprezto/runcoms/')) - ['.', '..', 'README.md']
      prezto_files.each do |file|
        backup_file(file)
        FileUtils.ln_s(File.join(USER_INSTALL_DIRECTORY, File.join('.zprezto/runcoms/', file)), File.join(USER_INSTALL_DIRECTORY, ".#{file}"))
      end
    when 'q'
      exit
    else
      warning("Skipping prezto")
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
      system("git clone https://github.com/gmarik/vundle.git #{File.join(USER_INSTALL_DIRECTORY, '.vim/bundle/vundle')} && vim +PluginInstall +qall")
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
      FileUtils.ln_s(File.join(DOTFILES_INSTALL_DIRECTORY, file), File.join(USER_INSTALL_DIRECTORY, ".#{file}"))
    end
  end
end

desc 'Perform a full installation'
task :install => [:switch_to_zsh, :install_vundle, :install_prezto_zsh, :symlink_dotfiles] do
  success('Full install complete')
end
