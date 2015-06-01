module Palo
  module Dimension
    class Info < Palo::Request
      def initialize(session)
        super(session)
        @request              = '/dimension/info'
        @request_params       = %w(database name_database dimension name_dimension sid)
        @response_keys        = %w(dimension name_dimension number_elements maximum_level maximum_indent maximum_depth type attributes_dimension attributes_cube rights_cube dimension_token)
        @trim_quotes          = %w(name_dimension)
        @single_response      = true
      end
    end
  end
end

<<-eos
  request url http://[SERVER]:[PORT]/dimension/info[?PARAMETER1=value[&...]]
  short description Returns dimension information.
  long description
  parameters
  name  type  description
  database  identifier  Identifier of a database
  dimension identifier  Identifier of a dimension
  sid string  Session identifier for a server connection. Use the /server/login request to get a valid session identifier.
  result
  # name  type  description
  0 dimension identifier  Identifier of the dimension
  1 name_dimension  string  Name of the dimension
  2 number_elements integer Number of elements
  3 maximum_level integer Maximum level of the dimension
  4 maximum_indent  integer Maximum indent of the dimension
  5 maximum_depth integer Maximum depth of the dimension
  6 type  integer Type of dimension (0=normal, 1=system, 2=attribute, 3=user info, 4=system id)
  7 attributes_dimension  identifier  Identifier of the attributes dimension of a normal dimension or the identifier of the normal dimension associated to a attributes dimension.
  8 attributes_cube identifier  Identifier of the attributes cube. (only for normal dimensions)
  9 rights_cube identifier  Identifier of the rights cube. (only for normal dimensions)
  10  dimension_token integer The dimension token of the dimension
eos
