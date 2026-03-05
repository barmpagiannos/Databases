USE CityOpsDB;

-- 1. Πολίτες
INSERT INTO Citizen (UserID, FirstName, LastName, Email, Phone, Password) VALUES
('AAAA000001', 'Παναγιώτης', 'Δεμιτσόγλου', 'pldemits@ece.auth.gr', '6942456789', 'pdfg123456'),
('AAAA000002', 'Βασίλης', 'Μπαρμπαγιάννος', 'vmparmpg@ece.auth.gr', '6987456123', 'vm123456'),
('AAAA000003', 'Βασίλης', 'Καλαντζής', 'kalavasi@ece.auth.gr', '6930231258', '159753vk');

-- 2. Τμήματα
INSERT INTO Department (DepartmentID, DeptName, Phone) VALUES
('AAAA000001', 'Διεύθυνση Καθαριότητας', '2310445510'),
('AAAA000002', 'Διεύθυνση Βιώσιμης Κινητικότητας', '2310445511'),
('AAAA000003', 'Διεύθυνση Κατασκευών', '2310445512');

-- 3. Περιοχές
INSERT INTO District (DistrictID, DistrictName, ZipCode) VALUES
('AAAA000001', 'Νέα Παραλία - Λευκός Πύργος', 54248),
('AAAA000002', 'Ροτόντα', 54351),
('AAAA000003', 'Πλατεία Αριστοτέλους', 54624),
('AAAA000004', 'Αγίου Δημητρίου', 54643);

-- 4. Τύποι Περιστατικών
INSERT INTO IncidentType (TypeID, TypeName, Importance) VALUES
('AAAA000001', 'Παιδική χαρά', 'ΥΨΗΛΗ'),
('AAAA000002', 'Κακοτεχνία Πεζοδρομίου', 'ΜΕΤΡΙΑ'),
('AAAA000003', 'Βανδαλισμός', 'ΜΕΤΡΙΑ'),
('AAAA000004', 'Καθαριότητα', 'ΧΑΜΗΛΗ');

-- 5. Τύποι Ενέργειας
INSERT INTO ActionType (ActionTypeID, ActionName, Description) VALUES
('ACT001', 'Προμήθεια', 'Αγορά υλικών και ανταλλακτικών'),
('ACT002', 'Επισκευή', 'Επιτόπια εργασία αποκατάστασης'),
('ACT003', 'Έλεγχος', 'Επίσκεψη για εκτίμηση βλάβης'),
('ACT004', 'Αντικατάσταση', 'Αντικατάσταση φθαρμένων υλικών'),
('ACT005', 'Καθαριότητα (Δήμος)', 'Καθαριότητα χώρων από συνεργεία του Δήμου');

-- 6. Υπάλληλοι
INSERT INTO Employee (EmployeeID, FirstName, LastName, Email, Phone, DepartmentID, Role) VALUES
('AAAA000001', 'Νικόλαος', 'Μπαντής', 'n.mpantis@dthess.gr', '2310445561', 'AAAA000002', 'Υπεύθυνος Προμηθειών'),
('AAAA000002', 'Ιωάννης', 'Ψυχίδης', 'i.psychidis@dthess.gr', '2310445563', 'AAAA000001', 'Υπάλληλος Τεχνικών Υπηρεσιών'),
('AAAA000003', 'Πέτρος', 'Παπαργυρίου', 'p.papargyriou@dthess.gr', '2310445562', 'AAAA000003', 'Προϊστάμενος Τεχνικών Έργων'),
('AAAA000004', 'Παντελής', 'Νικολάου', 'p.nikolaou@dthess.gr', '2310445560', 'AAAA000001', 'Υπάλληλος Καθαριότητας');

-- 7. Περιστατικά
INSERT INTO Incident (IncidentID, Description, SubmissionDate, Street, StreetNumber, Latitude, Longitude, UserID, TypeID, DistrictID) VALUES
('AAAA000001', 'Σπασμένο πεζοδρόμιο, με αποτέλεσμα να σπάσω το πόδι μου.', '2025-08-30 16:41:12', 'Νίκης', 15, 40.374930, 22.570660, 'AAAA000001', 'AAAA000002', 'AAAA000001'),
('AAAA000002', 'Κακοτεχνία σε τσουλήθρα παιδικής χαράς.', '2025-09-22 08:30:05', 'Λεωφ. Μεγ. Αλεξάνδρου', 25, 40.630349, 22.951826, 'AAAA000001', 'AAAA000001', 'AAAA000001'),
('AAAA000003', 'Σκουπίδια στο πάρκο.', '2025-09-15 10:00:00', 'Εγνατία', 100, 40.632000, 22.950000, 'AAAA000003', 'AAAA000004', 'AAAA000002');

-- 8. Ανάθεση
INSERT INTO Assignment (AssignmentID, IncidentID, EmployeeID, AssignmentDate, Comments, Priority) VALUES
('AAAA000001', 'AAAA000001', 'AAAA000001', '2025-09-10 09:00:00', NULL, 2), -- 2 = METRIA
('AAAA000002', 'AAAA000002', 'AAAA000003', '2025-10-13 11:30:00', 'Παρακαλώ για την άμεση διευθέτηση.', 3); -- 3 = YPSILI

-- 9. Ιστορικό Κατάστασης
INSERT INTO StatusHistory (IncidentID, HistoryID, ChangeDate, Status, Comments) VALUES
('AAAA000001', 'HIST001', '2025-08-30 16:41:12', 'NEO', 'Αρχική Υποβολή'),
('AAAA000001', 'HIST002', '2025-09-13 12:00:00', 'ΣΕ_ΕΞΕΛΙΞΗ', 'Το περιστατικό ανατέθηκε στην αρμόδια υπηρεσία.'),
('AAAA000003', 'HIST001', '2025-09-15 10:00:00', 'NEO', 'Υπό διερεύνηση'),
('AAAA000002', 'HIST001', '2025-10-22 14:00:00', 'ΟΛΟΚΛΗΡΩΘΗΚΕ', 'Το περιστατικό διευθετήθηκε');

-- 10. Φωτογραφία
INSERT INTO Photo (IncidentID, PhotoID, URL, UploadDate) VALUES
('AAAA000003', 'PH001', 'http://cityops.gr/photos/img1.jpg', '2025-08-30 16:42:00'),
('AAAA000001', 'PH001', 'http://cityops.gr/photos/img2.jpg', '2025-09-22 08:31:00');

-- 11. Ενέργεια
INSERT INTO Action (ActionID, ActionDate, Cost, Comments, IncidentID, EmployeeID, ActionTypeID) VALUES
('LOG001', '2025-08-31 10:00:00', 0.00, 'Έλεγχος στο πεζοδρόμιο', 'AAAA000001', 'AAAA000001', 'ACT003'),
('LOG002', '2025-09-01 12:00:00', 150.00, 'Αγορά πλακών πεζοδρομίου', 'AAAA000001', 'AAAA000003', 'ACT001'),
('LOG003', '2025-09-02 09:30:00', 0.00, 'Τοποθέτηση πλακών', 'AAAA000001', 'AAAA000001', 'ACT002'),
('LOG004', '2025-09-04 12:00:00', 331.00, 'Επισκευή Τσουλήθρας', 'AAAA000002', 'AAAA000002', 'ACT002'),
('LOG005', '2025-09-04 13:00:00', 0.00, 'Εργασίες Καθαριότητας', 'AAAA000003', 'AAAA000004', 'ACT005');