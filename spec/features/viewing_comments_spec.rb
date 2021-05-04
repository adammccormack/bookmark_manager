feature 'view comments' do
  scenario 'a user can add and then view a comment' do
    bookmark = Bookmark.create(url: "http://www.hippo.com", title: 'Hippo')

    visit '/bookmarks'
    first('.bookmark').click_button 'Add Comment'

    expect(current_path).to eq "/bookmarks/#{bookmark.id}/comments/new"

    fill_in 'comment', with: 'Dis be a comment yo'
    click_button 'Submit'

    expect(current_path).to eq '/bookmarks'
    expect(page).to have_content 'Dis be a comment yo'
  end
end
