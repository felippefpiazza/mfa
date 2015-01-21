class Client < ActiveRecord::Base
  has_many  :auth_sms
  has_many  :auth_token
  has_many :token
  include Authentication

  
  
end
