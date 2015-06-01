module Palo
  module Element
    class Info < Palo::Request
      def initialize(session)
        super(session)
        @request              = '/element/info'
        @request_params       = %w(database name_database dimension name_dimension element name_element sid)
        @response_keys        = %w(element name_element position level indent depth type number_parents parents number_children children weights)
        @trim_quotes          = %w(name_element)
        @single_response      = true
      end
    end
  end
end

<<-eos
  request url http://[SERVER]:[PORT]/element/info[?PARAMETER1=value[&...]]
  short description Shows the element data.
  long description  The elements of a dimension form a hierarchy. An element of a dimension can have one or more children. The children form an ordered list. An element can have zero, one, or more parents. The parents form an ordered list. An element without children is called a base-element, an element with children is called a consolidated element. In addition to the hierarchy all elements of a dimension are kept in an ordered list. The position of an element is its position in this ordered list. The level describes how high an element is located in the dimension hierarchy. It starts with level 0 at the base-elements counting toward the height of the hierarchy at the root nodes. That is to say, the level of an element is the length of the longest path of the element to one of the base-elements. The depth of an element is analogon but starting from the root nodes. It starts with depth 0 at the root- nodes counting toward the height of the hierarchy at the base-elements. That i say, the depth of an element is the length of the longest path of the element to one of the root nodes. The indent is almost the same as the depth with the excepting that only the first parent of an element is taken into account.
  parameters
  name  type  description
  database  identifier  Identifier of a database
  dimension identifier  Identifier of a dimension
  element identifier  Identifier of an element
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
