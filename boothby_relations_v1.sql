-- For part 2 of Milestone 1, translate ER model into SQL DDL statements

--to reset db
DROP TABLE IF EXISTS Business_Category;
DROP TABLE IF EXISTS Review;
DROP TABLE IF EXISTS Business;
DROP TABLE IF EXISTS Category;
DROP TABLE IF EXISTS "user";
DROP TABLE IF EXISTS Address;


create table Address(
    addressID SERIAL PRIMARY KEY, --creates a unique id to use as primary key
    street VARCHAR(255) NOT NULL,
    zipcode VARCHAR(5) NOT NULL,
    city VARCHAR(50) NOT NULL,
    state VARCHAR(2) NOT NULL -- US state abbrev. 
);


create table Business (
    businessID INT PRIMARY KEY,
    name varchar(255) not null,
    stars NUMERIC(2,1) NOT NULL,
    totalCheckins INT,
    reviewCount INT DEFAULT 0,
    averageReviewRating NUMERIC(2,1), --calculated from each review

    --components inherited from Address 
    addressID INT NOT NULL,

    FOREIGN KEY (addressID) REFERENCES Address(addressID)
); 

create table "user" (
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
