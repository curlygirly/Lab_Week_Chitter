require 'bcrypt'

class User

  attr_reader :username, :name, :password
  attr_accessor :password_confirmation

  include DataMapper::Resource

  property :id, Serial
  property :name, String
  property :username, String
  property :email, String, unique: true, message: 'This email already exists'
  property :password, String, unique: true, message: 'Sorry, your passwords do not match'
  property :password_confirmation, String
  property :password_digest, Text

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end
  # validates_confirmation_of :password

  def self.authenticate(email, password)
    user = first(email: email)
    user if user && BCrypt::Password.new(user.password_digest) == password
  end


end