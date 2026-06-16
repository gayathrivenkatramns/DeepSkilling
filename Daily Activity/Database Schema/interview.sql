create DATABASE interview;
USE interview;

CREATE TABLE Candidates (
    CandidateID INT PRIMARY KEY,
    CandidateName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    Phone VARCHAR(15),
    Qualification VARCHAR(50),
    ExperienceYears INT
);

-- 2. Jobs
CREATE TABLE Jobs (
    JobID INT PRIMARY KEY,
    JobTitle VARCHAR(100) NOT NULL,
    Department VARCHAR(50),
    Location VARCHAR(50),
    Salary DECIMAL(10,2)
);

-- 3. Applications
CREATE TABLE Applications (
    ApplicationID INT PRIMARY KEY,
    CandidateID INT,
    JobID INT,
    ApplicationDate DATE,
    Status VARCHAR(30),

    FOREIGN KEY (CandidateID)
        REFERENCES Candidates(CandidateID),

    FOREIGN KEY (JobID)
        REFERENCES Jobs(JobID)
);

-- 4. Interview Rounds
CREATE TABLE Interviews (
    InterviewID INT PRIMARY KEY,
    ApplicationID INT,
    RoundNo INT,
    RoundName VARCHAR(50),
    InterviewDate DATE,
    Result VARCHAR(20),

    FOREIGN KEY (ApplicationID)
        REFERENCES Applications(ApplicationID)
);

-- 5. Offer Details
CREATE TABLE Offers (
    OfferID INT PRIMARY KEY,
    ApplicationID INT,
    OfferDate DATE,
    OfferedSalary DECIMAL(10,2),
    OfferStatus VARCHAR(20),

    FOREIGN KEY (ApplicationID)
        REFERENCES Applications(ApplicationID)
);

INSERT INTO Candidates VALUES
(1,'Gayathri','gayathri@gmail.com','9876543210','B.Tech',0),
(2,'Rahul','rahul@gmail.com','9876543211','MCA',2),
(3,'Priya','priya@gmail.com','9876543212','B.E',1),
(4,'Arun','arun@gmail.com','9876543213','B.Tech',3);

-- Jobs
INSERT INTO Jobs VALUES
(101,'Software Developer','IT','Chennai',600000),
(102,'Data Analyst','Analytics','Bangalore',700000);

-- Applications
INSERT INTO Applications VALUES
(1001,1,101,'2026-06-01','In Progress'),
(1002,2,101,'2026-06-02','Rejected'),
(1003,3,102,'2026-06-03','Selected'),
(1004,4,102,'2026-06-04','In Progress');

-- Interview Rounds
INSERT INTO Interviews VALUES
(1,1001,1,'Aptitude','2026-06-05','Pass'),
(2,1001,2,'Technical','2026-06-08','Pass'),
(3,1001,3,'HR','2026-06-12','Pending'),

(4,1002,1,'Aptitude','2026-06-05','Pass'),
(5,1002,2,'Technical','2026-06-08','Fail'),

(6,1003,1,'Aptitude','2026-06-05','Pass'),
(7,1003,2,'Technical','2026-06-08','Pass'),
(8,1003,3,'HR','2026-06-12','Pass'),

(9,1004,1,'Aptitude','2026-06-05','Pass'),
(10,1004,2,'Technical','2026-06-08','Pending');

-- Offers
INSERT INTO Offers VALUES
(501,1003,'2026-06-15',750000,'Accepted');

