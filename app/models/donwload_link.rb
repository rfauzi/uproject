class DownloadLink < ActiveRecord::Base
  
  validates :link_type, :inclusion => { :in => %w(ebook elearning)}
  validates_presence_of :label, :link, :link_type, :message => "Harus diisi"
  
end
