class AuthToken < Auth
  
  def auth(username,token)
    if (c = Client.where(username: username)).length == 1
      c.first.token.each do |t|
        totp = ROTP::TOTP.new(t.token_key)
        if totp.verify(token)
          self.token_id = t.id
          self.client = c.first
          self.access_token = totp.now
          self.expired = true
          self.save  
          return self
        end
        expire_old(c.first.id)
      end
    end
      return nil
  end

  def put_expiration
    self.expires_at = Time.now
  end

  
end
