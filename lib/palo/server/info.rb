module Palo
  module Server
    class Info < Palo::Request
      def initialize(session)
        super(session)
        @request              = '/server/info'
        @response_keys        = %w(major_version minor_version type_version build_number encryption https_port data_token)
        @single_response      = true
      end
    end
  end
end

<<-eos
  request url http://[SERVER]:[PORT]/server/info[?PARAMETER1=value[&...]]
  short description Information about the server
  long description  Returns information about the server, i. e. its version number.
  parameters  
  name  type  description
  - - Needs no parameter
  result  
  # name  type  description
  0 major_version integer major version of the server
  1 minor_version integer minor version of the server
  2 type_version  integer used to distinct type of the server(1 - ST 32bit, 2 - MT 32bit, 3 - ST 64bit, 4 - MT 64bit, 5 - GPU 64bit)
  3 build_number  integer build number of the server
  4 encryption  integer 0 for none, 1 for optional, 2 for required
  5 https_port  integer the corresponding HTTPS port or 0 if HTTPS is not supported
  6 data_token  token Data token. Changed by every write operations.
eos