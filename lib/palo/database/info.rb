module Palo
  module Database
    class Info < Palo::Request
      def initialize(session)
        super(session)
        @request              = '/database/info'
        @request_params       = %w(database name_database sid)
        @response_keys        = %w(database name_database number_dimensions number_cubes status type database_token)
        @trim_quotes          = %w(name_database)
        @single_response      = true
      end
    end
  end
end

<<-eos
  request url http://[SERVER]:[PORT]/database/info[?PARAMETER1=value[&...]]
  short description Returns database information.
  long description
  parameters
  name  type  description
  database  identifier  Identifier of the database
  sid string  Session identifier for a server connection. Use the /server/login request to get a valid session identifier.
  result
  # name  type  description
  0 database  identifier  Identifier of the database
  1 name_database string  Name of the database
  2 number_dimensions integer Number of dimensions in the database
  3 number_cubes  integer Number of cubes in the database
  4 status  integer Status of database (0=unloaded, 1=loaded and 2=changed)
  5 type  integer Type of database (0=normal, 1=system, 3=user info)
  6 database_token  integer The database token of the database
eos
