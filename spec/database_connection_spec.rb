require 'database_connection'

describe '.query' do
  it 'executes a query via PG' do
    connection = DatabaseConnection.setup('bookmark_manager_test')

    expect(connection).to receive(:exec).with("SELECT * FROM bookmarks;")

    DatabaseConnection.query("SELECT * FROM bookmarks;")
  end

  it 'this connection is persistent' do
    # Grab the connection as a return value from the .setup method
    connection = DatabaseConnection.setup('bookmark_manager_test')

    expect(DatabaseConnection.connection).to eq connection
  end
end
