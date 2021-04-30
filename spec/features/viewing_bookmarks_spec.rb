
feature 'Viewing bookmarks' do
  scenario 'A user can see bookmarks' do
    visit '/bookmarks/new'
    fill_in('url', with: 'https://www.google.com')
    fill_in('title', with: 'Google')
    click_button('Submit')
    visit('/bookmarks')
    expect(page).to have_link('Google', href: 'https://www.google.com')
  end
end
