USE CityOpsDB;

-- Tρέχουσα κατάσταση όλων των περιστατικών που έχει υποβάλει ο πολίτης 
-- (έστω ID ΑΑΑΑ000003)με το Όνομά του περιστατικού την ημερομηνία υποβολής 
-- και σχόλια (αν υπάρχουν).

SELECT 
    I.IncidentID,
    I.SubmissionDate,
    IT.TypeName AS IncidentType,
    SH.Status AS CurrentStatus,
    SH.ChangeDate AS LastUpdate,
    SH.Comments AS LastComment
FROM Incident I
JOIN IncidentType IT ON I.TypeID = IT.TypeID
JOIN StatusHistory SH ON I.IncidentID = SH.IncidentID
WHERE I.UserID = 'AAAA000001'  -- Ο συγκεκριμένος πολίτης
  AND SH.ChangeDate = (        -- Φίλτρο για την πιο πρόσφατη κατάσταση
      SELECT MAX(ChangeDate) 
      FROM StatusHistory SH2 
      WHERE SH2.IncidentID = I.IncidentID
  );