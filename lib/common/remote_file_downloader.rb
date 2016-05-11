require 'net/http'
require 'open-uri'

class RemoteFileDownloader

  def self.retrieve_remote_file(url, local_dir, filename)
    FileUtils.mkdir_p(local_dir) unless File.directory? local_dir
    File.open(File.join(local_dir, filename), 'w') do |f|
      IO.copy_stream(open(url), f)
    end
  end

end


