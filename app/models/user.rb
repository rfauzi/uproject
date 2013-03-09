class User < ActiveRecord::Base

  def self.register_facebook(params)
    @user= User.new(username: params[:username], email: params[:email], uid: params[:uid], descriptions: params[:bio])
    return @user.save
  end
end