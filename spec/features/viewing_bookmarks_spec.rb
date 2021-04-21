require 'pg'

feature 'Viewing bookmarks' do
  scenario 'A user can see bookmarks' do
    connection = PG.connect(dbname: 'bookmark_manager_test')

    # Add the test data
    connection.exec("INSERT INTO bookmarks (url) VALUES ('https://www.google.com');")
    connection.exec("INSERT INTO bookmarks (url) VALUES('https://www.youtube.com/');")
    connection.exec("INSERT INTO bookmarks (url) VALUES('https://www.bbc.co.uk/');")

    visit('/bookmarks')

    expect(page).to have_content 'https://www.google.com'
    expect(page).to have_content 'https://www.youtube.com/'
    expect(page).to have_content 'https://www.bbc.co.uk/'
  end
end
