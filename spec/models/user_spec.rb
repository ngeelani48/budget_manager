require 'rails_helper'

RSpec.describe User, type: :model do
  subject { described_class.new(fullname: 'John Doe', email: 'john.doe@example.com', password: 'password') }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without a fullname' do
    subject.fullname = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without an email' do
    subject.email = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid with a duplicate email' do
    User.create(fullname: 'Jane Doe', email: 'john.doe@example.com', password: 'password')
    expect(subject).to_not be_valid
  end

  it 'is valid with a unique email' do
    User.create(fullname: 'Jane Doe', email: 'jane.doe@example.com', password: 'password')
    expect(subject).to be_valid
  end
end
