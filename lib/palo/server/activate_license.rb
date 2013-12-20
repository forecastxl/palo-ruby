module Palo
  module Server
    class ActivateLicense < Palo::Request
      def initialize(session)
        super(session)
        @request              = '/server/activate_license'
        @request_params       = %w(lickey actcode sid)
        @response_keys        = %w(OK)
        @single_response      = true
      end
    end
  end
end

<<-eos
  request url http://[SERVER]:[PORT]/server/activate_license[?PARAMETER1=value[&...]]
  short description Activate license
  long description  Activates license key with activation code
  parameters  
  name  type  description
  lickey  string  License key
  actcode string  Activation code. When empty license is deactivated.
  sid string  Session identifier for a server connection. Use the /server/login request to get a valid session identifier.
  result  
  # name  type  description
  0 OK  boolean "1" means OK
eos