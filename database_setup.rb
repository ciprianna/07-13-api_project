# Creates the database connection
DATABASE = SQLite3::Database.new("class_assignments.db")

# Creates the table
DATABASE.execute("CREATE TABLE IF NOT EXISTS assignments (id INTEGER PRIMARY KEY, name TEXT NOT NULL, description TEXT NOT NULL, where_stored TEXT NOT NULL);")
DATABASE.execute("CREATE TABLE IF NOT EXISTS links (id INTEGER PRIMARY KEY, name TEXT NOT NULL, assignment_id INTEGER NOT NULL, description TEXT NOT NULL, where_stored TEXT NOT NULL);")
DATABASE.execute("CREATE TABLE IF NOT EXISTS collaborators (id INTEGER PRIMARY KEY, assignment_id INTEGER NOT NULL, user_id INTEGER NOT NULL);")
DATABASE.execute("CREATE TABLE IF NOT EXISTS users (id INTEGER PRIMARY KEY, name TEXT NOT NULL);")

# Returns the results as a Hash
DATABASE.results_as_hash = true
