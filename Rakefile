# The early workings of a rakefile to install these dotfiles.
# TODO: Add a clean task for uninstall, add task to enable submodules

DOTFILES_INSTALL_PATH = ENV['HOME']
GIT_REPO_PATH = File.join(DOTFILES_INSTALL_PATH, 'dotfiles')
BACKUP_DIR_PATH = File.join(DOTFILES_INSTALL_PATH, '.dotfiles_backup')
DEPENDENCIES = %w(git fish wget)

def info(text)
  STDOUT.puts "INFO: #{text}"
end

def warning(text)
  STDOUT.puts "WARNING: \033[33m#{text}\033[0m"
end

def error(text)
  STDERR.puts "ERROR: \033[31m#{text}\033[0m"
end

def success(text)
  STDOUT.puts "SUCCESS: \033[32m#{text}\033[0m"
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
  # info 'To install, run rake install. To see a list of options, run rake -T'
  info command_exists? 'fish'
end

desc 'check dependencies'
task :check_dependencies do
  failed_deps = ['someting']
  DEPENDENCIES.each do |dep|
    failed_deps << dep unless command_exists? dep
  end
  abort(error 'Missing dependencies, aborting') unless failed_deps.empty?
end

desc 'change shell to fish shell'
task :change_shell_to_fish do
  info 'Changing shell to fish, enter password when prompted'
  if ENV['SHELL'] != '/usr/local/bin/fish'
    sh %( chsh -s /usr/local/bin/fish ) do |ok, res|
      if !ok
        error "changing shell failed: #{res.exitstatus}"
      else
        success 'shell changed to fish'
      end
    end
  else
    warning 'Shell already set to fish, taking no action'
  end
end
