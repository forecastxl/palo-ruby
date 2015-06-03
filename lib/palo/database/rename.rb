module Palo
  module Database
    class Rename < Palo::Request
      def initialize(session)
        super(session)
        @request              = '/database/rename'
        @request_params       = %w(database name_database new_name sid)
        @response_keys        = %w(database name_database number_dimensions number_cubes status type)
        @strip_quotes         = %w(name_database)
        @single_response      = true
      end
    end
  end
end

<<-eos
  request url http://[SERVER]:[PORT]/database/rename[?PARAMETER1=value[&...]]
  short description Renames a database.
  long description
  parameters
  name  type  description
  database  identifier  Identifier of the database
  new_name  string  New name of the database
  sid string  Session identifier for a server connection. Use the /server/login request to get a valid session identifier.
  result
  # name  type  description
  0 database  identifier  Identifier of the database
  1 name_database string  Name of the database
  2 number_dimensions integer Number of dimensions in the database
  3 number_cubes  integer Number of cubes in the database
  4 status  integer Status of database (0=unloaded, 1=loaded and 2=changed)
  5 type  integer Type of database (0=normal, 1=system)
eos
