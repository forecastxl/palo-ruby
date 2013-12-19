module Palo
  module Database
    class Create
      include Palo::Response

      def initialize(session)
        @session = session
      end

<<-eos
      name  type  description
      new_name  string  Name of the new database
      sid string  Session identifier for a server connection. Use the /server/login request to get a valid session identifier.
      type  identifier  Type of the database (0=normal (default), 3=user info)
eos
      def execute(params = {})
        response = @session.query('/database/create', params)
        split_response(response, :parse_line)[0]
      end

<<-eos
      # name  type  description
      0 database  identifier  Identifier of the database
      1 name_database string  Name of the database
      2 number_dimensions integer Number of dimensions in the database
      3 number_cubes  integer Number of cubes in the database
      4 status  integer Status of database (0=unloaded, 1=loaded and 2=changed)
      5 type  integer Type of database (0=normal, 1=system, 3=user info)
eos
      def parse_line(values)
        keys = %w(database name_database number_dimensions number_cubes status type)
        result = Hash[keys.zip(values)]
        trim_quotes result, 'name_database'
        result
      end
    end
  end
end