class Admin::ClientController < Admin::ApplicationController
  before_filter :authorize , :except => [ :new, :save, :show, :index ] 


  def new
    @resource = Client.new()
    @client_token = ROTP::Base32.random_base32
    totp = ROTP::TOTP.new(@client_token)
    @qr = RQRCode::QRCode.new(totp.provisioning_uri("MFA"), :size => 10).to_img.resize(200, 200).to_data_url    
    render "show"
  end
  
  def save
    if params[:form][:id] != nil
      
      @resource = Client.where(id: params[:form][:id]).first
      if @resource.update(form_params)
        redirect_to :action => "index", :id => @resource.id, notice: "O registro foi criado com sucesso"
      else
        redirect_to :action => "index", :id => @resource.id, notice: "Falha ao tentar salvar o registro"
      end
      
    else
      
      if @resource = Client.create(form_params)
        @resource.token.create(token_key: params[:form][:token], active: 1)
        redirect_to :action => "index", :id => @resource.id, notice: "O registro foi criado com sucesso"
      else
        flash.now.alert = "Ocorreu um erro ao criar o registro, por favor tente novamente."
        render "new"  
      end
      
    end
  end

  def show
    @resource = Client.where(id: params[:id]).first
    totp = ROTP::TOTP.new(@resource.token.first.token_key)
    @qr = RQRCode::QRCode.new(totp.provisioning_uri("MFA"), :size => 10).to_img.resize(200, 200).to_data_url

  end
  
  def index
    if params[:busca] != nil
      @resources = Client.where("username like :v or name like :v or email like :v or phone2sms like :v" , v: "%" + params[:busca] + "%")
    else
      @resources = {}
    end
  end
  
  private
  def form_params
    params.require(:form).permit(:username, :name, :email, :password, :phone2sms)
  end

end
