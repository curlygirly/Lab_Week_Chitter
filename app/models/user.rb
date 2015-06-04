class User

  attr_reader :username, :name

  include DataMapper::Resource

  property :id, Serial
  property :name, String
  property :username, String
  property :email, String
  property :password, String
  property :password_confirmation, String

end