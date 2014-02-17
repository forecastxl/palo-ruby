module Palo
  module Rule
    class Functions < Palo::Request
      def initialize(session)
        super(session)
        @request              = '/rule/functions'
        @request_params       = %w(sid)
        @response_keys        = %w(xml_functions)
        @trim_quotes          = %w(xml_functions)
      end
    end
  end
end

<<-eos
  request url http://[SERVER]:[PORT]/rule/functions[?PARAMETER1=value[&...]]
  short description List of available functions
  long description  
  parameters  
  name  type  description
  sid string  Session identifier for a server connection. Use the /server/login request to get a valid session identifier.
  result  
  # name  type  description
  0 xml_functions string  XML representation of the functions.
eos
