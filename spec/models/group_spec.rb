require 'rails_helper'

RSpec.describe Group, type: :model do
  let(:user) { User.create(fullname: 'John Doe', email: 'john.doe@example.com', password: 'password') }
  subject { described_class.new(name: 'Test Group', user:) }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without a name' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without a user' do
    subject.user = nil
    expect(subject).to_not be_valid
  end

  it 'returns the correct total amount' do
    group = Group.create(name: 'Test Group', user:)
    group.transactions.create(name: 'Transaction 1', amount: 10, author: user)
    group.transactions.create(name: 'Transaction 2', amount: 20, author: user)

    expect(group.total_amount).to eq(30)
  end
end
