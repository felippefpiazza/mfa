class Token < ActiveRecord::Base
  has_many  :auth_tokens
  belongs_to  :client
  
  def authenticate(token)
    return self.token_key == token
  end
  
end
