module Palo
  module Response


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