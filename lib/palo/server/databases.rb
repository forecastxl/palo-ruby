module Palo
  module Server
    class Databases < Palo::Request
      def initialize(session)
        super(session)
        @request              = '/server/databases'
        @request_params       = %w(show_normal show_system show_user_info sid)
        @response_keys        = %w(database name_database number_dimensions number_cubes status type database_token)
        @trim_quotes          = %w(name_database)
      end
    end
  end
end

<<-eos
  request url http://[SERVER]:[PORT]/server/databases[?PARAMETER1=value[&...]]
  short description Returns the list of databases.
  long description  Passible status of a database
  unloaded: the saved databases is not loaded to memory. Number of of dimensions and cubes are not set.
  loaded: the database is loaded into memory and no modifications have been made since the last save.
  changed: the database is loaded into memory and modifications exists since the last save. Or the database is newly created.
  parameters
  name  type  description
  show_normal identifier  Show databases of type normal (0=do not show normal databases, 1=show (default))
  show_system identifier  Show databases of type system (0=do not show system databases (default), 1=show)
  show_user_info  identifier  Show databases of type user info (0=do not show user info databases (default), 1=show)
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