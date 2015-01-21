class Admin::ApplicationController < ApplicationController
  protect_from_forgery with: :exception  
  before_filter :authorize , :except => [ :login, :login_token] 
  
  
  private
  def authorize
    if current_client.nil?
      redirect_to admin_login_path
    elsif current_token.nil?
      redirect_to admin_login_token_path
    end
  end

  def current_token
    @current_token ||= Auth.find(session[:token_id]) if session[:token_id]
  end
  def current_client
    if current_token.nil?
      @current_client ||= Client.find(session[:client_id]) if session[:client_id]
    else
      @current_client ||= @current_token.client
    end
  end
  
  helper_method :current_token
  helper_method :current_client  
  
end