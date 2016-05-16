require 'net/ssh'
require 'net/sftp'
require 'find'
require 'fileutils'
require_relative '../../lib/logging'
require_relative '../../lib/common/ssh_processor'
require_relative '../../lib/common/exceptions'


class RemoteFileSystemHelpers
  include Logging

  FILE_PERM = 0644
  DIR_PERM = 0755
  TOMCAT_WEBAPPS_FOLDER = '/var/lib/tomcat7/webapps/'

  def self.copy_remote_files(local_path, remote_path, ssh_details)
    logger.debug 'Opening connection to being file uploading process'
    Net::SSH.start(ssh_details[:host], ssh_details[:user], password: ssh_details[:password]) do |ssh|
      logger.debug 'Connection to host open'
      ssh.sftp.connect do |sftp|
        logger.info 'Begin file uploading process'

        Find.find(local_path) do |local_file|
          next if File.stat(local_file).directory?
          logger.debug "Checking local file: #{File.basename(local_file)}"

          remote_file = remote_path + File.basename(local_file)
          remote_dir = File.dirname(remote_file)

          # Check if the directory exists, if it doesn't, create it.
          begin
            logger.debug "Checking if remote dir [#{remote_dir}] exists..."
            sftp.stat!(remote_dir)
            logger.debug '... directory exists.'
          rescue Net::SFTP::StatusException => e
            unless e.code == 2
              logger.error "Error hit attempting to check directory. Re-raising error. [message][#{e.message}]"
              raise e
            end
            logger.debug "Making directory [#{remote_dir}] with permissions [#{DIR_PERM}]"
            sftp.mkdir(remote_dir, :permissions => DIR_PERM)
          end

          # Check if remote file exists and is the same file, otherwise upload it.
          begin
            logger.debug "Checking if remote file [#{remote_file}] exists"
            remote_stat = sftp.stat!(remote_file)

            logger.debug 'Remote file exists, going to check if its the same file...'
            if File.stat(local_file).mtime > Time.at(remote_stat.mtime)
              logger.debug "Copying #{local_file} to #{remote_file}"
              sftp.upload!(local_file, remote_file)
              logger.debug 'File uploaded, no further action'
            else
              logger.debug '... remote file is the same as local file, not further action.'
            end

          rescue Net::SFTP::StatusException => e
            unless e.code == 2
              logger.error "Error hit attempting to check file. Re-raising error. [message][#{e.message}]"
              raise e
            end
            logger.debug 'File doesnt exist, needs to be uploaded.'
            begin
              sftp.upload!(local_file, remote_file)
              sftp.setstat(remote_file, :permissions => FILE_PERM)
              logger.debug 'File uploaded, no further action.'
            rescue Net::SFTP::StatusException => e
              if e.code == 3
                logger.error "Cannot upload file, permissions error. [error][#{e.message}]"
              else
                logger.error "Cannot upload file. [error][#{e.message}]"
              end

            end

          end
            logger.info "Processing complete for #{File.basename(local_file)}"
        end
      end

    end
  end

  def self.install_war_file(app_name, war_file_path, ssh_details)
    logger.info 'Installing WAR file to Tomcat7'

    begin
      ssh = SSHProcessor.new(ssh_details)
      logger.debug 'Stopping Tomcat7 service'
      ssh.with_ssh { 'sudo service tomcat7 stop' }
      logger.debug 'Removing old WAR files'
      ssh.with_ssh { "sudo rm -rf #{File.join(TOMCAT_WEBAPPS_FOLDER,app_name)}*" }
      logger.debug 'Copying over new WAR'
      ssh.with_ssh { "sudo cp #{war_file_path} #{TOMCAT_WEBAPPS_FOLDER}" }
      logger.debug 'Unzipping WAR file'
      ssh.with_ssh { "sudo unzip #{File.join(TOMCAT_WEBAPPS_FOLDER, File.basename(war_file_path))} -d #{File.join(TOMCAT_WEBAPPS_FOLDER,app_name)}" }
      logger.debug 'Starting Tomcat7 service'
      ssh.with_ssh { 'sudo service tomcat7 start' }
      logger.debug 'Process complete.'
    rescue SSHStandardError => e
      logger.error "Error in SSH commands. Cannot proceed. Message: #{e.message}"
      raise StandardError.new(e.message)
    end
  end

end

