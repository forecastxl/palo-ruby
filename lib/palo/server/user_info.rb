module Palo
  module Server
    class UserInfo < Palo::Request
      def initialize(session)
        super(session)
        @request              = '/server/user_info'
        @request_params       = %w(sid)
        @response_keys        = %w(id name groups group_names ttl)
        @trim_quotes          = %w(name group_names ttl)
        @single_response      = true
      end
    end
  end
end

<<-eos
  request url http://[SERVER]:[PORT]/server/user_info[?PARAMETER1=value[&...]]
  short description Shows information about user
  long description  Returns user's id, name and groups.
  parameters  
  name  type  description
  sid string  Session identifier for a server connection. Use the /server/login request to get a valid session identifier.
  result  
  # name  type  description
  0 id  identifier  User id
  1 name  string  User name
  2 groups  identifier  Comma separated list of user's groups
  3 group_names string  Comma separated list of user's group names
  4 ttl string  Timeout intervall in seconds. If no request is made within this intervall the session becomes inactive.
eos