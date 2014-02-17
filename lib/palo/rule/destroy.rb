module Palo
  module Rule
    class Destroy < Palo::Request
      def initialize(session)
        super(session)
        @request              = '/rule/destroy'
        @request_params       = %w(database cube rule sid)
        @response_keys        = %w(OK)
        @single_response      = true
      end
    end
  end
end

<<-eos
  request url http://[SERVER]:[PORT]/rule/destroy[?PARAMETER1=value[&...]]
  short description Removes an enterprise rule from a cube
  long description  
  parameters  
  name  type  description
  database  identifier  Identifier of a database
  cube  identifier  Identifier of a cube (if parameter is not specified all rules of the cube are removed)
  rule  string  Comma separated list of rule identifiers to be deleted
  sid string  Session identifier for a server connection. Use the /server/login request to get a valid session identifier.
  result  
  # name  type  description
  0 OK  boolean "1" means OK
eos
