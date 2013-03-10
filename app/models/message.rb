class Message < ActiveRecord::Base

  belongs_to :user

  validates_presence_of :message, :message => "Harus diisi"
  validates_length_of :message, :maximum => 60
end
