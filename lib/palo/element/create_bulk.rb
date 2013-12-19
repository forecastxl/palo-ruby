module Palo
  module Element
    class CreateBulk
      include Palo::Response

      def initialize(session)
        @session = session
      end

<<-eos
      name  type  description
      database  identifier  Identifier of a database
      dimension identifier  Identifier of a dimension
      name_elements string  Comma separated list of names of the new elements
      type  integer Type of the element (1=NUMERIC, 2=STRING, 4=CONSOLIDATED). Either type or types must be specified, bot not both.
      types integer Type of the elements (1=NUMERIC, 2=STRING, 4=CONSOLIDATED) as comma separated list. Either type or types must be specified. If type is specified, all elements are of the same type. If types is specified, then children and weights must be empty for elements of numeric or string type. If types is specified, only name_children is allowed.
      children  identifier  Comma and colon separated list of children identifiers. (Only for type=4)
      name_children identifier  Comma and colon separated list of children names. Used only if children parameter is omitted. (Only for type=4)
      weights double  Optional comma and colon separated list of children weight. (defaults to weight=1 for each child) (Only for type=4)
      sid string  Session identifier for a server connection. Use the /server/login request to get a valid session identifier.
eos
      def execute(params = {})
        response = @session.query('/element/create_bulk', params)
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