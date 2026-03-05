USE CityOpsDB;

-- Ένας υπεύθυνος θέλει να δει τα κοινά και μη κοινά incidents που αφορούν 
-- δύο εργάτες (έστω ID ΑΑΑΑ000003 και ΑΑΑΑ000004) και είναι σε εξέλιξη.

SELECT DISTINCT 
    I.IncidentID,
    I.Description,
    SH.Status,
    A.EmployeeID,
    E.LastName AS EmployeeName
FROM Assignment A
JOIN Incident I ON A.IncidentID = I.IncidentID
JOIN Employee E ON A.EmployeeID = E.EmployeeID
JOIN StatusHistory SH ON I.IncidentID = SH.IncidentID
WHERE A.EmployeeID IN ('AAAA000001', 'AAAA000003') -- Οι δύο υπάλληλοι
  AND SH.Status IN ('ΣΕ_ΕΞΕΛΙΞΗ', 'ΣΕ_ΑΝΑΘΕΣΗ')    -- Κατάσταση μη ολοκληρωμένη
  AND SH.ChangeDate = (                            -- Μόνο αν αυτή είναι η τρέχουσα κατάσταση
      SELECT MAX(ChangeDate) 
      FROM StatusHistory SH2 
      WHERE SH2.IncidentID = I.IncidentID
  );