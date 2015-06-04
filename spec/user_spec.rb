describe User do

  it 'new user can be added, retrieved and deleted from database' do
    expect(User.count).to eq(0)
    User.create(name: 'Bob',
                username: 'bobby',
                email: 'bob@bob.com',
                password: 'bob',
                password_confirmation: 'bob')
    expect(User.count).to eq(1)
    user = User.first
    expect(user.name).to eq("Bob")
    expect(user.username).to eq("bobby")
    expect(user.email).to eq("bob@bob.com")
    user.destroy
    expect(User.count).to eq(0)
  end

end