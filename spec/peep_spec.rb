require './app/server'

describe Peep do

  before(:each) do
    @user = User.create(name: "Bob",
                        username: 'bobby',
                        email: 'bob@bob.com',
                        password: 'bob',
                        password_confirmation: 'bob')
  end

  it 'can be added to database, retrieved and destoyed' do
    expect(Peep.count).to eq(0)
    Peep.create(name: @user.name, message: "Hello peeps")
    expect(Peep.count).to eq(1)
    peep = Peep.first
    expect(peep.message).to eq("Hello peeps")
    peep.destroy
    expect(Peep.count).to eq(0)
  end

end