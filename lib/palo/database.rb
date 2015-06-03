module Palo
  module Database
    class Base
      def initialize(session)
        @session = session
      end

      # Delegate methods to enable requests like 'server.databases(params)'
      %w(cubes create destroy dimensions info load rename save unload).each do |meth|
        define_method(meth) do |args = {}|
          Palo::Database.const_get(Palo.camelize(meth)).new(@session).execute(args)
        end
      end
    end
  end
end
