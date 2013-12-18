module Palo
  class Server
    include Response

    def initialize(session)
      @session = session
    end

    def databases
      response = @session.query('/server/databases')
      split_response(response)
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
    def databases_parse_line(values)
      keys = %w(database name_database number_dimensions number_cubes status type database_token)
      result = Hash[keys.zip(values)]
      trim_quotes result, 'name_database', 'database'
      result
    end

  end
end