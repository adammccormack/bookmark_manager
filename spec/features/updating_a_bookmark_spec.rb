feature 'Updating a bookmark' do
  scenario 'A user can update a bookmark from Bookmark Manager' do
    bookmark = Bookmark.create(url: 'http://testbookmark.com', title: 'Test Bookmark')
    visit('/bookmarks')
    click_button('Update')
    expect(current_path).to eq "/bookmarks/#{bookmark.id}/edit"

    fill_in('url', with: 'http://anotherone.com')
    fill_in('title', with: 'Another One')
    click_button('Update')

    expect(page).not_to have_link('Test Bookmark')
    expect(page).to have_link('Another One', href: 'http://anotherone.com')
  end
end
