class User < ActiveRecord::Base
  attr_accessor :new_password
  #attr_accessible :login

  after_create :create_password

  def authenticate?(pwd)
  	Digest::SHA1.hexdigest("#{pwd} #{salt}") == password
  end

  protected
  def create_password
    self.salt = Digest::SHA1.hexdigest("#{login}--#{Time.now}")
    self.remember_token = SecureRandom.base64
    self.password = Digest::SHA1.hexdigest("#{new_password} #{salt}")
    self.save
  end
end
