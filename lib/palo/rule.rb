module Palo
  module Rule
    class Base
      def initialize(session)
        @session = session
      end

      # Delegate methods to enable requests like 'server.databases(params)'
      %w(create destroy functions info modify parse).each do |meth|
        define_method(meth) do |args = {}|
          Palo::Rule.const_get(Palo.camelize(meth)).new(@session).execute(args)
        end
      end
    end

  end
end