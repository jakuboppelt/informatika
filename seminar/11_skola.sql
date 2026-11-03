-- Školní databáze pro maturitní otázku 11: Databáze a základy SQL
-- Spusť celý skript najednou. Smaže staré tabulky a vytvoří je znovu s daty.
-- Kontrolu cizích klíčů má DB Browser for SQLite zapnutou sám,
-- v Pythonu ji zapni příkazem PRAGMA foreign_keys = ON.

DROP TABLE IF EXISTS znamky;
DROP TABLE IF EXISTS studenti;
DROP TABLE IF EXISTS predmety;
DROP TABLE IF EXISTS tridy;

CREATE TABLE tridy (
  id      INTEGER PRIMARY KEY,
  nazev   VARCHAR(10) NOT NULL UNIQUE,
  rocnik  INTEGER NOT NULL CHECK (rocnik BETWEEN 1 AND 4)
);

CREATE TABLE studenti (
  id        INTEGER PRIMARY KEY,
  jmeno     VARCHAR(40) NOT NULL,
  prijmeni  VARCHAR(40) NOT NULL,
  narozen   DATE,
  email     VARCHAR(80) UNIQUE,
  trida_id  INTEGER NOT NULL REFERENCES tridy(id)
);

CREATE TABLE predmety (
  id       INTEGER PRIMARY KEY,
  nazev    VARCHAR(40) NOT NULL,
  zkratka  VARCHAR(5) NOT NULL UNIQUE
);

CREATE TABLE znamky (
  id          INTEGER PRIMARY KEY,
  student_id  INTEGER NOT NULL REFERENCES studenti(id),
  predmet_id  INTEGER NOT NULL REFERENCES predmety(id),
  znamka      INTEGER NOT NULL CHECK (znamka BETWEEN 1 AND 5),
  vaha        INTEGER NOT NULL DEFAULT 1,
  datum       DATE NOT NULL
);

INSERT INTO tridy (id, nazev, rocnik) VALUES
  (1, '1.A', 1),
  (2, '2.A', 2),
  (3, '3.B', 3);

INSERT INTO studenti (id, jmeno, prijmeni, narozen, email, trida_id) VALUES
  (1,  'Adam',    'Novák',      '2010-03-14', 'adam.novak@skola.example',      1),
  (2,  'Eliška',  'Svobodová',  '2010-07-02', 'eliska.svobodova@skola.example', 1),
  (3,  'Tomáš',   'Dvořák',     '2009-11-23', NULL,                            1),
  (4,  'Klára',   'Černá',      '2010-01-30', 'klara.cerna@skola.example',     1),
  (5,  'Jakub',   'Procházka',  '2009-05-17', 'jakub.prochazka@skola.example', 2),
  (6,  'Natálie', 'Kučerová',   '2009-09-08', 'natalie.kucerova@skola.example', 2),
  (7,  'Matěj',   'Veselý',     '2008-12-01', NULL,                            2),
  (8,  'Tereza',  'Horáková',   '2009-02-19', 'tereza.horakova@skola.example', 2),
  (9,  'Ondřej',  'Marek',      '2008-04-11', 'ondrej.marek@skola.example',    3),
  (10, 'Barbora', 'Pokorná',    '2008-08-25', 'barbora.pokorna@skola.example', 3),
  (11, 'Vojtěch', 'Král',       '2007-10-05', 'vojtech.kral@skola.example',    3),
  (12, 'Anna',    'Němcová',    '2008-06-12', NULL,                            3);

INSERT INTO predmety (id, nazev, zkratka) VALUES
  (1, 'Matematika',  'M'),
  (2, 'Český jazyk', 'ČJ'),
  (3, 'Informatika', 'IVT'),
  (4, 'Fyzika',      'F');

INSERT INTO znamky (student_id, predmet_id, znamka, vaha, datum) VALUES
  (1, 1, 2, 2, '2026-09-18'), (1, 3, 1, 1, '2026-09-25'), (1, 2, 3, 1, '2026-10-02'),
  (2, 1, 1, 2, '2026-09-18'), (2, 3, 1, 1, '2026-09-25'), (2, 2, 1, 2, '2026-10-09'),
  (3, 1, 4, 2, '2026-09-18'), (3, 3, 2, 1, '2026-09-25'), (3, 4, 3, 1, '2026-10-06'),
  (4, 1, 3, 2, '2026-09-18'), (4, 2, 2, 1, '2026-10-02'),
  (5, 1, 2, 1, '2026-09-16'), (5, 3, 1, 2, '2026-10-01'), (5, 4, 2, 1, '2026-10-13'),
  (6, 1, 1, 1, '2026-09-16'), (6, 2, 2, 1, '2026-09-30'), (6, 4, 1, 1, '2026-10-13'),
  (7, 1, 5, 1, '2026-09-16'), (7, 3, 3, 2, '2026-10-01'), (7, 1, 3, 2, '2026-10-20'),
  (8, 2, 1, 2, '2026-09-30'), (8, 3, 2, 2, '2026-10-01'),
  (9, 1, 2, 2, '2026-09-22'), (9, 3, 1, 1, '2026-10-07'), (9, 4, 2, 1, '2026-10-14'),
  (10, 1, 1, 2, '2026-09-22'), (10, 2, 2, 1, '2026-10-05'), (10, 3, 1, 1, '2026-10-07'),
  (11, 1, 3, 2, '2026-09-22'), (11, 3, 1, 2, '2026-10-07'), (11, 4, 4, 1, '2026-10-14');
-- Anna Němcová (id 12) zatím nemá žádnou známku. Hodí se u LEFT JOIN.
