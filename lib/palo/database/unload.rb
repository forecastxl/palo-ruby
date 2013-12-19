module Palo
  module Database
    class Unload
      include Palo::Response

      def initialize(session)
        @session = session
      end

<<-eos
      name  type  description
      database  identifier  Identifier of the database
      sid string  Session identifier for a server connection. Use the /server/login request to get a valid session identifier.
eos
      def execute(params = {})
        response = @session.query('/database/unload', params)
        split_response(response, :parse_line)[0]
      end

<<-eos
      # name  type  description
      0 OK  boolean "1" means OK
eos
      def parse_line(values)
        keys = %w(OK)
        result = Hash[keys.zip(values)]
        result
      end
    end
  end
end