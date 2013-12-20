module Palo
  module Cell
    class Area < Palo::Request
      def initialize(session)
        super(session)
        @request              = '/cell/area'
        @request_params       = %w(database cube area function expand show_rule show_lock_info properties sid)
        @response_keys        = %w(type exists value path rule lock_info property_values)
        @trim_quotes          = %w(value property_values)
      end
    end
  end
end

<<-eos
  request url http://[SERVER]:[PORT]/cell/area[?PARAMETER1=value[&...]]
  short description Shows values of cube cells
  long description  The default aggregation function for consolidated cells is SUM. The type of aggregation can be changed by 'function' parameter. In such case the usage of 'expand' parameter is mandatory.
  parameters  
  name  type  description
  database  identifier  Identifier of a database
  cube  identifier  Identifier of a cube
  area  area  Comma separated list of element identifiers list. Each element identifiers list is colon separated. The area is the cartesian product.
  function  integer Optional aggregation function.
  (1=AVG, 2=COUNT, 3=MAX, 4=MIN)
  expand  integer Comma separated list of expand functions.
  (1=SELF, 2=CHILDREN, 4=LEAVES)
  show_rule boolean If 1, then additional information about the cell value is returned, in case the value originates from an enterprise rule.
  show_lock_info  boolean If 1, then additional information about the cell lock is returned.
  properties  identifier  Comma separated list of cell property ids.
  sid string  Session identifier for a server connection. Use the /server/login request to get a valid session identifier.
  result  
  # name  type  description
  0 type  integer Type of the value (1=NUMERIC, 2=STRING)
  1 exists  boolean 1 if numeric value is non-zero or string value is non-empty
  2 value double/string Value of the cell
  3 path  path  Comma separated list of element identifiers (path of cube cell)
  4 rule  identifier  Identifier of the rule, this cell values originates from or empty. Only available if show_rule is 1.
  5 lock_info identifier  Lock info (0 - cell is not locked, 1 - cell is locked by user wich sent request, 2 - cell is locked by another user). Only available if show_lock_info is 1.
  6 property_values double/string Values of specified cell properties.
eos