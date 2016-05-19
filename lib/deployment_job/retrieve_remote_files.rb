require_relative '../../lib/common/job_template'
require_relative '../../lib/common/local_file_system_helpers'
require_relative '../../lib/common/exceptions'
require_relative '../../lib/common/remote_file_downloader'
require_relative '../../lib/logging'

class RetrieveRemoteFiles < JobTemplate
  include Logging

  JOB_NAME = 'retrieve_remote_files'

  def initialize
    super(JOB_NAME)
  end

  def process
    config = TaskModuleHelper.get_task_module[@name]
    super do
      config.keys.each do |key|
        validate_config(config[key], %w(url download_directory local_file_name))

        url = config[key]['url']
        download_directory = config[key]['download_directory']
        local_file_name = config[key]['local_file_name']
        logger.debug "Retrieving remote file #{url}"
        RemoteFileDownloader.retrieve_remote_file(url, download_directory, local_file_name)
        logger.debug 'File retrieved.'
      end
    end
  end

end

