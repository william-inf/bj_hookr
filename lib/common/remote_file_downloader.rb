require 'net/http'
require 'open-uri'

class RemoteFileDownloader

  def self.retrieve_remote_file(url, local_dir, filename)
    File.open(File.join(local_dir, filename), 'w') do |f|
      IO.copy_stream(open(url), f)
    end
  end

end


