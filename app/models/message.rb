class Message < ActiveRecord::Base

  belongs_to :user

  validates_presence_of :message, :message => "Harus diisi"
  validates_length_of :message, :maximum => 60
  # validate :identical_with_previous, :message => "Message is identical to the previous one"


  # def identical_with_previous
  #   last_message = self.user.messages.last
  #   identical = last_message.present? ? self.message == last_message.message : false
  #   return !identical
  # end  
end
