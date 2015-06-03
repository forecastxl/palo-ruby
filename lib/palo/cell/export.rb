module Palo
  module Cell
    class Export < Palo::Request
      def initialize(session)
        super(session)
        @request              = '/cell/export'
        @request_params       = %w(database name_database cube name_cube blocksize path area condition use_rules base_only skip_empty type properties sid)
        @response_keys        = %w(type exists value path property_values)
        @trim_quotes          = %w(value property_values)
      end
    end
  end
end

<<-eos
  request url http://[SERVER]:[PORT]/cell/export[?PARAMETER1=value[&...]]
  short description Exports values of cube cells
  long description  Note that the last line of the result differs from the description below. The line contains two doubles. The first describes progress of the export, the second the maximal number of exported cells not including the condition. In order to provide a progress bar, take the quotient of the first and second integer as float. This will yield a number between 0.0 and 1.0 describing the progress.
  parameters
  name  type  description
  database  identifier  Identifier of a database
  cube  identifier  Identifier of a cube
  blocksize integer Maximal number of cells to export (default is 1000)
  path  path  Begin export after the path (default is to start with first path)
  area  area  Comma separated list of element identifiers list. Each element identifiers list is colon separated. The area is the cartesian product. Default is the complete cube area.
  condition string  Condition on the value of numeric or string cells (default is no condition). A condition starts with >, >=, <, <=, ==, or != and is followed by a double or a string. Two condition can be combined by and, or, xor. If you specifiy a string value, the value has to be csv encoded. Do not forget to URL encode the complete condition string.
  use_rules boolean If 1, then export rule based cell values (default is 0)
  base_only boolean If 1, then export only base cells (default is 0)
  skip_empty  boolean If 0, then export empty cells as well (default is 1)
  type  integer Type of exported cells. 0=numeric and string, 1=only numeric, 2=only string (default is 0)
  properties  identifier  Comma separated list of cell property ids.
  sid string  Session identifier for a server connection. Use the /server/login request to get a valid session identifier.
  result
  # name  type  description
  0 type  integer Type of the value (1=NUMERIC, 2=STRING, 99=ERROR)
  1 exists  boolean 1 if numeric value is non-zero or string value is non-empty
  2 value double/string Value of the cell
  3 path  path  Comma separated list of element identifiers (path of cube cell)
  4 property_values double/string Values of specified cell properties.
eos
