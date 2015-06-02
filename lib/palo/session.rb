require "excon" # HTTP lib

module Palo
  class Session
    attr_reader :base_url, :sid, :debug

    def initialize(host, port, user, password)
      @user = user
      @password = password
      @base_url = "http://#{host}:#{port}"
      @debug = false
      @sid = login
    end

    # Perform a raw palo request, raise PaloError if something went wrong
    # Return the raw result from the palo db
    def query(command, params = {})
      # connection.reset
      params['sid'] = @sid
      response = connection.get(path: command, query: params, persistent: true)

      # get new sid and retry query
      unless response.status == 200
        # TODO: only trigger if the response indicates that the sid is expired
        puts "Palo query failed -> status: #{response.status}, body: #{response.body}"
        params['sid'] = login
        response = connection.get(path: command, query: params, persistent: true)
      end
      # TODO: if the response indicates that the database is not loaded
      # unless response.status == 200
      #   puts "Palo query failed -> status: #{response.status}, body: #{response.body}"
      #   params['sid'] = login
      #   response = connection.get(path: command, query: params, persistent: true)
      # end

      raise PaloError, response.body unless response.status == 200
      response.body
    end

    # When session has timed out, the sid should be invalid
    def is_valid_session?
      begin
        query('server/user_info')
        true
      rescue PaloError
        false
      end
    end

    # Delegate methods to enable requests like 'server.databases(params)'
    %w(server database dimension element cube cell rule).each do |meth|
      define_method(meth) { Palo.const_get(meth.capitalize)::Base.new(self) }
    end

    private

    def debug=(val)
      @debug = !!val
    end

    def connection
      @connection ||= Excon.new(@base_url)
    end

    # Login to palo server and store session id
    def login
      response = connection.get(path: '/server/login', query: { user: @user, password: @password })
      raise PaloError, response.body unless response.status == 200
      response.body.split(';')[0]
    end
  end
end
