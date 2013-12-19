module Palo
  module Database
    class Cubes
      include Palo::Response

      def initialize(session)
        @session = session
      end

<<-eos
      name  type  description
      database  identifier  Identifier of the database
      show_normal identifier  Show cubes of type normal (0=do not show normal cubes, 1=show (default))
      show_system identifier  Show cubes of type system (0=do not show system cubes (default), 1=show)
      show_attribute  identifier  Show cubes of type attribute (0=do not show attribute cubes (default), 1=show)
      show_info identifier  Show cubes of type user info (0=do not show user info cubes (default), 1=show)
      show_gputype  identifier  Show cubes of type gpu type (0=do not show gpu type cubes, 1=show (default))
      sid string  Session identifier for a server connection. Use the /server/login request to get a valid session identifier.
eos
      def execute(params = {})
        response = @session.query('/database/cubes', params)
        split_response(response, :parse_line)
      end

<<-eos
      # name  type  description
      0 cube  identifier  Identifier of the cube
      1 name_cube string  Name of the cube
      2 number_dimensions integer Number of dimensions
      3 dimensions  integer Comma separated list of dimension identifiers
      4 number_cells  integer Total number of cells
      5 number_filled_cells integer Number of filled numeric base cells plus number of filled string cells
      6 status  integer Status of cube (0=unloaded, 1=loaded and 2=changed)
      7 type  integer Type of cube (0=normal, 1=system, 2=attribute, 3=user info, 4=gpu type)
      8 cube_token  integer The cube token of the cube
eos
      def parse_line(values)
        keys = %w(cube name_cube number_dimensions dimensions number_cells number_filled_cells status type cube_token)
        result = Hash[keys.zip(values)]
        trim_quotes result, 'name_cube'
        result
      end
    end
  end
end