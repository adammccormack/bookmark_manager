feature 'Viewing bookmarks' do
  scenario 'shows bookmarks' do
    visit('/bookmarks')
    expect(page).to have_content ("https://www.google.com")
    expect(page).to have_content ("https://www.youtube.com/")
    expect(page).to have_content ("https://www.bbc.co.uk/")
  end
end
