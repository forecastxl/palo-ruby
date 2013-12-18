module Palo
  class Server
    def initialize(session)
      @session = session
    end

    def databases
      response = @session.query('/server/databases')
      response.split(';')
    end
  end
end