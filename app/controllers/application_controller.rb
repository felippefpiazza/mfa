class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :exception
  
  private
  
  def send_sms_token(username)
    if Client.exists?(username: username) and c = Client.where(username: username).first
      a = AuthSms.new(client: c)
      a.save
      a.generate_access_token
      return a.expires_at
    end
    return false
  end

  def send_response(response)
    respond_to do |format|
      format.json { render json: response }
      format.xml { render xml: response }
    end
  end

  def return_obj(obj_name,id,kind)
    obj = obj_name.downcase.singularize.capitalize.constantize
    if obj.exists?(:id => id)
      send_response(obj.where(:id => id).first.as_json(kind))
    else
      response = {:error => {:response => true, :error_msgs => ["Object not found"]} }
      send_response(response)
    end
  end


end
