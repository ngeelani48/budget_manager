require 'rails_helper'

RSpec.describe 'groups/show', type: :view do
  let(:group) do
    Group.create(name: 'Group 1',
                 image: fixture_file_upload(
                   Rails.root.join('app', 'assets', 'images', 'placeholder-image.png'), 'image/png'
                 ))
  end

  before do
    assign(:group, group)
    assign(:transactions, group.transactions) # Assign the transactions associated with the group

    allow_any_instance_of(ActiveStorage::Service::DiskService).to receive(:url).and_return('')
    ActiveStorage::Current.url_options = { host: 'example.com' }

    render
  end

  it 'displays the total amount' do
    expect(rendered).to have_content(group.total_amount)
  end

  it 'displays the group image' do
    expect(rendered).to have_css("img[src*='#{group.image.url}']")
  end

  it 'displays the group name' do
    expect(rendered).to have_content(group.name)
  end

  it 'renders the transactions index partial' do
    expect(view).to render_template(partial: 'transactions/_index')
  end

  it 'displays the "Add new transaction" link' do
    expect(rendered).to have_link('Add new transaction', href: new_transaction_path)
  end
end
