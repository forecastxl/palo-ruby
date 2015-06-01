module Palo
  module Element
    class Replace < Palo::Request
      def initialize(session)
        super(session)
        @request              = '/element/replace'
        @request_params       = %w(database name_database dimension name_dimension element name_element type children name_children weights sid)
        @response_keys        = %w(element name_element position level indent depth type number_parents parents number_children children weights)
        @trim_quotes          = %w(name_element)
        @single_response      = true
      end
    end
  end
end

<<-eos
  request url http://[SERVER]:[PORT]/element/replace[?PARAMETER1=value[&...]]
  short description Creates or updates an element
  long description  This request creates or changes an element. For consolidated elements this request replaces the existing elements with the given children elements.
  parameters
  name  type  description
  database  identifier  Identifier of a database
  dimension identifier  Identifier of a dimension
  element identifier  Identifier of an element.
  name_element  string  Name of an element. (alternative parameter for "element")
  type  integer Type of the element (1=NUMERIC, 2=STRING, 4=CONSOLIDATED)
  children  identifier  Comma separated list of children identifiers. (Only for type=4)
  weights double  Optional comma separate list of children weight. (defaults to weight=1 for each child) (Only for type=4)
  sid string  Session identifier for a server connection. Use the /server/login request to get a valid session identifier.
  result
  # name  type  description
  0 element identifier  Identifier of the element
  1 name_element  string  Name of the element
  2 position  integer Position of the element
  3 level integer Level of the element
  4 indent  integer Indent of the element
  5 depth integer Depth of the element
  6 type  integer Type of the element (1=NUMERIC, 2=STRING, 4=CONSOLIDATED)
  7 number_parents  integer Number of parents
  8 parents identifier  Comma separated list of parent identifiers
  9 number_children integer Number of children
  10  children  identifier  Comma separated list of children identifiers
  11  weights double  Comma separated list of children weights
eos
