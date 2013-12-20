module Palo
  module Element
    class DestroyBulk < Palo::Request
      def initialize(session)
        super(session)
        @request              = '/element/destroy_bulk'
        @request_params       = %w(database dimension elements name_elements sid)
        @response_keys        = %w(OK)
        @single_response      = true
      end
    end
  end
end

<<-eos
  request url http://[SERVER]:[PORT]/element/destroy_bulk[?PARAMETER1=value[&...]]
  short description Deletes list of elements
  long description  
  parameters  
  name  type  description
  database  identifier  Identifier of a database
  dimension identifier  Identifier of a dimension
  elements  string  Comma separated list of element identifiers
  name_elements string  Comma separated list of element names. Used only if elements parameter is omitted.
  sid string  Session identifier for a server connection. Use the /server/login request to get a valid session identifier.
  result  
  # name  type  description
  0 OK  boolean "1" means OK
eos
