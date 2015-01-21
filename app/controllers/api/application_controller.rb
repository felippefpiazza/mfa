class Api::ApplicationController < ApplicationController
  protect_from_forgery with: :null_session
  before_filter :restrict_access  
  
  private
  def restrict_access
     (key = ApiKey.where(access_token: request.env["HTTP_TOKEN"], 
                         revoked: false, 
                         device: request.env["HTTP_DEVICE"])).present? ? (@key = key.first) : (head :unauthorized) 
   end  
end