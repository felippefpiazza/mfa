class Auth < ActiveRecord::Base
  belongs_to  :client
  belongs_to  :token
  before_create :put_expiration
  
  def auth(username,token)
    if Client.exists?(username: username) and c = Client.where(username: username).first
      if (a = Auth.where("client_id = ? AND access_token = ? AND expired = ? and expires_at > ?", c.id, token, 0, Time.now)).length == 1
        expire_old(c.id)
        a.first.expired = true
        a.first.save
        return a.first
      end
      expire_old(c.id)
    end
    return nil
  end
 
  def put_expiration
    self.expires_at = Time.now + 5.minutes
  end
 
  def expire_old(c_id)
    as = Auth.where("client_id = ? AND expired = ? and expires_at < ?", c_id,  0, Time.now)
    as.each do |a|
      a.expired = true
      a.save
    end    
  end
  
  def as_json()
        json_output = { :username => self.username,
                      :access_token => self.access_token,
                      :device => self.device
                       }
    end 

end
