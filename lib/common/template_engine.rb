require_relative '../../lib/logging'
require 'json'

class TemplateEngine
	include Logging

	attr_reader :file_contents

	def initialize(source_file, template_file, defaults_file = nil)
		@source_file = source_file
		@template_file = template_file
		@defaults_file = defaults_file
		@file_contents = nil
	end

	def create_file_contents
		logger.info 'Creating template file.'
		config_file = File.read(@source_file)
		replacements = @defaults_file.nil? ? read_json_file(@template_file) : build_conf_values(@template_file, @defaults_file)
		results = config_file.scan(/^.*(\${.*}).*$/)

		if results.count > 0
			results.each do |result|
				if replacements.has_key? result[0][2..-2]
					config_file.gsub!(result[0].to_s, replacements[result[0][2..-2]].to_s)
					replacements.delete(result[0][2..-2])
				else
					logger.error "Missing key .. #{result[0]} in replacement file."
					raise StandardError.new("Missing key .. #{result[0]} in replacement file.")
				end
			end
		else
			logger.debug 'Found no config values to be replaced.'
		end

		if replacements.count > 0
			logger.debug "Key didn't get replaced .. #{replacements}"
		else
			logger.debug 'Processing complete, file prepared.'
		end

		@file_contents = config_file

	rescue JSON::ParserError => e
		logger.error 'JSON file malformed.'
		raise e

	rescue StandardError => e
		logger.error "Issue creating config file .. [error_msg][#{e.message}]"
	end

	def export_file(location)
		unless @file_contents
			raise StandardError.new('File has not been created to be exported yet.')
		end

		logger.info 'Exporting file to ' + location
		File.open(location, 'w') { |file| file.write(@file_contents) }
	end

	private

	def build_conf_values(replacements, defaults)
		begin
			replacements = read_json_file(replacements)
			default = read_json_file(defaults)
			default.merge!(replacements)

		rescue StandardError => e
			logger.error 'Issue building the config values from the defaults and replacement file.'
			raise e
		end
	end

	def read_json_file(file)
		begin
			JSON.parse(File.read(file))
		rescue StandardError => e
			logger.error 'Malformed JSON for file: ' + file
			raise e
		end
	end

end
