require 'rails_helper'

RSpec.describe Transaction, type: :model do
  let(:user) { User.create(fullname: 'John Doe', email: 'john.doe@example.com', password: 'password') }
  let(:group) { Group.create(name: 'Test Group', user:) }

  subject { described_class.new(name: 'Test Transaction', amount: 10, author: user) }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without a name' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without an amount' do
    subject.amount = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid with a negative amount' do
    subject.amount = -10
    expect(subject).to_not be_valid
  end

  it 'is valid with zero amount' do
    subject.amount = 0
    expect(subject).to be_valid
  end

  it 'belongs to an author' do
    expect(subject.author).to eq(user)
  end

  it 'can belong to multiple groups' do
    subject.groups << group
    expect(subject.groups).to include(group)
  end
end
