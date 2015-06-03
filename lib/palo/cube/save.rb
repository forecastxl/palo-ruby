module Palo
  module Cube
    class Save < Palo::Request
      def initialize(session)
        super(session)
        @request              = '/cube/save'
        @request_params       = %w(database name_database cube name_cube sid)
        @response_keys        = %w(OK)
        @single_response      = true
      end
    end
  end
end

<<-eos
  request url http://[SERVER]:[PORT]/cube/save[?PARAMETER1=value[&...]]
  short description Saves cube data to disk
  long description
  parameters
  name  type  description
  database  identifier  Identifier of a database
  cube  identifier  Identifier of a cube
  sid string  Session identifier for a server connection. Use the /server/login request to get a valid session identifier.
  result
  # name  type  description
  0 OK  boolean "1" means OK
eos
