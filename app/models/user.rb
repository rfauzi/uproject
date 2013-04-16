class User < ActiveRecord::Base
  
  has_one   :survei
  has_one   :profile
  has_many  :messages
    
  validates_presence_of :email, :username, :uid

  def self.register_facebook(params)
    @user= User.new(username: params[:username], email: params[:email], uid: params[:uid], descriptions: params[:bio])
    return @user.save
  end

  def is_admin?
    (settings.super_admin_uid + settings.admin_uids).include?(self.uid)
  end

  def exchange_facebook_access_token
    path = "https://graph.facebook.com/oauth/access_token?client_id=#{Setting.facebook.id}&client_secret=#{Setting.facebook.secret}&grant_type=fb_exchange_token&fb_exchange_token=#{access_token}"
    response = RestClient.get(path) {|resp, request, result, &block| resp}
    new_access_token = response.body.split("=")[1]
    new_access_token = new_access_token.include?("expires")?  new_access_token.gsub("&expires", "") : new_access_token if new_access_token.present?
  end
  
end