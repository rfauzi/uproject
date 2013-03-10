class User < ActiveRecord::Base
  
  has_one   :survei
  has_one   :profile
  has_many  :messages
  
  def self.register_facebook(params)
    @user= User.new(username: params[:username], email: params[:email], uid: params[:uid], descriptions: params[:bio])
    return @user.save
  end
end