CREATE DATABASE Guestmanagement;
USE Guestmanagement;

CREATE TABLE LoyaltyProgams(
 LoyaltyProgramID INT AUTO_INCREMENT PRIMARY KEY,
    ProgramName VARCHAR(50) UNIQUE NOT NULL,
    MinPointsRequired INT NOT NULL,
    DiscountRate DECIMAL(4,2) NOT NULL
);

CREATE TABLE Guests (
    GuestID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    DateOfBirth DATE,
    Email VARCHAR(100) UNIQUE,
    PhoneNumber VARCHAR(20),
    Address VARCHAR(255),
    City VARCHAR(50),
    PostalCode VARCHAR(10),
    Country VARCHAR(50),
    nationality VARCHAR(50),
    IDType VARCHAR(50),
    IDNumber VARCHAR(50) UNIQUE,
    EmergencyContactName VARCHAR(100),
    Emergency VARCHAR(20),
    LoyaltyProgramID INT, -- This is the Foreign Key (FK)
    IsVIP BOOLEAN DEFAULT FALSE,
    IsBlacklisted BOOLEAN DEFAULT FALSE,
    DateCreated DATETIME DEFAULT CURRENT_TIMESTAMP,
    LastUpdated DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (LoyaltyProgramID) REFERENCES LoyaltyPrograms(LoyaltyProgramID)
);



CREATE TABLE FeedbackEntries (
    FeedbackID INT AUTO_INCREMENT PRIMARY KEY,
    GuestID INT NOT NULL, -- This is the Foreign Key (FK)
    FeedbackDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    Type VARCHAR(50), -- like 'Comment', 'Complaint', 'Suggestion'
    Rating INT, -- like 1-5 stars
    Comments TEXT,
    FOREIGN KEY (GuestID) REFERENCES Guests(GuestID)
);

CREATE TABLE GuestPreferences (
    PreferenceID INT AUTO_INCREMENT PRIMARY KEY,
    GuestID INT NOT NULL, -- This is the Foreign Key (FK)
    PreferenceType VARCHAR(100) NOT NULL, -- 'Room Feature', 'Dietary'
    PreferenceValue VARCHAR(255) NOT NULL, -- like 'High Floor', 'Feather-free pillows'
    FOREIGN KEY (GuestID) REFERENCES Guests(GuestID)
);
INSERT INTO LoyaltyPrograms (ProgramName, MinPointsRequired, DiscountRate) VALUES
('Standard Guest', 0, 0.00),
('Silver Tier', 1000, 0.05),
('Gold Tier', 5000, 0.10),
('Platinum Elite', 10000, 0.15);

INSERT INTO Guests (FirstName, LastName, DateOfBirth, Email, PhoneNumber, Address, City, StateProvince, PostalCode, Country, Nationality, IDType, IDNumber, EmergencyContactName, EmergencyContactPhone, LoyaltyProgramID, IsVIP, IsBlacklisted) VALUES
('John', 'Doe', '1985-03-15', 'john.doe@example.com', '123-456-7890', '123 Main St', 'Anytown', 'Anystate', '12345', 'USA', 'American', 'Passport', 'ABC12345', 'Jane Doe', '098-765-4321', 3, TRUE, FALSE), -- Gold Tier (LoyaltyProgramID = 3)
('Alice', 'Smith', '1992-07-22', 'alice.smith@example.com', '987-654-3210', '456 Oak Ave', 'Othercity', 'Otherstate', '67890', 'Canada', 'Canadian', 'Driver''s License', 'DEF67890', NULL, NULL, 1, FALSE, FALSE), -- Standard Guest (LoyaltyProgramID = 1)
('Peter', 'Jones', '1978-11-01', 'peter.jones@example.com', '555-123-4567', '789 Pine Ln', 'Metropolis', 'Metstate', '54321', 'UK', 'British', 'Passport', 'GHI90123', 'Mary Jones', '555-987-6543', 2, FALSE, FALSE); -- Silver Tier (LoyaltyProgramID = 2)

INSERT INTO FeedbackEntries (GuestID, FeedbackDate, Type, Rating, Comments) VALUES
(1, '2023-10-28 10:30:00', 'Praise', 5, 'Excellent service and comfortable stay!'),
(2, '2023-10-29 14:00:00', 'Complaint', 3, 'Room was a bit noisy from the street.'),
(1, '2023-11-01 09:00:00', 'Suggestion', NULL, 'Consider adding more vegan options to the breakfast menu.');

INSERT INTO GuestPreferences (GuestIDs, PreferenceType, PreferenceValue) VALUES
(1, 'Room Feature', 'High Floor'),
(1, 'Dietary', 'Gluten-Free'),
(2, 'Room Feature', 'Quiet Side'),
(3, 'Amenity', 'Extra Towels');
