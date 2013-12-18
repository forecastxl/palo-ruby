require 'digest/md5'
require "excon"

module Palo
  class Session
    attr_reader :base_url, :sid

    def initialize(host, port, username, password)
      @base_url = "http://#{host}:#{port}"
      @sid = false
      login(username, password)
    end

    def connection
      @connection ||= Excon.new(@base_url)
    end

    # Login to PALO server and store SessionID
    def login(username, password)
      query = {
        user: username,
        password: Digest::MD5.hexdigest(password)
      }
      response = connection.get(path: '/server/login', query: query)
      raise PaloError, response.body unless response.status == 200
      @sid = response.body.split(';')[0]
    end

    # Perform a raw PALO query, raise PaloError if something went wrong
    def query(command, params = {})
      params['sid'] = @sid
      response = connection.get(path: command, query: params)
      raise PaloError, response.body unless response.status == 200
      response.body
    end

    %w(server database dimension element cube cell).each do |meth|
      define_method(meth) { Palo.const_get(meth.capitalize).new(self) }
    end

  end
end
