USE CityOpsDB;

-- Ένας υπεύθυνος θέλει να δει ποιες ενέργειες έκανε ένας υπάλληλος 
-- (έστω ID ΑΑΑΑ000003) μια συγκεκριμένη μέρα που ορίζει ο ίδιος (DATE).

SELECT 
    E.FirstName,
    E.LastName,
    A.ActionDate,
    AT.ActionName,
    A.Comments,
    A.Cost
FROM Action A
JOIN Employee E ON A.EmployeeID = E.EmployeeID
JOIN ActionType AT ON A.ActionTypeID = AT.ActionTypeID
WHERE A.EmployeeID = 'AAAA000001'           -- Ο συγκεκριμένος υπάλληλος
  AND DATE(A.ActionDate) = '2025-08-31';    -- Η συγκεκριμένη ημερομηνία
