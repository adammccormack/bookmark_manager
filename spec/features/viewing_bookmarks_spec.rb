require 'pg'

feature 'Viewing bookmarks' do
  scenario 'A user can see bookmarks' do
    Bookmark.create(url: 'https://www.google.com', title: 'Google')
    Bookmark.create(url: 'https://www.youtube.com/', title: 'Youtube')
    Bookmark.create(url: 'https://www.bbc.co.uk/', title: 'BBC')

    visit('/bookmarks')

    expect(page).to have_link('Google', href: 'https://www.google.com')
    expect(page).to have_link('Youtube', href: 'https://www.youtube.com/')
    expect(page).to have_link('BBC', href: 'https://www.bbc.co.uk/')
  end
end
