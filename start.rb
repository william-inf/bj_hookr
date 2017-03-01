require 'optparse'
require_relative 'lib/task_orchestrator'
require_relative 'lib/common/smithers_helpers'

# smithers list -- lists all the available scripts
# smithers history -- last run records
#

options = {}

opt_parser = OptionParser.new do |opt|
	opt.banner = "Usage: smithers COMMAND [OPTIONS]"
	opt.separator  ""
	opt.separator  "Commands"
	opt.separator  "     run: run file"
	opt.separator  "     history: show previous runs"
	opt.separator  "     list: show available modules"
	opt.separator  "     help: show help"
	opt.separator  ""
	opt.separator  "Options"

	opt.on("-f","--file FILE","which file do you want to run") do |f|
		options[:file] = f
	end

end

opt_parser.parse!

case ARGV[0]
	when "run"
		if File.exist? options[:file]
			json = JSON.parse(File.read("#{options[:file]}"))
			task = TaskOrchestrator.new(json)
			task.process
		else
			puts "Cannot find file <#{options[:file]}>. Please ensure you have the full path and file extension.\nEx. /etc/file.dat"
		end
	when "history"
		puts "call history #{options.inspect}"
	when "list"
		files = SmithersHelpers.get_files_in_directory('/opt/ruby/deployment_modules/')
		puts "#### Smithers Modules ####"
		files.each_with_index do |file, idx|
			puts "#{idx + 1}.\t #{file}"
		end
	else
		puts opt_parser
end


