module Palo
  module Dimension
    class Base
      def initialize(session)
        @session = session
      end

      # Delegate methods to enable requests like 'server.databases(params)'
      %w(clear create cubes destroy element elements info rename dfilter).each do |meth|
        define_method(meth) do |args = {}|
          if meth == 'dfilter'
            Palo::Dimension.const_get(Palo.camelize(meth)).new(@session).execute2(args)
          else
            Palo::Dimension.const_get(Palo.camelize(meth)).new(@session).execute(args)
          end
        end
      end
    end
  end
end
