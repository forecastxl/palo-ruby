module Palo
  module Cell
    class ReplaceBulk < Palo::Request
      def initialize(session)
        super(session)
        @request              = '/cell/replace_bulk'
        @request_params       = %w(database cube paths values add splash locked_paths event_processor sid)
        @response_keys        = %w(OK)
        @single_response      = true
      end
    end
  end
end

<<-eos
  request url http://[SERVER]:[PORT]/cell/replace_bulk[?PARAMETER1=value[&...]]
  short description Sets or changes the value of cube cell
  long description  The server calculates the list of all base element for a numeric path, which contains one or more consolidate element. The given value will be distributed among these base paths using the following method:
  no splashing: will result in an error message
  default:
  value = 0.0:
  clear all base paths
  value <> 0.0 and old_value = 0.0:
  compute the splash value according to the weights of the path and set this value to all base paths.
  value <> 0.0 and old_value <> 0.0:
  scale all value so that the sum is the new value.
  add: add given value to all base paths
  set: set all base paths to the given value
  Note that a cell replace bulk can only be executed within a transaction block started with push_rule/begin and ended with push_rule/end when used within a worker.
  parameters  
  name  type  description
  database  identifier  Identifier of a database
  cube  identifier  Identifier of a cube
  paths path  Colon separated list of paths. Each path is comma separated list of element identifier.
  values  double/string Colon separated list of values. Each value is the new numeric or string value for the cell corresponding to the above path. If you specifiy a string value, the value has to be csv encoded.
  add boolean If 0 (the default), then a numeric value given is stored in the cube. If 1, then a numeric value given is added to the existing value or set if no value currently exists. Setting add to 1, requires splash mode 0 or 1.
  splash  integer Optional splash mode for setting values if the comma separated list of elements contains consolidated elements.
  (0=no splashing, 1=default, 2=add, 3=set)
  locked_paths  path  Optional colon separated list of paths. Each path is comma separated list of element identifier. Splashing will not change locked paths and sources areas of these paths if they are consolidated.
  event_processor boolean If 1 (the default), then setting a new value will possibly call the supervision event processor. If 0, then the supervision event processor is circumvented. Note that you need extra permissions to use this feature.
  sid string  Session identifier for a server connection. Use the /server/login request to get a valid session identifier.
  result  
  # name  type  description
  0 OK  boolean "1" means OK
eos