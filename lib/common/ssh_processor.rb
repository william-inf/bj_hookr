require 'net/ssh'

class SSHProcessor

	def initialize(ssh_details)

	end

	def with_ssh(&block)
		Net::SSH.start({}) do |ssh|
				p ssh.exec!(block.call) if block_given?
		end
	end


end

# ssh = SSHProcessor.new('')
# command = "ls -x"
# ssh.with_ssh { command }
