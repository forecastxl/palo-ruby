module Palo
  module Server
    class Info
      include Palo::Response

      def initialize(session)
        @session = session
      end
    
<<-eos
      name  type  description
      - - Needs no parameter
eos
      def execute(params = {})
        response = @session.query('/server/info')
        split_response(response, :parse_line)[0]
      end

<<-eos
      # name  type  description
      0 major_version integer major version of the server
      1 minor_version integer minor version of the server
      2 type_version  integer used to distinct type of the server(1 - ST 32bit, 2 - MT 32bit, 3 - ST 64bit, 4 - MT 64bit, 5 - GPU 64bit)
      3 build_number  integer build number of the server
      4 encryption  integer 0 for none, 1 for optional, 2 for required
      5 https_port  integer the corresponding HTTPS port or 0 if HTTPS is not supported
      6 data_token  token Data token. Changed by every write operations.
eos
      def parse_line(values)
        keys = %w(major_version minor_version type_version build_number encryption https_port data_token)
        result = Hash[keys.zip(values)]
        result
      end
    end
  end
end