USE CityOpsDB;

-- Ποιοι υπάλληλοι δεν έχουν αναλάβει ποτέ καμία εργασία (ενέργεια) σε συγκεκριμένο 
-- τύπου περιστατικό που έχουν υποβάλει πολίτες.

SELECT 
    E.EmployeeID, 
    E.FirstName, 
    E.LastName, 
    E.Role
FROM Employee E
WHERE E.EmployeeID NOT IN (
    -- Υποερώτημα: Βρες τους υπαλλήλους που ΕΧΟΥΝ κάνει ενέργεια σε "Παιδική χαρά"
    SELECT DISTINCT A.EmployeeID
    FROM Action A
    JOIN Incident I ON A.IncidentID = I.IncidentID
    WHERE I.TypeID = 'AAAA000001' -- ID για "Παιδική χαρά"
);