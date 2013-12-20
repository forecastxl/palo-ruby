module Palo
  module Cell
    class Base
      def initialize(session)
        @session = session
      end

      # Delegate methods to enable requests like 'server.databases(params)'
      %w(area copy drillthrough export goalseek replace replace_bulk value values).each do |meth|
        define_method(meth) do |args = {}|
          Palo::Cell.const_get(Palo.camelize(meth)).new(@session).execute(args)
        end
      end
    end

  end
end