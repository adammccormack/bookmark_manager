require 'bookmark'
require 'database_helpers'

describe Bookmark do
    describe '.all' do
      it 'returns all bookmarks' do
        connection = PG.connect(dbname: 'bookmark_manager_test')

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
        p persisted_data = persisted_data(id: bookmark.id) # blue id is pulling this #{id} from persisted_data
        expect(bookmark).to be_a Bookmark
        expect(bookmark.id).to eq persisted_data['id']
        expect(bookmark.title).to eq 'Test Bookmark'
        expect(bookmark.url).to eq 'http://www.testbookmark.com'
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
    it 'finds a bookmark' do
      bookmark = Bookmark.create(url: 'http://www.testbookmark.com', title: 'Test Bookmark')
      persisted_data = persisted_data(id: bookmark.id)
      expect(Bookmark.get(id: persisted_data['id']).url).to eq 'http://www.testbookmark.com'
      expect(Bookmark.get(id: persisted_data['id']).title).to eq 'Test Bookmark'
    end
  end

  describe '.update' do
    it 'updates a bookmark' do
      bookmark = Bookmark.create(url: 'http://www.testbookmark.com', title: 'Test Bookmark')
      persisted_data = persisted_data(id: bookmark.id)
      test = Bookmark.get(id: persisted_data['id'])
      Bookmark.update(id: test.id, title: 'test title', url: 'www.testtitle.com')
      expect(Bookmark.get(id: persisted_data['id']).url).to eq 'www.testtitle.com'
      expect(Bookmark.get(id: persisted_data['id']).title).to eq 'test title'
    end
  end
end
