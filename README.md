# Herodotus

A lightweight Ruby ORM inspired by ActiveRecords from Ruby on Rails. Herodotus converts tables in Sqlite3 database into Herodotus::SQLObject class

Herodotus can perform core CRUD methods with associations.

## Demo
1. `$cd` into "demo folder"
2. Run demo by `$ruby demo.rb`


## Instructions
1. Create SQLite3 tables with SQL like so:

```sql
CREATE TABLE names (
  id INTEGER PRIMARY KEY,
  fname VARCHAR(255) NOT NULL,
  lname VARCHAR(255) NOT NULL,

  FOREIGN KEY(seat_id) REFERENCES name(id)
)
```
2. Create database with cat '{SQL_FILE_NAME}.sql' | sqlite3 '{DB_FILE_NAME}.db'
3. Open Sqlite3 database with: `sqlite3 tables.db`
4. Run DBConnection.open('{DB_FILE_NAME}.db')


## API
Querying is made easy with core features like:
* `::find`
* `::where`
* `#insert`
* `#update`
* `::all`
* `::table_name`
* `::columns`
* `::attributes`
* `::save`
* [x]`chain query commands without hitting database`

Herodotus offers ActiveRecord associations like features such as:
- [x] `::has_many`
- [x] `::belongs_to`
- [x] `::has_one_through`

## Library
* SQLite3
* ActiveSupport::Inflector
