require 'digest'
require_relative '../../lib/logging'

class LocalFileSystemHelpers
  include Logging

  def self.get_files(directory)
    Dir.glob(directory + '*').map do |file|
      logger.info file.inspect
      file if File.file? file
    end
  end

  def self.copy_file(local_file, destination)
    logger.info "About to copy file #{File.basename(local_file)}"
    FileUtils.mkdir_p(destination) unless File.directory? destination

    destination_file = File.join(destination, File.basename(local_file))
    logger.debug 'Checking if file exists or has been modified.'
    copy = true
    if File.exist? destination_file
      logger.debug 'File exists, checking if it is different'

      destination_file_hash = Digest::SHA256.hexdigest(File.read(destination_file))
      local_file_hash =  Digest::SHA256.hexdigest(File.read(local_file))

      if destination_file_hash == local_file_hash
        logger.info 'Files are the same. No processing needed.'
        copy = false
      else
        logger.info 'Files are the different, processing needed.'
        copy = true
      end
    end

    if copy
      FileUtils.cp(local_file, destination_file)
    end

    logger.info "File exists: #{File.exist? destination_file}"


  end

  def self.delete_file(local_file)
    logger.debug "Deleting file: #{local_file}"
    File.delete(local_file) if File.exist? local_file
  end

end