module Palo
  module Server
    class Databases
      include Palo::Response

      def initialize(session)
        @session = session
      end

<<-eos
      name  type  description
      show_normal identifier  Show databases of type normal (0=do not show normal databases, 1=show (default))
      show_system identifier  Show databases of type system (0=do not show system databases (default), 1=show)
      show_user_info  identifier  Show databases of type user info (0=do not show user info databases (default), 1=show)
      sid string  Session identifier for a server connection. Use the /server/login request to get a valid session identifier.
eos
      def execute(params = {})
        response = @session.query('/server/databases', params)
        split_response(response, :parse_line)
      end

<<-eos
      # name  type  description
      0 database  identifier  Identifier of the database
      1 name_database string  Name of the database
      2 number_dimensions integer Number of dimensions in the database
      3 number_cubes  integer Number of cubes in the database
      4 status  integer Status of database (0=unloaded, 1=loaded and 2=changed)
      5 type  integer Type of database (0=normal, 1=system, 3=user info)
      6 database_token  integer The database token of the database
eos
      def parse_line(values)
        keys = %w(database name_database number_dimensions number_cubes status type database_token)
        result = Hash[keys.zip(values)]
        trim_quotes result, 'name_database'
        result
      end
    end
  end
end