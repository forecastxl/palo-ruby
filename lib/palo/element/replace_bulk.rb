module Palo
  module Element
    class ReplaceBulk < Palo::Request
      def initialize(session)
        super(session)
        @request              = '/element/replace_bulk'
        @request_params       = %w(database name_database dimension name_dimension elements
                                   name_elements type children weights sid)
        @response_keys        = %w(OK)
        @single_response      = true
      end
    end
  end
end

<<-eos
  request url http://[SERVER]:[PORT]/element/replace_bulk[?PARAMETER1=value[&...]]
  short description Creates or updates list of elements
  long description  This request creates or changes multiple elements of the same type. For consolidated elements this request replaces the existing elements with the given children elements.
  parameters
  name  type  description
  database  identifier  Identifier of a database
  dimension identifier  Identifier of a dimension
  elements  identifier  Comma separated list of elements.
  name_elements string  Comma separated list of names of elements. (alternative parameter for "elements")
  type  integer Type of the element (1=NUMERIC, 2=STRING, 4=CONSOLIDATED)
  children  identifier  Comma and colon separate list of children identifiers. (Only for type=4)
  weights double  Optional comma and colon separate list of children weight. (defaults to weight=1 for each child) (Only for type=4)
  sid string  Session identifier for a server connection. Use the /server/login request to get a valid session identifier.
  result
  # name  type  description
  0 OK  boolean "1" means OK
eos
