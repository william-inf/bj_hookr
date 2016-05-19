require 'net/ssh'
require_relative '../../lib/logging'
require_relative '../../lib/common/exceptions'

class SSHProcessor
	include Logging

	def initialize(ssh_details)
		@host = ssh_details[:host]
		@username = ssh_details[:user]
		@password = ssh_details[:password]
	end

	def with_ssh(&block)
		begin
			Net::SSH.start(@host, @username, password: @password) do |ssh|
				if block_given?
					res = ssh.exec!(block.call)
					# TODO: handle error'd responses better.
					if res.scan(/^(bash:).*|(sudo:).*$/).count > 0
						raise InvalidSSHCommand.new "Problem executing command. '#{res.gsub("\n", '')}'"
					end
				else
					logger.warn 'No block given. Please pass a block when calling to SSH.'
				end
			end
		rescue InvalidSSHCommand => e
			logger.error "InvalidSSHCommand: #{e.message}"
			raise e
		rescue SocketError => e
			logger.error "SocketError: Server unknown.  Most likely a problem with config settings. [message][#{e.message}]"
			raise SSHStandardError.new(e.message)
		rescue StandardError => e
			logger.error "Could not get to host server. [message][#{e.message}]"
			raise e
		end

	end

end


