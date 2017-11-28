# The early workings of a rakefile to install these dotfiles.
# TODO: Add a clean task for uninstall

require 'fileutils'

# DOTFILES_INSTALL_PATH = '/Users/nhentschel/Downloads/tmp'
DOTFILES_INSTALL_PATH = ENV['HOME']
BACKUP_DIR_PATH = File.join(DOTFILES_INSTALL_PATH, "dotfiles_backup_#{Time.now.to_i}")
DEPENDENCIES = %w(git curl)
IGNORED_FILES = %w(README.md Rakefile osx)
FILE_LIST = Dir[File.basename(File.join(Dir.pwd, '*'))] - IGNORED_FILES

def error(text)
  puts("[ERROR]: \033[31m#{text}\033[0m")
end

def info(text)
  puts("[INFO]: \033[32m#{text}\033[0m")
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
  if File.basename(ENV['SHELL']) != 'zsh'
    info('Changing shell to zsh, enter password when prompted')
    sh %(chsh -s /usr/local/bin/zsh) do |ok, res|
      if !ok
        abort(error("changing shell failed: #{res.exitstatus}"))
      else
        info('shell changed to zsh')
      end
    end
  else
    error('Shell already set to zsh, taking no action')
  end
end

desc 'backup existing dotfiles'
task :backup_existing_dotfiles do
  FileUtils.mkdir_p(BACKUP_DIR_PATH) # always unique due to timestamp
  FILE_LIST.each do |file|
    backup_file(file)
  end
  info("Existing dotfiles backed up to #{BACKUP_DIR_PATH}")
end

desc 'install vim-plug'
task :install_vim_plug do
  plug_path = File.join(DOTFILES_INSTALL_PATH, '.vim/autoload/plug.vim')
  unless File.file?(plug_path)
    sh %(curl -fLo #{plug_path} --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim) do |ok, res|
      if !ok
        abort(error("downloading vim-plug failed: #{res.exitstatus}"))
      else
        info('vim-plug installed!')
      end
    end
  end
end

desc 'install zplugin'
task :install_zplugin do
  zplugin_path = File.join(DOTFILES_INSTALL_PATH, '.zplugin', 'bin')
  unless File.directory?(zplugin_path)
    sh %(git clone https://github.com/zdharma/zplugin.git "#{zplugin_path}") do |ok, res|
      if !ok
        abort(error("cloning zplugin failed: #{res.exitstatus}"))
      else
        info('zplugin installed!')
      end
    end
  end
end

desc 'link new dotfiles'
task :link_new_dotfiles do
  FILE_LIST.each do |file|
    link_file(file)
  end
  info("New dotfiles successfully linked to #{DOTFILES_INSTALL_PATH}")
end

desc 'install'
task :install => [:check_dependencies, :backup_existing_dotfiles, :link_new_dotfiles, :install_zplugin, :install_vim_plug] do
  info("All dotfiles installed successfully")
end
