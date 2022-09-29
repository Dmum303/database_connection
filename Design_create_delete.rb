# {{Artists}} Model and Repository Classes Design Recipe

_Copy this recipe template to design and implement Model and Repository classes for a database table._

## 1. Design and create the Table

If the table is already created in the database, you can skip this step.

Otherwise, [follow this recipe to design and create the SQL schema for your table](./single_table_design_recipe_template.md).

*In this template, well use an example table `students`*

```
# EXAMPLE

Table: students

Columns:
id | name | cohort_name
```

## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
-- EXAMPLE
-- (file: spec/seeds_{table_name}.sql)

-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE students RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO students (name, cohort_name) VALUES ('David', 'April 2022');
INSERT INTO students (name, cohort_name) VALUES ('Anna', 'May 2022');
```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

to create database into psql CREATE DATABASE music_library_test;
then you can seed it with info, in order to do this you need to be in the directory containing seed file
psql -h 127.0.0.1 your_database_name < seeds_{table_name}.sql

```bash
psql -h 127.0.0.1 your_database_name < seeds_{table_name}.sql
psql -h 127.0.0.1 your_database_name < spec/seeds_artists.sql  --from different directory
```
The above code is going to create database and put seed info in
Usually for tests we would need a 2 databases, the real one and a test
so we do not knack the real one during testing

Test database worked in psql SELECT * FROM artists;

Need to change the DatabaseConnection.connect('databas_name') in app file to the test database ???? maybe not
actually needs to be in spec helper to change Need to change the DatabaseConnection.connect('databas_name')

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

ruby
# EXAMPLE
# Table name: students

# Model class
# (in lib/Artist.rb)
class Artist
end

# Repository class
# (in lib/Artist_repository.rb)
class ArtistRepository
end

class Album
end

class AlbumRepository
end


## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby```
# EXAMPLE
# Table name: students

# Model class
# (in lib/student.rb)

class Artist

  # Replace the attributes by your own columns.
  attr_accessor :id, :name, :genre
end

class Album
  attr_accessor :id, :title, :release_year, :artist_id
end


# The keyword attr_accessor is a special Ruby feature
# which allows us to set and get attributes on an object,
# here's an example:
#
# student = Student.new
# student.name = 'Jo'
# student.name
```

*You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.*

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# EXAMPLE
# Table name: students

# Repository class
# (in lib/Artist_repository.rb)

class ArtistRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, name, genre FROM artists;

    # Returns an array of Artist objects.
  end

  # Select a single record
  # Given the id in argument (a numnber)
  def find(id)
  # Executes the SQL query:
  # SELECT id, name, genre FROM artists WHERE id = $1;

  # Returns a single artist
  end

  # Insert a new artist record
  # Takes a Artist object in argument
  def create(artist)
    # Executes the SQL query:
    # INSERT INTO artists (name, genre) VALUES($1, $2);
    #new values for oject will go where placeholders are $1, $2

    # Doesn't need to return anything (only creates the record)
  end

  # Deletes an artist record
  # given its id
  def delete(artist)
    # Executs the SQL:
    # DELETE FROM artists WHERE id = $1;

    # returns nothing (only deletes the record)
  end

  #Updates an existing artist record
  # Takes an Artist object (with the updated fields)
  def update(artist)
    #Executes the SQL:
    # UPDATE artists SET name = $1, genre = $2 WHERE id = $3;

    # Returns nothing (only updates the record)
  end


end

class AlbumRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, title, release_year, artist_id FROM albums;

    # Returns an array of Albums objects.
  end

  # Select a single record
  # Given the id in argument (a numnber)
  def find(id)
  # Executes the SQL query:
  # SELECT id, title, release_year, artist_id WHERE id = $1;

  # Returns a single Album
  end

  # Insert a new Album record
  # Takes a Album object in argument
  def create(Album)
    # Executes the SQL query:
    # INSERT INTO albums (title, release_year, artist_id) VALUES($1, $2, $3);
    #new values for oject will go where placeholders are $1, $2, $3

    # Doesn't need to return anything (only creates the record)
  end

end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# EXAMPLES Artists

# 1
# Get all artists

repo = ArtistsRepository.new
# What behavoir we want to get
artists = repo.all # the array
artists.length #=> 2
artists.first.id # => '1'
artists.first.name # => 'Pixies'

# 2
# Get a single artist

repo = ArtistRepository.new

artist = repo.find(1)
artist.name # => 'Pixies'
artist.genre # => 'Rock'

# 3
# Get another single artist

repo = ArtistRepository.new

artist = repo.find(2)
artist.name # => 'ABBA'
artist.genre # => 'Pop'

#4
# create new artist
repo = ArtistRepository.new

artist.name = 'ABBA GABBA'
artist.genre = 'Gabber'

repo.create(artist) # => nil 

#check it worked

artists = repo.all

last_artist = artists.last
last_artist.name # => 'ABBA GABBE'
last_artist.genre # => ''Gabber'

# 5
# Delete method, doesn't matter what we delete as seed will reset every run
repo = ArtistRepository.new

id_to_delete = 1 
repo.delete(id_to_delete)

all_artists = repo.all
all_artists.length # => 1
all_artists.first.id # => 2

# 6
# Updates an existing record

repo = ArtistRepository.new

artist = repo.find(1) 
artist.name = 'Something else'
artist.genre = 'Disco'

repo.update(artist)

updated_artist = repo.find(1)

updated_artist.name # => 'Something else'
updated_artist.genre # => 'Disco'


# Examples albums 

repository = AlbumRepository.new

album = Album.new
album.title = 'Trompe le Monde'
album.release_year = 1991
album.artist_id = 1

repository.create(album)

all_albums = repository.all
all_albums.length => 3

# Try an edge case with id out of range

# The all_albums array should contain the new Album object
# students = repo.all

# students.length # =>  2

# students[0].id # =>  1
# students[0].name # =>  'David'
# students[0].cohort_name # =>  'April 2022'

# students[1].id # =>  2
# students[1].name # =>  'Anna'
# students[1].cohort_name # =>  'May 2022'

# 2
# Get a single student

# repo = StudentRepository.new

# student = repo.find(1)

# student.id # =>  1
# student.name # =>  'David'
# student.cohort_name # =>  'April 2022'

# Add more examples for each method
```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/student_repository_spec.rb

def reset_students_table
  seed_sql = File.read('spec/seeds_students.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'students' })
  connection.exec(seed_sql)
end

describe StudentRepository do
  before(:each) do 
    reset_students_table
  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._

