module Palo
  module Dimension
    class Destroy < Palo::Request
      def initialize(session)
        super(session)
        @request              = '/dimension/destroy'
        @request_params       = %w(database dimension sid)
        @response_keys        = %w(OK)
        @single_response      = true
      end
    end
  end
end

<<-eos
  request url http://[SERVER]:[PORT]/dimension/destroy[?PARAMETER1=value[&...]]
  short description Deletes a dimension
  long description  
  parameters  
  name  type  description
  database  identifier  Identifier of a database
  dimension identifier  Identifier of a dimension
  sid string  Session identifier for a server connection. Use the /server/login request to get a valid session identifier.
  result  
  # name  type  description
  0 OK  boolean "1" means OK
eos