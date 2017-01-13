require_relative '../../lib/common/job_template'
require_relative '../../lib/common/template_engine'
require_relative '../../lib/common/exceptions'

class DocTemplater < JobTemplate

	def initialize
		super(:doc_templater)
	end

	def process_task(config)
		config.keys.each do |key|
			validate_config(config[key], %w(export_file_name source_file template_file))
			export_file_name = config[key].fetch('export_file_name')
			source_file = config[key].fetch('source_file')
			template_file = config[key].fetch('template_file')
			defaults_file = config[key].fetch('defaults_file', nil)

			logger.debug "Templating files from #{source_file} with #{template_file}"

			te = TemplateEngine.new(source_file, template_file, defaults_file)
			te.create_file_contents
			te.export_file(export_file_name)

			logger.info 'Template created, file exported.'
		end
	end

end

