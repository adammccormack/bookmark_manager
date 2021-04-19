class Bookmark
  def self.all
    @bookmarks = ["https://www.google.com",
                  "https://www.youtube.com/",
                  "https://www.bbc.co.uk/"].join(" , ")
  end
end
