module Palo
  module Cell
    class Drillthrough < Palo::Request
      def initialize(session)
        super(session)
        @request              = '/cell/drillthrough'
        @request_params       = %w(database cube path mode sid)
        @response_keys        = %w(resultset)
      end
    end
  end
end

<<-eos
  request url http://[SERVER]:[PORT]/cell/drillthrough[?PARAMETER1=value[&...]]
  short description Retrieves detailed data for a cube cell.
  long description  Depending on the mode the detailed data can be:
  Historical data which track the changes of a cube cell
  Source system data if the cube cell has been loaded via an ETL-process
  User defined data
  The Event OnDrillthrough is raised in Palo Supervision-Server which contains the application logic of Drillthrough. Note that Palo Supervision-Server has to be installed separately.
  parameters  
  name  type  description
  database  identifier  Identifier of a database
  cube  identifier  Identifier of a cube
  path  path  Comma separated list of elements identifier (path of cube cell)
  mode  integer 1 - History, 2 - Details,..., n - User defined
  sid string  Session identifier for a server connection. Use the /server/login request to get a valid session identifier.
  result  
  # name  type  description
  0 resultset string  Comma separated component-values (columns) of resultset; First row: Component names of resultset-columns
eos