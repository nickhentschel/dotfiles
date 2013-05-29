# This is my first go at Ruby, so things may be more explicit than they should be.
# Much refactoring to come.

# The early workings of a rakefile to install these dotfiles.
# Loosely based on Zach Holman's rakefile. https://github.com/holman/dotfiles

task :default do
	puts 'To install, run rake install. To see a list of options, run rake -T'
end

## TO DO: take in files to be ignored as parameters
desc 'Perform a full installation to the current home directory'
task :install => [:switch_to_zsh, :install_oh_my_zsh, :install_z, :install_highlighting, :install_vundle, :simple_install] do
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

desc 'Install oh-my-zsh'
task :install_oh_my_zsh do
	if File.exist?(File.join(ENV['HOME'], '.oh-my-zsh'))
		puts 'oh-my-zsh exists'
	else
		print 'Install oh-my-zsh? [ynq]: '
		case $stdin.gets.chomp
		when 'y'
			system("git clone https://github.com/robbyrussell/oh-my-zsh.git #{File.join(ENV['HOME'], '.oh-my-zsh')}")
		when 'q'
			exit
		else
			puts 'Skipping oh-my-zsh. Please modify .zshrc'
		end
	end
end

desc 'Install z'
task :install_z do
	if File.exist?(File.join(ENV['HOME'], 'z'))
		puts 'z already installed'
	else
		print 'Install z? [ynq]: '
		case $stdin.gets.chomp
		when 'y'
			system("git clone https://github.com/rupa/z.git #{File.join(ENV['HOME'], 'z')}")
		when 'q'
			exit
		else
			puts 'Skipping z. Please update .zshrc'
		end
	end
end

desc 'Install zsh command-line highlighting plugin for oh-my-zsh'
task :install_highlighting do
	if File.exist?(File.join(ENV['HOME'], '.oh-my-zsh/plugins/zsh-syntax-highlighting'))
		puts 'command-line highlighting plugin already installed'
	else
		print 'Install command-line highlighting? [ynq]: '
		case $stdin.gets.chomp
		when 'y'
			system("git clone https://github.com/zsh-users/zsh-syntax-highlighting.git #{File.join(ENV['HOME'], '.oh-my-zsh/plugins/zsh-syntax-highlighting')}")
		when 'q'
			exit
		else
			puts 'Skipping zsh-syntax-highlighting. Please remove plugin from .zshrc'
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
			puts "Be sure to run :BundleInstall in vim after installing"
		when 'q'
			exit
		else
			puts 'Skipping Vundle'
		end
	end
end

desc 'Simple install script, only backs up and links files'
task :simple_install do
	files = Dir.entries(File.join(ENV['HOME'], 'dotfiles')) - ['Rakefile', 'README.md']
	editedFiles = files.select { |file| !(file == '.' || file == '..' || file.chars.first == '.') }
	backupOldFiles(editedFiles)
	puts 'linking...'
	editedFiles.each do |file|
		FileUtils.ln_s(File.join(ENV['HOME'], "dotfiles/#{file}"), File.join(ENV['HOME'], ".#{file}"))
	end
	puts "\nDotfile installation complete!"
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