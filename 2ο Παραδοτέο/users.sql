USE CityOpsDB;

-- Αυτός ο κώδικας δημιουργεί τους χρήστες και τα δικαιώματά τους.

-- Καθαρισμός παλιών χρηστών (αν υπάρχουν) για αποφυγή σφαλμάτων.
DROP USER IF EXISTS 'city_admin'@'localhost';
DROP USER IF EXISTS 'city_employee'@'localhost';
DROP USER IF EXISTS 'city_citizen'@'localhost';
FLUSH PRIVILEGES;

-- 1. Διαχειριστής (Admin)
-- Περιγραφή: Πλήρης διαχείριση της βάσης, δημιουργία τμημάτων, έλεγχος χρηστών.
CREATE USER 'city_admin'@'localhost' IDENTIFIED BY 'admin1234';
-- Δικαιώματα:
-- ALL PRIVILEGES: Πλήρης έλεγχος σε όλους τους πίνακες και τα δεδομένα της CityOpsDB.
-- WITH GRANT OPTION: Μπορεί να δίνει δικαιώματα σε άλλους χρήστες (π.χ. νέους υπαλλήλους).
GRANT ALL PRIVILEGES ON CityOpsDB.* TO 'city_admin'@'localhost' WITH GRANT OPTION;

-- 2. Δημοτικός Υπάλληλος (Employee)
-- Περιγραφή: Διαχείριση περιστατικών, ενημέρωση κατάστασης (status), καταγραφή ενεργειών.
CREATE USER 'city_employee'@'localhost' IDENTIFIED BY 'employee1234';
-- Δικαιώματα Ανάγνωσης (SELECT):
-- Πρέπει να βλέπει τα πάντα για να κάνει τη δουλειά του (Περιστατικά, Ιστορικό, Φωτογραφίες, Τμήματα).
GRANT SELECT ON CityOpsDB.* TO 'city_employee'@'localhost';
-- Δικαιώματα Ενημέρωσης/Εισαγωγής (INSERT/UPDATE):
-- 1. Να ενημερώνει την κατάσταση (προσθήκη νέας εγγραφής στο ιστορικό)
GRANT INSERT ON CityOpsDB.StatusHistory TO 'city_employee'@'localhost';
-- 2. Να καταγράφει ενέργειες (Action) που έκανε και το κόστος τους
GRANT INSERT, UPDATE ON CityOpsDB.Action TO 'city_employee'@'localhost';
-- 3. Να ενημερώνει σχόλια στην Ανάθεση
GRANT UPDATE ON CityOpsDB.Assignment TO 'city_employee'@'localhost';
-- 4. Να έχει πρόσβαση στις Όψεις (Views) που φτιάξαμε για ευκολία
GRANT SELECT ON CityOpsDB.Incident_Details_View TO 'city_employee'@'localhost';
GRANT SELECT ON CityOpsDB.Action_Details_View TO 'city_employee'@'localhost';

-- 3. Πολίτης (Citizen)
-- Περιγραφή: Εισαγωγή αναφοράς, προβολή δικών του αναφορών, ενημέρωση προφίλ.

CREATE USER 'city_citizen'@'localhost' IDENTIFIED BY 'citizen1234';
-- Δικαιώματα Εισαγωγής (INSERT):
-- Ο πολίτης δημιουργεί (Insert) μόνο Περιστατικά και ανεβάζει Φωτογραφίες.
GRANT INSERT ON CityOpsDB.Incident TO 'city_citizen'@'localhost';
GRANT INSERT ON CityOpsDB.Photo TO 'city_citizen'@'localhost';
-- Χρειάζεται INSERT στο StatusHistory για να οριστεί η αρχική κατάσταση 'NEO' κατά την υποβολή.
GRANT INSERT ON CityOpsDB.StatusHistory TO 'city_citizen'@'localhost';
-- Δικαιώματα Ανάγνωσης (SELECT):
-- Πρέπει να βλέπει τις λίστες επιλογών (Τύπους Περιστατικών, Περιοχές) για να συμπληρώσει τη φόρμα.
GRANT SELECT ON CityOpsDB.IncidentType TO 'city_citizen'@'localhost';
GRANT SELECT ON CityOpsDB.District TO 'city_citizen'@'localhost';
-- Δικαιώματα Προφίλ (SELECT, UPDATE):
-- Μπορεί να βλέπει και να αλλάζει ΜΟΝΟ τα στοιχεία του πίνακα Citizen (π.χ. τηλέφωνο).
GRANT SELECT, UPDATE ON CityOpsDB.Citizen TO 'city_citizen'@'localhost';
-- Δικαιώματα Προβολής Κατάστασης:
-- Του δίνουμε πρόσβαση στην Όψη (View) για να βλέπει την πορεία των αιτημάτων του.
-- (Σημείωση: Στην πράξη η εφαρμογή φιλτράρει τα αποτελέσματα ώστε να βλέπει μόνο τα δικά του).
GRANT SELECT ON CityOpsDB.Incident_Details_View TO 'city_citizen'@'localhost';
-- Εφαρμογή των αλλαγών
FLUSH PRIVILEGES;
