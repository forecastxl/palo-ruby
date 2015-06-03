module Palo
  module Server
    class Licenses < Palo::Request
      def initialize(session)
        super(session)
        @request              = '/server/licenses'
        @response_keys        = %w(licensekey customer version numconcurrent numnamed activationdate
                                   expirationdate sharinglimit numgpu features)
        @trim_quotes          = %w(licensekey customer features)
      end
    end
  end
end

<<-eos
  request url http://[SERVER]:[PORT]/server/licenses[?PARAMETER1=value[&...]]
  short description Information about the server license
  long description  First line represents server's hardware key. Other lines represent available licenses as described below.
  parameters
  name  type  description
  - - Needs no parameter
  result
  # name  type  description
  0 licensekey  string  License key
  1 customer  string  Customer name
  2 version integer License version
  3 numconcurrent integer Number of concurrent users
  4 numnamed  integer Number of named users
  5 activationdate  integer Activation date
  6 expirationdate  integer Expiration date
  7 sharinglimit  integer Sharing limit (number of users from same machine that can use one license)
  8 numgpu  integer Number of allowed GPU cards
  9 features  string  Available features
eos
