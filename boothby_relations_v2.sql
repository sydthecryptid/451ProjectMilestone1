-- Corrected from v1 to match er v2

--to reset db
DROP TABLE IF EXISTS Business_Category;
DROP TABLE IF EXISTS Review;
DROP TABLE IF EXISTS CheckIn;
DROP TABLE IF EXISTS Business;
DROP TABLE IF EXISTS Category;
DROP TABLE IF EXISTS "user";
DROP TABLE IF EXISTS Address;
DROP TABLE IF EXISTS Zipcode;


CREATE TABLE Zipcode (
    zipcode VARCHAR(5) PRIMARY KEY,
    population INT NOT NULL,
    averageIncome NUMERIC(10,2) NOT NULL
);

create table Address(
    addressID SERIAL PRIMARY KEY, --creates a unique id to use as primary key
    street VARCHAR(255) NOT NULL,
    city VARCHAR(50) NOT NULL,
    state VARCHAR(2) NOT NULL -- US state abbrev. 
    zipcode VARCHAR(5) NOT NULL,
    FOREIGN KEY (zipcode) REFERENCES Zipcode(zipcode)
);

create table Business (
    businessID INT PRIMARY KEY,
    name varchar(255) NOT NULL,
    stars NUMERIC(2,1) NOT NULL,
    reviewCount INT DEFAULT 0,
    totalCheckins INT DEFAULT 0, --calculated from each checkin
    averageReviewRating NUMERIC(3,2), --calculated from each review
    addressID INT NOT NULL, --derived from address

    FOREIGN KEY (addressID) REFERENCES Address(addressID)
); 

create table "user" ( --not on er diagram, but needed for reviews
    userID INT PRIMARY KEY,
    reviewCount INT DEFAULT 0
);

create table Review (
    reviewID INT PRIMARY KEY,
    userID INT NOT NULL,
    stars NUMERIC(2,1) NOT NULL,
    businessID INT NOT NULL,

    FOREIGN KEY (businessID) REFERENCES Business(businessID),
    FOREIGN KEY (userID) REFERENCES "user"(userID)
);


create table Category(
    categoryTitle VARCHAR(255) PRIMARY KEY
);

create table Business_Category (
    businessID INT NOT NULL,
    categoryTitle VARCHAR(255) NOT NULL,
    PRIMARY KEY (businessID, categoryTitle),
    FOREIGN KEY (businessID) REFERENCES Business(businessID),
    FOREIGN KEY (categoryTitle) REFERENCES Category(categoryTitle)
);

CREATE TABLE CheckIn (
    businessID VARCHAR(22) NOT NULL,
    day VARCHAR(9) NOT NULL,  
    time VARCHAR(5) NOT NULL, 
    frequency INT NOT NULL,
    PRIMARY KEY (businessID, day, time), --weak entity so use composite for primary key
    FOREIGN KEY (businessID) REFERENCES Business(businessID)
);
