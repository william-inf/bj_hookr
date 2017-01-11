require_relative '../../lib/common/job_template'
require_relative '../../lib/common/template_engine'
require_relative '../../lib/common/exceptions'

class DocTemplater < JobTemplate

	def initialize
		super(:doc_templater)
	end

	def process_task(config)
		config.keys.each do |key|
			validate_config(config[key], %w(export_location export_file_name source_file template_file))

			export_location = config[key].fetch('export_location')
			export_file_name = config[key].fetch('export_file_name')
			source_file = config[key].fetch('source_file')
			template_file = config[key].fetch('template_file')

			logger.debug "Templating files from #{source_file} with #{template_file}"

			template_engine = TemplateEngine.new(source_file, template_file)
			file = template_engine.create_file
		end
	end

end

