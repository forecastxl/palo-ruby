module Palo
  module Rule
    class Parse < Palo::Request
      def initialize(session)
        super(session)
        @request              = '/rule/parse'
        @request_params       = %w(database cube functions definition sid)
        @response_keys        = %w(xml_rule)
        @trim_quotes          = %w(xml)
      end
    end
  end
end

<<-eos
  request url http://[SERVER]:[PORT]/rule/parse[?PARAMETER1=value[&...]]
  short description Parse an enterprise rule
  long description  Parse a definition of an enterprise rule. You can either supply a database and a cube or a list of functions. If you supply a database and a cube then the areas are validated against the cube and the allowed functions are the standard functions. If you supply a list of functions than no validation of the areas are performed and only functions and operators from the given list are allowed.
  parameters  
  name  type  description
  database  identifier  Identifier of a database
  cube  identifier  Identifier of a cube
  functions string  List of function names
  definition  string  Urlencoded enterprise rule
  sid string  Session identifier for a server connection. Use the /server/login request to get a valid session identifier.
  result  
  # name  type  description
  0 xml_rule  string  XML representation of the enterprise rule.
eos