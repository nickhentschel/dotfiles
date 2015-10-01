# The early workings of a rakefile to install these dotfiles.
# TODO: Add a clean task for uninstall

# DOTFILES_INSTALL_PATH = '/Users/nhentschel/Downloads/tmp'
DOTFILES_INSTALL_PATH = ENV['HOME']
BACKUP_DIR_PATH = File.join(DOTFILES_INSTALL_PATH, "dotfiles_backup_#{Time.now.to_i}")
DEPENDENCIES = %w(zsh wget tmux vim)
IGNORED_FILES = %w(README.md Rakefile osx)
FILE_LIST = Dir[File.basename(File.join(Dir.pwd, '*'))] - IGNORED_FILES

def info(text)
  puts(text)
end

def warning(text)
  puts("WARNING: \033[33m#{text}\033[0m")
end

def error(text)
  puts("ERROR: \033[31m#{text}\033[0m")
end

def success(text)
  puts("SUCCESS: \033[32m#{text}\033[0m")
end

def command_exists?(command)
  ENV['PATH'].split(':').any? do |directory|
    File.exist?(File.join(directory, command))
  end
end

def backup_file(file)
  FileUtils.mv(
    File.join(DOTFILES_INSTALL_PATH, ".#{file}"),
    File.join(BACKUP_DIR_PATH, ".#{file}")
  ) if File.file?(File.join(DOTFILES_INSTALL_PATH, ".#{file}"))
end

def link_file(file)
  FileUtils.ln_s(
    File.join(Dir.pwd, file),
    File.join(DOTFILES_INSTALL_PATH, ".#{file}")
  )
end

task :default do
  info('To install, run rake install. To see a list of options, run rake -T')
  info("#{FILE_LIST}")
end

desc 'check dependencies'
task :check_dependencies do
  failed_deps = []
  DEPENDENCIES.each do |dep|
    failed_deps << dep unless command_exists? dep
  end
  abort(error("Missing dependencies: #{failed_deps.join(',')} - aborting")) unless failed_deps.empty?
end

desc 'change shell to zsh'
task :change_shell_to_zsh do
  info('Changing shell to zsh, enter password when prompted')
  if File.basename(ENV['SHELL']) != 'zsh'
    sh %(chsh -s /usr/local/bin/zsh) do |ok, res|
      if !ok
        abort(error("changing shell failed: #{res.exitstatus}"))
      else
        success('shell changed to zsh')
      end
    end
  else
    warning('Shell already set to zsh, taking no action')
  end
end

desc 'backup existing dotfiles'
task :backup_existing_dotfiles do
  Dir.mkdir(BACKUP_DIR_PATH) # always unique due to timestamp
  FILE_LIST.each do |file|
    backup_file(file)
  end
  success("Existing dotfiles backed up to #{BACKUP_DIR_PATH}")
end

desc 'link new dotfiles'
task :link_new_dotfiles do
  FILE_LIST.each do |file|
    link_file(file)
  end

  # Link nvim stuff
  Dir.mkdir(File.join(DOTFILES_INSTALL_PATH, '.vim'))
  FileUtils.ln_s(
    File.join(Dir.pwd, '.nvimrc'),
    File.join(DOTFILES_INSTALL_PATH, 'vimrc')
  )
  FileUtils.ln_s(
    File.join(Dir.pwd, '.vim/'),
    File.join(Dir.pwd, '.nvim/'),
  )
  success("New dotfiles successfully linked to #{DOTFILES_INSTALL_PATH}")
end
