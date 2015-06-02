module Palo
  module Database
    class Save < Palo::Request
      def initialize(session)
        super(session)
        @request              = '/database/save'
        @request_params       = %w(database name_database sid)
        @response_keys        = %w(OK)
        @single_response      = true
      end
    end
  end
end

<<-eos
  request url http://[SERVER]:[PORT]/database/save[?PARAMETER1=value[&...]]
  short description Saves a database to disk.
  long description  To save cube data use the request "/cube/save".
  parameters
  name  type  description
  database  identifier  Identifier of the database
  sid string  Session identifier for a server connection. Use the /server/login request to get a valid session identifier.
  result
  # name  type  description
  0 OK  boolean "1" means OK
eos
