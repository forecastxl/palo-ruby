# Require all rb files
Dir[File.dirname(__FILE__) + '/palo/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/palo/**/*.rb'].each {|file| require file }

module Palo
  def self.login(host, port, username, password)
    Session.new(host, port, username, password)
  end

  def self.version_string
    "Palo version #{Palo::VERSION}"
  end

  # iets => Iets, nog_iets => NogIets
  def self.camelize(term, uppercase_first_letter = true)
    string = term.to_s
    if uppercase_first_letter
      string = string.sub(/^[a-z\d]*/) { $&.capitalize }
    else
      string = string.sub(/^(?:(?=\b|[A-Z_])|\w)/) { $&.downcase }
    end
    string.gsub(/(?:_|(\/))([a-z\d]*)/) { "#{$2.capitalize}" }.gsub('/', '::')
  end

  # generic error
  class PaloError < Exception; end
end
