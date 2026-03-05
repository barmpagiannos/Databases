DROP SCHEMA IF EXISTS CityOpsDB;
CREATE SCHEMA CityOpsDB;
USE CityOpsDB;

-- Αυτός ο κώδικας δημιουργεί τους πίνακες, άδειους.

CREATE TABLE Citizen (
    UserID VARCHAR(10) NOT NULL,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(50) NOT NULL,
    Phone VARCHAR(15),
    Password VARCHAR(50) NOT NULL,
    PRIMARY KEY (UserID)
);

CREATE TABLE Department (
    DepartmentID VARCHAR(10) NOT NULL,
    DeptName VARCHAR(50) NOT NULL,
    Phone VARCHAR(15),
    PRIMARY KEY (DepartmentID)
);

CREATE TABLE District (
    DistrictID VARCHAR(10) NOT NULL,
    DistrictName VARCHAR(50) NOT NULL,
    ZipCode INT NOT NULL,
    PRIMARY KEY (DistrictID)
);

CREATE TABLE IncidentType (
    TypeID VARCHAR(10) NOT NULL,
    TypeName VARCHAR(50) NOT NULL,
    Importance ENUM('ΧΑΜΗΛΗ', 'ΜΕΤΡΙΑ', 'ΥΨΗΛΗ') NOT NULL,
    PRIMARY KEY (TypeID)
);

CREATE TABLE ActionType (
    ActionTypeID VARCHAR(10) NOT NULL,
    ActionName VARCHAR(50) NOT NULL,
    Description VARCHAR(200),
    PRIMARY KEY (ActionTypeID)
);

CREATE TABLE Employee (
    EmployeeID VARCHAR(10) NOT NULL,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(50) NOT NULL,
    Phone VARCHAR(15),
    DepartmentID VARCHAR(10) NOT NULL,
    Role VARCHAR(50) NOT NULL, -- Το Role έγινε πεδίο κειμένου.
    PRIMARY KEY (EmployeeID),
    FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Incident (
    IncidentID VARCHAR(10) NOT NULL,
    Description VARCHAR(500),
    SubmissionDate DATETIME NOT NULL,
    Street VARCHAR(50),
    StreetNumber INT,
    Latitude DECIMAL(9,6),
    Longitude DECIMAL(9,6),
    UserID VARCHAR(10) NOT NULL,
    TypeID VARCHAR(10) NOT NULL,
    DistrictID VARCHAR(10) NOT NULL,
    PRIMARY KEY (IncidentID),
    FOREIGN KEY (UserID) REFERENCES Citizen(UserID)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (TypeID) REFERENCES IncidentType(TypeID)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (DistrictID) REFERENCES District(DistrictID)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Assignment (
    AssignmentID VARCHAR(10) NOT NULL,
    IncidentID VARCHAR(10) NOT NULL,
    EmployeeID VARCHAR(10) NOT NULL,
    AssignmentDate DATETIME NOT NULL,
    Comments VARCHAR(500),
    Priority INT, -- Ή ENUM αν το προτιμάς
    PRIMARY KEY (AssignmentID),
    FOREIGN KEY (IncidentID) REFERENCES Incident(IncidentID)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE StatusHistory (
    IncidentID VARCHAR(10) NOT NULL,
    HistoryID VARCHAR(10) NOT NULL,
    ChangeDate DATETIME NOT NULL,
    Status ENUM('NEO', 'ΣΕ_ΑΝΑΘΕΣΗ', 'ΣΕ_ΕΞΕΛΙΞΗ', 'ΟΛΟΚΛΗΡΩΘΗΚΕ', 'ΑΚΥΡΩΘΗΚΕ') NOT NULL,
    Comments VARCHAR(500),
    PRIMARY KEY (IncidentID, HistoryID), -- Σύνθετο Κλειδί.
    FOREIGN KEY (IncidentID) REFERENCES Incident(IncidentID)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Photo (
    IncidentID VARCHAR(10) NOT NULL,
    PhotoID VARCHAR(10) NOT NULL,
    URL VARCHAR(255) NOT NULL,
    UploadDate DATETIME NOT NULL,
    PRIMARY KEY (IncidentID, PhotoID), -- Σύνθετο Κλειδί.
    FOREIGN KEY (IncidentID) REFERENCES Incident(IncidentID)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Action (
    ActionID VARCHAR(10) NOT NULL,
    ActionDate DATETIME NOT NULL,
    Cost DECIMAL(10,2) DEFAULT 0.00,
    Comments VARCHAR(500),
    IncidentID VARCHAR(10) NOT NULL,
    EmployeeID VARCHAR(10) NOT NULL,
    ActionTypeID VARCHAR(10) NOT NULL,
    PRIMARY KEY (ActionID),
    FOREIGN KEY (IncidentID) REFERENCES Incident(IncidentID)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (ActionTypeID) REFERENCES ActionType(ActionTypeID)
        ON DELETE CASCADE ON UPDATE CASCADE
);
