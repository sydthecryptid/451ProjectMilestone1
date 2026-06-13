--For part 3 of Milestone 1, references "milestone1DB.csv"

create table Business(
    name VARCHAR(255) PRIMARY KEY,
    state VARCHAR(10) NOT NULL, --no fields can be null, states are always 2 letter abbrev. 
    city VARCHAR(50) NOT NULL
);