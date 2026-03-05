USE CityOpsDB;

-- ---------------------------------------------------------
-- ΒΗΜΑ 3: Δημιουργία Όψεων (Views) - FINAL VERSION
-- ---------------------------------------------------------

-- Όψη 1: Περιστατικά_Με_Στοιχεία (Incident_Details_View)
CREATE OR REPLACE VIEW Incident_Details_View AS
SELECT 
    I.IncidentID,
    I.Description AS IncidentDescription,
    I.SubmissionDate,
    I.Street,
    I.StreetNumber,
    IT.TypeName AS IncidentType,
    IT.Importance,
    C.LastName AS CitizenLastName,
    C.Phone AS CitizenPhone
FROM Incident I
JOIN IncidentType IT ON I.TypeID = IT.TypeID
JOIN Citizen C ON I.UserID = C.UserID;

-- Όψη 2: Ενέργειες_Με_Υπεύθυνους (Action_Details_View)
-- ΠΡΟΣΟΧΗ: Προστέθηκε το I.IncidentID όπως ζητήθηκε στις αλλαγές
CREATE OR REPLACE VIEW Action_Details_View AS
SELECT 
    I.IncidentID,                          -- ΝΕΑ ΠΡΟΣΘΗΚΗ
    A.ActionID,
    A.ActionDate,
    A.Cost,
    A.Comments AS ActionComments,
    I.Description AS IncidentDescription,
    E.LastName AS EmployeeLastName,
    E.Email AS EmployeeEmail,
    D.DeptName AS DepartmentName,
    AT.ActionName AS ActionType
FROM Action A
JOIN Incident I ON A.IncidentID = I.IncidentID
JOIN Employee E ON A.EmployeeID = E.EmployeeID
JOIN Department D ON E.DepartmentID = D.DepartmentID
JOIN ActionType AT ON A.ActionTypeID = AT.ActionTypeID;