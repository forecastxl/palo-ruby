require "palo/version"
require "palo/session"
require "palo/response"
require "palo/server"

module Palo
  def self.login(host, port, username, password)
    Session.new(host, port, username, password)
  end

  def self.version_string
    "Palo version #{Palo::VERSION}"
  end

  # generic error
  class PaloError < Exception; end
end
