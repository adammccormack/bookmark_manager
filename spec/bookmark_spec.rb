require 'bookmark'
require 'database_helpers'
require 'pg'

describe Bookmark do
    describe '.all' do
      it 'returns all bookmarks' do
        bookmark = Bookmark.create(url: 'https://www.google.com', title: 'Google')
        Bookmark.create(url: 'https://www.youtube.com/', title: 'Youtube')
        Bookmark.create(url: 'https://www.bbc.co.uk/', title: 'BBC')
        bookmarks = Bookmark.all

        expect(bookmarks.length).to eq 3
        expect(bookmarks.first).to be_a Bookmark
        expect(bookmarks.first.id).to eq bookmark.id
        expect(bookmarks.first.title).to eq 'Google'
        expect(bookmarks.first.url).to eq 'https://www.google.com'
      end
    end
    describe '.create' do
      it 'creates a new bookmark' do
        bookmark = Bookmark.create(url: 'http://www.testbookmark.com', title: 'Test Bookmark')
        persisted_data = persisted_data(id: bookmark.id) # blue id is pulling this #{id} from persisted_data
        expect(bookmark).to be_a Bookmark
        expect(bookmark.id).to eq persisted_data['id']
        expect(bookmark.title).to eq 'Test Bookmark'
        expect(bookmark.url).to eq 'http://www.testbookmark.com'
      end

      it 'does not create a new bookmark if the URL is not valid' do
        bookmark = Bookmark.create(url: 'not a bookmark', title: 'Nada')
        expect(Bookmark.all).to be_empty
      end
    end

    describe '.delete' do
      it 'deletes the given bookmark' do
        bookmark = Bookmark.create(title: 'Google.com', url: 'https://www.google.com')

        Bookmark.delete(id: bookmark.id) # delete the above bookmark specifically

        expect(Bookmark.all.length).to eq 0
    end
  end

  describe '.get' do
    it 'it returns the requested bookmark' do
      bookmark = Bookmark.create(url: 'http://www.youcantfindme.com', title: 'F ME')
      result = Bookmark.get(id: bookmark.id)
      expect(result.id).to eq bookmark.id
      expect(result.url).to eq 'http://www.youcantfindme.com'
      expect(result.title).to eq 'F ME'
    end
  end

  describe '.update' do
    it 'updates a bookmark' do
      bookmark = Bookmark.create(url: 'http://www.testbookmark.com', title: 'Test Bookmark')
      updated_bookmark = Bookmark.update(id: bookmark.id, url: 'http://mofo.com', title: 'MOFO')

      expect(updated_bookmark.id).to eq bookmark.id
      expect(updated_bookmark.url).to eq 'http://mofo.com'
      expect(updated_bookmark.title).to eq 'MOFO'
    end
  end

  describe '#comments' do
    it 'returns a list of comments on the bookmark' do
      bookmark = Bookmark.create(title: 'Makers Academy', url: 'http://www.makersacademy.com')
      DatabaseConnection.query("INSERT INTO comments (id, text, bookmark_id) VALUES(1, 'Test comment', #{bookmark.id})")

      comment = bookmark.comments.first

      expect(comment['text']).to eq 'Test comment'
    end
  end
end
