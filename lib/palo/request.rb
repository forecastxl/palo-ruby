module Palo
  # A base class for a request to the palo server.
  # Subclass each command in the palo api docs and provide request specific
  # parameters in the initialize method of the subclass.
  # Overwrite public methods if needed, but restrict it to an implementation
  # that returns parameterized and sanitized responses that reflect the
  # direct specification as found in the (copied) api docs.
  class Request
    def initialize(session)
      @session = session

      # The url part of the request, like '/server/databases'. Must be set.
      @request = nil

      # Copy this from the palo api docs.
      @request_params = []
      
      # The columns of the response rows, copy from palo api docs.
      @response_keys = []

      @trim_quotes = []                 

      # If this request always return one row of data, like 'create'.
      # Or a request that only returns OK = 1, like 'destroy'.
      @single_response = false
    end

    # Execute the request and return the result with each row as parameterized 
    # and treated according to the settings of the request.
    def execute(params = {})
      response = @session.query(@request, params)
      puts response
      parse_response(response)
    end

    # Parse the whole response. 
    # Return a single row of the result data according to settings of the request.
    def parse_response(response)
      result = split_response(response, :parse_line)
      @single_response ? result.shift : result
    end

    # Parameterize and sanitize a single line of the response.
    # Overwrite if needed, opening with 'values = super(values)' is a good start.
    def parse_line(values)
      result = Hash[@response_keys.zip(values)]
      @trim_quotes.each { |e| result[e].gsub!(TRIM_REGEX, '') if result[e].is_a?(String) }
      result
    end

  private

    TRIM_REGEX = /[\A\\\"]|[\\\"\z]/
    
    # Keep everything private so nobody accidentaly makes a call like
    # `session.server.split("haha")`

    def split_lines(str)
      str.split("\n")
    end

    def split_columns(str)
      str.split(";", -1)
    end

    def split_response(str, row_func)
      split_lines(str).map { |e| self.send(row_func, split_columns(e)) }
    end

    def trim_extra_quotes(str)
      str.gsub(TRIM_REGEX, '')
    end

    # String type columns must have that nasty \" trimmed
    def trim_quotes(hash, *elements)
      elements.each { |e| hash[e].gsub!(TRIM_REGEX, '') }
      hash
    end

  end
end