module Palo
  module Dimension
    class Dfilter < Palo::Request
      def initialize(session)
        super(session)
        @request              = '/dimension/dfilter'
        @request_params       = %w(database name_database dimension name_dimension cube name_cube area mode condition values sid)
        @response_keys        = %w(element name_element position level indent depth type number_parents parents number_children children weights type2 exists value)
        @trim_quotes          = %w(name_element exists value)
      end

      # Dfilter result has an invalid \n in every result row
      def split_response(str, row_func)
        splitted = split_lines(str)
        splitted = splitted.each_slice(2).map { |e| e.join('') }
        splitted.map { |e| self.send(row_func, split_columns(e)) }
      end

    end
  end
end

<<-eos
  request url http://[SERVER]:[PORT]/dimension/dfilter[?PARAMETER1=value[&...]]
  short description Filters dimension elements.
  long description  Filters elements according to specified conditions
  parameters
  name  type  description
  database  identifier  Identifier of a database
  dimension identifier  Identifier of a dimension
  cube  identifier  Identifier of a cube
  area  area  Comma separated list of element identifiers list. Each element identifiers list is colon separated. The area is the cartesian product. Elements for dimension specified is initial subset that will be filtered.
  mode  integer DATA_MIN = 1, DATA_MAX = 2, DATA_SUM = 4, DATA_AVERAGE = 8, DATA_ANY = 16, DATA_ALL = 32, DATA_STRING = 64, ONLY_CONSOLIDATED = 128, ONLY_LEAVES = 256, UPPER_PERCENTAGE = 512, LOWER_PERCENTAGE = 1024, MID_PERCENTAGE = 2048, TOP = 4096, NORULES = 8192
  condition string  Condition on the value of numeric or string cells (default is no condition). A condition starts with >, >=, <, <=, ==, or != and is followed by a double or a string. Two condition can be combined by and, or, xor. If you specifiy a string value, the value has to be csv encoded. Do not forget to URL encode the complete condition string.
  values  double  Values for Top, Upper % and Lower % in this order.
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
  12  type  integer Type of the accumulated value (1=NUMERIC, 2=STRING)
  13  exists  boolean 1 if numeric value is non-zero or string value is non-empty
  14  value double/string Accumulated value used for filtering
eos
