USE CityOpsDB;

-- Το τμήμα (έστω ΑΑΑΑ000001) θέλει να δει πόσα περιστατικά ολοκλήρωσε 
-- σε κάποια χρονική στιγμή που ορίζει (start_date end_date).

SELECT 
    D.DeptName,
    COUNT(DISTINCT I.IncidentID) AS Total_Completed_Incidents
FROM Department D
JOIN Employee E ON D.DepartmentID = E.DepartmentID
JOIN Assignment A ON E.EmployeeID = A.EmployeeID
JOIN Incident I ON A.IncidentID = I.IncidentID
JOIN StatusHistory SH ON I.IncidentID = SH.IncidentID
WHERE D.DepartmentID = 'AAAA000001'       -- Το συγκεκριμένο τμήμα
  AND SH.Status = 'ΟΛΟΚΛΗΡΩΘΗΚΕ'          -- Μόνο ολοκληρωμένα
  AND SH.ChangeDate BETWEEN '2025-01-01' AND '2025-12-31' -- Χρονικό παράθυρο
  AND SH.ChangeDate = (                   -- Εξασφαλίζουμε ότι είναι η ΤΡΕΧΟΥΣΑ κατάσταση
      SELECT MAX(ChangeDate) 
      FROM StatusHistory SH2 
      WHERE SH2.IncidentID = I.IncidentID
  );