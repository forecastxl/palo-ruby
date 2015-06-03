module Palo
  module Rule
    class Info < Palo::Request
      def initialize(session)
        super(session)
        @request              = '/rule/info'
        @request_params       = %w(database name_database cube name_cube rule use_identifier sid)
        @response_keys        = %w(rule rule_string external_identifier comment timestamp active)
        @trim_quotes          = %w(rule_string comment)
      end
    end
  end
end

<<-eos
  request url http://[SERVER]:[PORT]/rule/info[?PARAMETER1=value[&...]]
  short description Returns information about a defined rule.
  long description
  parameters
  name  type  description
  database  identifier  Identifier of a database
  cube  identifier  Identifier of a cube
  rule  string  Comma separated list of rule identifiers to be shown
  use_identifier  boolean Use identifier in textual representation of the rule in the result. The definition can use name or identifier independent of the parameter.
  sid string  Session identifier for a server connection. Use the /server/login request to get a valid session identifier.
  result
  # name  type  description
  0 rule  identifier  Identifier of the rule
  1 rule_string string  Textual representation for the rule
  2 external_identifier string  external identifier of the rule
  3 comment string  comment for the rule
  4 timestamp string  creation time of the rule in seconds since 1970-01-01
  5 active  integer 0=rule is not active, 1=rule is active
eos
