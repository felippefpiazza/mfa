class Api::UserController < Api::ApplicationController
  
  before_filter :restrict_access , :except => [ :auth, :auth_token , :generate_sms_token]
  
  def auth
    username = params[:username]
    password = params[:password]
    mfa_type = params[:mfa_type].downcase
    response = {auth: false, expiration: nil, :error => {:response => false, :error_msgs => []} }
    if (c = Client.authenticate(username, password)) != nil
      response[:auth] = true    
      if mfa_type == "sms"
        if (resp = send_sms_token(username))
          response[:expiration] = resp
        else
          response[:error][:response] = true
          response[:error][:error_msgs] << "Unknown User for SMS"
        end
      end
    else
      response[:auth] = false
      response[:error][:response] = true
      response[:error][:error_msgs] << "Bad Username or Password"
    end

    send_response(response)
  end
  
  def auth_token
    username = params[:username]
    token = params[:access_token]
    mfa_type = params[:mfa_type].downcase
    auth_r = "Auth".concat(mfa_type.capitalize).constantize.new
    if (a = auth_r.auth(username,token)).nil?
      ans = false
    else
      ans = true
    end
    response = {auth: ans , :error => {:response => false, :error_msgs => []}  }
    send_response(response)       
  end
  
  
  def generate_sms_token
    username = params[:username]
    if (resp = send_sms_token(username))
      response = {expiration: resp, :error => {:response => false, :error_msgs => []} }
    else
      response = {:error => {:response => true, :error_msgs => ["Unknown User"]} }
    end
    send_response(response)    
  end

end
