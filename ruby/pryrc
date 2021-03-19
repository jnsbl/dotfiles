def uu_login(credentials = nil)
  begin
    require 'uu/os/util/request_id'
  rescue LoadError => e
    puts "WARNING: Failed to load uu/os/util/request_id. Cause: #{e.message}\n\tIf another required file/gem depends on it, install uu_os_commons gem and try again."
  end
  require 'uu/os/security/session'
  credentials ||= '21-1'
  UU::OS::Security::Session.login(credentials)
end
