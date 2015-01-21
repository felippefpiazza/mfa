class Admin::UserController < Admin::ApplicationController
  #before_filter :restrict_access , :except => [ :index, :login, :login_token]  

  def qr
    totp = ROTP::TOTP.new(current_client.token.first.token_key)
    #binding.pry
    #@qr = RQRCode::QRCode.new("QR DE TESTE").to_img.resize(200, 200).to_data_url
    @qr = RQRCode::QRCode.new(totp.provisioning_uri("MFA"), :size => 10).to_img.resize(200, 200).to_data_url
  end
  def index
    @alert = params[:alert]
    @client = current_client
  end
  
  def login
    @alert = nil
    session[:client_id] = nil
    session[:token_id] = nil    
    if params[:username] != nil and params[:password] != nil and params[:mfa_type] != nil
      if (c = Client.authenticate(params[:username], params[:password])) != nil       
        session[:client_id] = c.id

        if params[:mfa_type] == "sms"
          resp = send_sms_token(c.username)
        end

        redirect_to admin_login_token_path(mfa_type: params[:mfa_type])
      else
        @alert = "Bad Username or Password"
      end
    end
    
  end
  
  def login_token
    @alert = nil
    @mfa_type = params[:mfa_type]
    if current_client != nil and params[:token] != nil 
      mfa_type = @mfa_type.downcase
      auth_r = "Auth".concat(mfa_type.capitalize).constantize.new
      if (a = auth_r.auth(current_client.username,params[:token])) != nil
              binding.pry
        session[:token_id] = a.id
        redirect_to admin_path(alert: "You are In!")
      else
              binding.pry
        @alert = "Bad Token"
      end
    end
      
  end
    
  
  def home
  end
  
end
