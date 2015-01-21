class AuthSms < Auth
  
  
  
  def generate_access_token
    self.access_token = rand.to_s[2..7]
    case SMS_PARAMS[:sender_to_use]
    when "mob21"
      send_mob21
    when "zenvia"
      send_zenvia
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
                    'to' => '55' + self.client.phone2sms,
                    'msg' => 'MFA Code: ' + self.access_token,
                    'id' => self.id
                     )                     
    self.save    
  end
  
end