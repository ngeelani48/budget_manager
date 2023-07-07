require 'rails_helper'

RSpec.describe 'User view', type: :feature do
  let(:user) { User.create(fullname: 'John Doe', email: 'john.doe@example.com', password: 'password') }
  let!(:group1) { Group.create(name: 'Group 1', user:) }
  let!(:group2) { Group.create(name: 'Group 2', user:) }
  let!(:transaction1) { Transaction.create(name: 'Transaction 1', amount: 10, author: user, group_id: group1.id) }
  let!(:transaction2) { Transaction.create(name: 'Transaction 2', amount: 20, author: user, group_id: group2.id) }

  before do
    login_as(user, scope: :user)
  end

  it 'displays the user groups' do
    visit groups_path
    expect(page).to have_content('Group 1')
    expect(page).to have_content('Group 2')
  end

  it 'displays the total amount for each group' do
    visit groups_path
    expect(page).to have_content('$10')
    expect(page).to have_content('$20')
  end

  it 'displays a message when there are no groups' do
    group1.transactions.destroy_all
    group2.transactions.destroy_all
    Group.destroy_all
    visit groups_path
    expect(page).to have_content('There is no category added!!!')
  end

  it 'allows deleting a group' do
    visit groups_path
    expect(page).to have_button('Delete', count: 2)
    click_button('Delete', match: :first)
    expect(page).to_not have_content('Group 1')
    expect(page).to have_content('Group 2')
  end

  it 'redirects to the new group page when clicking "Add a new category"' do
    visit groups_path
    click_link('Add a new category')
    expect(page).to have_current_path(new_group_path)
  end
end
