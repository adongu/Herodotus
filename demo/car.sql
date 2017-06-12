CREATE TABLE owners (
  id INTEGER PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
);

CREATE TABLE cars (
  id INTEGER PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  brand VARCHAR(255) NOT NULL,
  year INTEGER NOT NULL,
  owner_id INTEGER NOT NULL UNIQUE,
  FOREIGN KEY(owner_id) REFERENCES owners(id)
);

CREATE TABLE repairs (
  id INTEGER PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  car_id INTEGER NOT NULL UNIQUE,
  FOREIGN_KEY car_id REFERENCES cars(id)
);

INSERT INTO
  owners (id, name)
VALUES
  (1, "Walter White"),
  (2, "Jessi Pinkman"),
  (3, "Saul Goodman"),
  (4, "Skyler White"),
  (5, "Gus Fring"),
  (6, "Hank Schrader"),
  (7, "Walter White Jr."),
  (8, "Tuco Salamanca"),
  (9, "Marie Schrader")

  INSERT INTO
    cars (id, name, brand, year, owner_id)
  VALUES
    (1, "Aztec", "Pontiac", 2005, 1),
    (2, "Monte Carlo", "Chevrolet", 2006, 2),
    (3, "Bounder", "Fleetwood", 2007, 1),
    (4, "Grand Wagoneer", "Jeep", 2008, 4),
    (5, "V70", "Volvo", 2005, 5),
    (6, "Commander", "Jeep", 2007, 6),
    (7, "Beetle", "Volkswagen", 2009, 9),
    (8, "DeVille", "Cadillac", 1999, 3)


  INSERT INTO
    repairs (id, name, car_id)
  VALUES
    (1, Broken Windshield, 1),
    (2, Broken Bumpers, 1),
    (3, Dead Battery, 3)
