module Palo
  module Cell
    class Copy < Palo::Request
      def initialize(session)
        super(session)
        @request              = '/cell/copy'
        @request_params       = %w(database name_database cube name_cube function path area path_to use_rules value locked_paths sid)
        @response_keys        = %w(OK)
        @single_response      = true
      end
    end
  end
end

<<-eos
  request url http://[SERVER]:[PORT]/cell/copy[?PARAMETER1=value[&...]]
  short description Copies a cell path or a calculated predictive value to an other cell path
  long description
  parameters
  name  type  description
  database  identifier  Identifier of a database
  cube  identifier  Identifier of a cube
  function  integer Optional predictive function.
  (0 - no prediction (default), 1 - linear regression on consolidated level)
  path  path  Source cell path used for copy (function=0). Comma separated list of element identifiers.
  area  area  Source area used for the predictive function (function=1). Comma separated list of element identifiers list. Each element identifiers list is colon separated, only one list can contain multiple elements. The area is the cartesian product.
  path_to path  Target cell path. Comma separated list of element identifiers.
  use_rules boolean If 1, then copy rule based cell values (default is 0)
  value double  The numeric value of the target cube cell. (optional)
  locked_paths  path  Optional colon separated list of paths. Each path is comma separated list of element identifier. Splashing will not change locked paths and sources areas of these paths if they are consolidated.
  sid string  Session identifier for a server connection. Use the /server/login request to get a valid session identifier.
  result
  # name  type  description
  0 OK  boolean "1" means OK
eos
