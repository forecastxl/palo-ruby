module Palo
  module Cell
    class Values < Palo::Request
      def initialize(session)
        super(session)
        @request              = '/cell/values'
        @request_params       = %w(database cube paths show_rule show_lock_info properties sid)
        @response_keys        = %w(type exists value rule lock_info property_values)
        @trim_quotes          = %w(value property_values)
      end
    end
  end
end

<<-eos
  request url http://[SERVER]:[PORT]/cell/values[?PARAMETER1=value[&...]]
  short description Shows the values of cube cells
  long description  
  parameters  
  name  type  description
  database  identifier  Identifier of a database
  cube  identifier  Identifier of a cube
  paths path  Colon separated list of comma separated element identifiers
  show_rule boolean If 1, then additional information about the cell value is returned, in case the value originates from an enterprise rule.
  show_lock_info  boolean If 1, then additional information about the cell lock is returned.
  properties  identifier  Comma separated list of cell property ids.
  sid string  Session identifier for a server connection. Use the /server/login request to get a valid session identifier.
  result  
  # name  type  description
  0 type  integer Type of the value (1=NUMERIC, 2=STRING, 99=ERROR)
  1 exists/error  integer 1 if numeric value is non-zero or string value is non-empty. In case of an error the error code.
  2 value double/string Value of the cell. In case of an error the error message
  3 rule  identifier  Identifier of the rule, this cell values originates from or empty. Only available if show_rule is 1.
  4 lock_info identifier  Lock info (0 - cell is not locked, 1 - cell is locked by user wich sent request, 2 - cell is locked by another user). Only available if show_lock_info is 1.
  5 property_values double/string Values of specified cell properties.
eos