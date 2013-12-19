module Palo
  module Element
    class DestroyBulk
      include Palo::Response

      def initialize(session)
        @session = session
      end

<<-eos
      name  type  description
      database  identifier  Identifier of a database
      dimension identifier  Identifier of a dimension
      element identifier  Identifier of an element
      sid string  Session identifier for a server connection. Use the /server/login request to get a valid session identifier.
eos
      def execute(params = {})
        response = @session.query('/element/destroy_bulk', params)
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