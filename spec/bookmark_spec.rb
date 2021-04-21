require 'bookmark'

describe Bookmark do
  describe '.all' do
    it 'returns all bookmarks' do
      connection = PG.connect(dbname: 'bookmark_manager_test')

      connection.exec("INSERT INTO bookmarks (url) VALUES ('https://www.google.com');")
      connection.exec("INSERT INTO bookmarks (url) VALUES('https://www.youtube.com/');")
      connection.exec("INSERT INTO bookmarks (url) VALUES('https://www.bbc.co.uk/');")
      bookmarks = Bookmark.all
      expect(bookmarks).to include("https://www.google.com")
      expect(bookmarks).to include("https://www.youtube.com/")
      expect(bookmarks).to include("https://www.bbc.co.uk/")
    end
  end
  describe '.create' do
    it 'creates a new bookmark' do
      Bookmark.create(url: 'http://www.testbookmark.com')

      expect(Bookmark.all).to include 'http://www.testbookmark.com'
    end
  end
end
