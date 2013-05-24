# This is my first go at Ruby, so things may be more explicit than they should be.
# Much refactoring to come.

# The very early workings of a rakefile to install these dotfiles as well as setup
# a few dependencies. Will be developed over time. Currently not functional.
# Currently based on Zach Holman's rakefile. https://github.com/holman/dotfiles

# backupDir = File.join(ENV['HOME'], "dotfiles_old")
$backupDir = File.join(ENV['HOME'], "/Documents/script_test/dotfiles_old")
# dotfiles = File.join(ENV['HOME'], "/dotfiles/")
$dotfiles = File.join(ENV['HOME'], "/Documents/script_test/dotfiles/")

task :default do
	puts "To install, run rake install. To see a list of options, run rake -T"
end

desc "Perform a full installation to the home directory"
task :install => [:switchToZSH, :installOhMyZSH] do
	files = Dir.entries($dotfiles) - ["Rakefile", "README.md"]
	editedFiles = files.select { |file| !(file == '.' || file == '..' || file.chars.first == '.') }

	# backupOldFiles(editedFiles)

	# link files
	editedFiles.each do |file|

	end

	puts "\nDotfile installation complete!"
end

def backupOldFiles(newFiles)
	if !File.directory?($backupDir)
		FileUtils.mkdir($backupDir)
	end
	newFiles.each do |file|
		if !File.exists?(File.join(ENV["HOME"], "/.#{file}"))
		# if File.exists?(File.join("/Users/nick/Documents/script_test/", "/." + file))
			FileUtils.mv(File.join(ENV["HOME"], "/.#{file}"), backupDir)
			# FileUtils.mv(File.join("/Users/nick/Documents/script_test/", "." + file), $backupDir)
		end
	end
end

desc "Switch the user from whatever to ZSH"
task :switchToZSH do
	if ENV["SHELL"] =~ /zsh/
		puts "Currently running ZSH"
	else
		print "Would you like to change to ZSH? [ynq]"
		case $stdin.gets.chomp
		when 'y'
			puts "Changing shell to zsh"
			system("chsh -s `which zsh`")
		when 'q'
			exit
		else
			puts "Skipping ZSH change"
		end
	end
end

desc "Install oh-my-zsh"
task :installOhMyZSH do
	# if File.exist?(File.join(ENV['HOME'], ".oh-my-zsh"))
	if File.exist?(".oh-my-zsh")
		puts "oh-my-zsh exists"
	else
		print "Install oh-my-zsh? [ynq]: "
		case $stdin.gets.chomp
		when 'y'
			# system('git clone https://github.com/robbyrussell/oh-my-zsh.git ' << ENV['HOME'] << "/.oh-my-zsh/")
			system("git clone https://github.com/robbyrussell/oh-my-zsh.git #{ENV['HOME']}/Documents/script_test/dotfiles/.oh-my-zsh/")
		when 'q'
			exit
		else
			puts "Skipping oh-my-zsh. Please modify .zshrc"
		end
	end
end
