module Palo
  module Rule
    class Modify < Palo::Request
      def initialize(session)
        super(session)
        @request              = '/rule/modify'
        @request_params       = %w(database cube rule definition activate external_identifier comment use_identifier sid)
        @response_keys        = %w(rule rule_string external_identifier comment timestamp active)
        @trim_quotes          = %w(rule_string comment)
      end
    end
  end
end

<<-eos
  request url http://[SERVER]:[PORT]/rule/modify[?PARAMETER1=value[&...]]
  short description Modifies an enterprise rule for a cube. Use the parameter "definition" for changing the rule or use the parameter "activate" for activating and deactivating.
  long description  
  parameters  
  name  type  description
  database  identifier  Identifier of a database
  cube  identifier  Identifier of a cube
  rule  string  Comma separated list of rule identifiers to be modified. If definition is specified, only first rule is modified!
  definition  string  Urlencoded enterprise rule
  activate  integer activate rule with "1", deactivate rule with "0" or toggle rule active state with "2"
  external_identifier string  Urlencoded external identifier
  comment string  Urlencoded comment
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