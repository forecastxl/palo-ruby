module Palo
  module Cube
    class Base
      def initialize(session)
        @session = session
      end

      # Delegate methods to enable requests like 'server.databases(params)'
      %w(clear commit create convert destroy info load lock locks rename rollback rules save unload).each do |meth|
        define_method(meth) do |args = {}|
          Palo::Cube.const_get(Palo.camelize(meth)).new(@session).execute(args)
        end
      end
    end
  end
end
