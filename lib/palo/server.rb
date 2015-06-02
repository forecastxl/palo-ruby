module Palo
  module Server
    class Base
      def initialize(session)
        @session = session
      end

      # Delegate methods to enable requests like 'server.databases(params)'
      %w(databases info licenses load login logout save shutdown change_password user_info
        activate_license).each do |meth|
        define_method(meth) do |args = {}|
          Palo::Server.const_get(Palo.camelize(meth)).new(@session).execute(args)
        end
      end
    end
  end
end
