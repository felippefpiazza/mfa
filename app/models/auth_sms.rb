class AuthSms < Auth
  
  
  
  def generate_access_token
    self.access_token = rand.to_s[2..7]
    
    if self.client.phone2sms[0..1] == 55
      use = "zenvia"
    else
      use = SMS_PARAMS[:sender_to_use]
    end
    
    case use
    when "mob21"
      send_mob21
    when "zenvia"
      send_zenvia
    when "smsglobal"
      send_smsglobal      
    end
  end
  
  def send_mob21
      uri = URI(SMS_PARAMS[:mob21_url])
      post_to_sms = [
                    {'user' => SMS_PARAMS[:mob21_username], 
                      'passwd' => SMS_PARAMS[:mob21_pass]}, 
                    {'msg' => 'MFA Code: ' + self.access_token, 
                      'recipient' => self.client.phone2sms, 
                      'id_sms_client' => self.id, 
                      'sender' => SMS_PARAMS[:mob21_from]}
                      ]
      ps = PHP.serialize(post_to_sms)
      res = Net::HTTP.post_form(uri, "sms" => ps)
      self.save
  end
  
  def send_zenvia
    uri = URI(SMS_PARAMS[:zenvia_url])
    res = Net::HTTP.post_form(uri,
                    'account' => SMS_PARAMS[:zenvia_username],
                    'code' => SMS_PARAMS[:zenvia_pass],
                    'dispatch' => SMS_PARAMS[:zenvia_dispatch],
                    'from' => SMS_PARAMS[:zenvia_from],
                    'to' => self.client.phone2sms,
                    'msg' => 'MFA Code: ' + self.access_token,
                    'id' => self.id
                     )                     
    self.save    
  end
  
  def send_smsglobal
    uri = URI(SMS_PARAMS[:smsglobal_url])
    params = {
                    'action' => SMS_PARAMS[:smsglobal_action],
                    'user' => SMS_PARAMS[:smsglobal_user],
                    'password' => SMS_PARAMS[:smsglobal_pass],
                    'from' => SMS_PARAMS[:smsglobal_from],
                    'to' => self.client.phone2sms,
                    'text' => 'MFA Code: ' + self.access_token
                   }
    uri.query = URI.encode_www_form(params)
    
    res = Net::HTTP.get_response(uri)                  
    self.save
  end
  
end
