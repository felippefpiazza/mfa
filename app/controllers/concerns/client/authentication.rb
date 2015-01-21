class Client
  module Authentication
    extend ActiveSupport::Concern
  
    module ClassMethods
      def authenticate(username, password)
        if (c = Client.where(username: username, password: password)).length == 1
          return c.first
        end
          return nil
      end
      
    end
  end
end