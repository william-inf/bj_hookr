require 'git'
require_relative '../../lib/logging'

#Wrapper class around ruby-git
class GitHelpers
  include Logging

  def self.get_remote_git_repo(git_url, name)
    begin
      Git.clone(git_url, name, bare: true)
    rescue StandardError => e
      # TODO: Correct error handling rather than this crude blanket approach
      logger.error "Error retrieving files from [#{git_url}] git clone #{[error][e.message]}"
      raise e
    end
  end
end