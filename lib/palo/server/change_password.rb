module Palo
  module Server
    class ChangePassword < Palo::Request
      def initialize(session)
        super(session)
        @request              = '/server/change_password'
        @request_params       = %w(user password sid)
        @response_keys        = %w(OK)
        @single_response      = true
      end
    end
  end
end

<<-eos
  request url http://[SERVER]:[PORT]/server/change_password[?PARAMETER1=value[&...]]
  short description Changes user's password.
  long description  Changes user's password.
  parameters  
  name  type  description
  user  string  The name of the user whose password should be changed. (If no user is specified - password is changed for current user)
  password  string  The plain text new password.
  sid string  Session identifier for a server connection. Use the /server/login request to get a valid session identifier.
  result  
  # name  type  description
  0 OK  boolean "1" means OK
eos