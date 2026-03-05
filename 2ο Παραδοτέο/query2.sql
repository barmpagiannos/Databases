USE CityOpsDB;

-- Ο υπεύθυνος του τμήματος θέλει μια λίστα με όλους τους εργαζόμενούς 
-- με πληροφορίες όπως (Όνομα, Επώνυμο, Τηλέφωνο, email, Τίτλος επαγγέλματος).

SELECT 
    FirstName, 
    LastName, 
    Phone, 
    Email, 
    Role
FROM Employee
WHERE DepartmentID = 'AAAA000002'; -- Διεύθυνση Βιώσιμης Κινητικότητας