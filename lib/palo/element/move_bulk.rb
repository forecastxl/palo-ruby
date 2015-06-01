module Palo
  module Element
    class MoveBulk < Palo::Request
      def initialize(session)
        super(session)
        @request              = '/element/move_bulk'
        @request_params       = %w(database name_database dimension name_dimension elements name_elements positions sid)
        @response_keys        = %w(OK)
        @single_response      = true
      end
    end
  end
end

<<-eos
  request url http://[SERVER]:[PORT]/element/move_bulk[?PARAMETER1=value[&...]]
  short description Changes the position of elements
  long description
  parameters
  name  type  description
  database  identifier  Identifier of a database
  name_database   string  Name of the database. Used only if database parameter is omitted.
  dimension identifier  Identifier of a dimension
  name_dimension  string  Name of the dimension. Used only if dimension parameter is omitted.
  elements  string  Comma separated list of element identifiers
  name_elements string  Comma separated list of element names. Used only if elements parameter is omitted.
  positions   integer   Comma separated list of new positions of elements
  sid string  Session identifier for a server connection. Use the /server/login request to get a valid session identifier.
  result
  # name  type  description
  0 OK  boolean "1" means OK
eos
