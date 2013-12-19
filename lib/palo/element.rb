module Palo
  module Element
    class Base
      def initialize(session)
        @session = session
      end

      # Delegate methods to enable requests like 'server.databases(params)'
      %w(append create create_bulk destroy destroy_bulk info move rename replace replace_bulk).each do |meth|
        define_method(meth) do |args = {}|
          Palo::Element.const_get(Palo.camelize(meth)).new(@session).execute(args)
        end
      end
    end

  end
end