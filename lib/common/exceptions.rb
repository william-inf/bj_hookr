class UnhandledTaskType < RuntimeError
end

class SSHStandardError < StandardError
end

class HookrJobError < RuntimeError
end

class HookrInvalidConfigError < RuntimeError
end

class InvalidSSHCommand < SSHStandardError
end

