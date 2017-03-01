#Herodotus

A lightweight Ruby ORM inspired by ActiveRecords from Ruby on Rails. Herodotus converts tables in Sqlite3 dtatbase into Herodotus::SQLObject class

Herodotus can perform core CRUD methods with associations.


##Demo
1. Create SQLite3 tables with SQL like so:
```sql
CREATE TABLE names (
  id INTEGER PRIMARY KEY,
  fname VARCHAR(255) NOT NULL,
  lname VARCHAR(255) NOT NULL,

  FOREIGN KEY(seat_id) REFERENCES name(id)
)
```
2. Create database with `sqlite3 tables.db < script_name.sql`
3. Open Sqlite3 data base with: `sqlite3 tables.db`

##API
Querying is made easy with core features like:
* `::where`
  ```ruby
  def where(params)
    where_line = params.map { |key, _| "#{key.to_sym} = ?" }.join(" AND ")
    paramsValues = params.values
    query = DBConnection.execute(<<-SQL, *paramsValues)
      SELECT
        *
      FROM
        #{table_name}
      WHERE
        #{where_line}
    SQL
    parse_all(query)
    ```
* `#find`
* `::insert`
* `::update`
* `::all`
* `::table_name`
* `::columns`
* `::attributes`
* `::save`
* [ ] `chain query commands without hitting database`

Herodotus offers ActiveRecord associations like features such as:
- [x] `::has_many`
- [ ] `::belongs_to`
- [ ] `::has_one_through`

##Library
* SQLite3
* ActiveSupport::Inflector
