
from flask import Flask, render_template, request, redirect, url_for, session, flash
import mysql.connector
from mysql.connector import Error
from datetime import datetime
import time

app = Flask(__name__)
app.secret_key = ''

# Στοιχεία σύνδεσης με MySQL
db_config = {
    'host': '',
    'user': '',
    'password': '',
    'database': ''
}

def get_db_connection():
    """Επιστρέφει νέα σύνδεση στη ΒΔ ή σηκώνει Error."""
    return mysql.connector.connect(**db_config)

@app.route('/')
def index():
    return redirect(url_for('login'))

# -----------------------------
# LOGIN / LOGOUT
# -----------------------------
@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        userid = request.form.get('userid', '').strip()
        password = request.form.get('password', '')
        role = request.form.get('role', '')

        try:
            conn = get_db_connection()
            cursor = conn.cursor(dictionary=True)
        except Error as err:
            flash(f"Σφάλμα σύνδεσης με βάση: {err}", 'error')
            return render_template('login.html')

        try:
            if role == 'citizen':
                # Έλεγχος στον πίνακα Citizen
                cursor.execute("""
                    SELECT UserID, FirstName, LastName, Password
                    FROM Citizen
                    WHERE UserID = %s
                """, (userid,))
                user = cursor.fetchone()
                if user and user['Password'] == password:
                    session['user_id'] = user['UserID']
                    session['role'] = 'citizen'
                    session['name'] = f"{user['FirstName']} {user['LastName']}"
                    return redirect(url_for('citizen_dashboard'))

            elif role == 'employee':
                # Έλεγχος στον πίνακα Employee (χωρίς password για απλότητα)
                cursor.execute("""
                    SELECT EmployeeID, FirstName, LastName
                    FROM Employee
                    WHERE EmployeeID = %s
                """, (userid,))
                user = cursor.fetchone()
                if user:
                    session['user_id'] = user['EmployeeID']
                    session['role'] = 'employee'
                    session['name'] = f"{user['FirstName']} {user['LastName']}"
                    return redirect(url_for('employee_dashboard'))

            flash("Λάθος στοιχεία σύνδεσης!", "error")
        finally:
            cursor.close()
            conn.close()

    return render_template('login.html')

@app.route('/logout')
def logout():
    session.clear()
    return redirect(url_for('login'))

# -----------------------------
# CITIZEN DASHBOARD
# -----------------------------
@app.route('/citizen')
def citizen_dashboard():
    if session.get('role') != 'citizen':
        return redirect(url_for('login'))

    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)

    try:
        # Περιστατικά του πολίτη με την τρέχουσα (τελευταία) κατάσταση
        cursor.execute("""
            SELECT I.IncidentID, I.Description, I.SubmissionDate, I.Street, I.StreetNumber, SH.Status
            FROM Incident I
            JOIN StatusHistory SH ON I.IncidentID = SH.IncidentID
            WHERE I.UserID = %s
              AND SH.ChangeDate = (
                  SELECT MAX(ChangeDate)
                  FROM StatusHistory SH2
                  WHERE SH2.IncidentID = I.IncidentID
              )
            ORDER BY I.SubmissionDate DESC
        """, (session['user_id'],))
        incidents = cursor.fetchall()

        # Για το φόρμα δημιουργίας
        cursor.execute("SELECT TypeID, TypeName FROM IncidentType ORDER BY TypeName")
        types = cursor.fetchall()

        cursor.execute("SELECT DistrictID, DistrictName FROM District ORDER BY DistrictName")
        districts = cursor.fetchall()

    finally:
        cursor.close()
        conn.close()

    return render_template(
        'citizen.html',
        incidents=incidents,
        types=types,
        districts=districts,
        user_name=session['name']
    )

def _next_incident_id(conn):
    """Παράγει νέο IncidentID βάσει του τελευταίου στην ΒΔ."""
    c = conn.cursor()
    c.execute("SELECT IncidentID FROM Incident ORDER BY IncidentID DESC LIMIT 1")
    row = c.fetchone()
    c.close()
    last_id = row[0] if row else None
    # Increment the last IncidentID so to have a new unique ID.
    prefix = last_id[:4]
    number = int(last_id[4:]) + 1
    return f"{prefix}{number:06d}"
    

@app.route('/citizen/create', methods=['POST'])
def create_incident():
    if session.get('role') != 'citizen':
        return redirect(url_for('login'))

    description   = request.form.get('description', '').strip()
    street        = request.form.get('street', '').strip()
    street_number = request.form.get('street_number', '').strip()
    type_id       = request.form.get('type_id')
    district_id   = request.form.get('district_id')

    if not description or not street or not type_id or not district_id:
        flash("Συμπλήρωσε όλα τα υποχρεωτικά πεδία.", "error")
        return redirect(url_for('citizen_dashboard'))

    conn = get_db_connection()
    cursor = conn.cursor()

    try:
        new_id = _next_incident_id(conn)
        now = datetime.now()

        sql_incident = """
            INSERT INTO Incident (IncidentID, Description, SubmissionDate, Street, StreetNumber, UserID, TypeID, DistrictID)
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
        """

        cursor.execute(sql_incident, (new_id, description, now, street, street_number, session['user_id'], type_id, district_id))

        # Αρχική κατάσταση NEO και αρχικό HistoryID 'HIST001'
        """ hist_id = f"H{str(int(time.time()))[-9:]}" """
        # Insert StatusHistory (Initial Status: NEO).
        sql_history = """
            INSERT INTO StatusHistory (IncidentID, HistoryID, ChangeDate, Status, Comments)
            VALUES (%s, 'HIST001', %s, 'NEO', 'Αρχική Υποβολή')
            """
        cursor.execute(sql_history, (new_id, now))

        conn.commit()
        flash("Η αναφορά υποβλήθηκε επιτυχώς!", "success")

    except Error as err:
        conn.rollback()
        flash(f"Σφάλμα καταχώρισης: {err}", "error")
    finally:
        cursor.close()
        conn.close()

    return redirect(url_for('citizen_dashboard'))

# -----------------------------
# EMPLOYEE DASHBOARD + INCIDENT PAGE
# -----------------------------
@app.route('/employee')
def employee_dashboard():
    if session.get('role') != 'employee':
        return redirect(url_for('login'))

    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)

    try:
        cursor.execute("""
            SELECT I.IncidentID, I.Description, I.Street, SH.Status,
                   A.Priority, A.Comments AS AssignmentComments
            FROM Assignment A
            JOIN Incident I ON A.IncidentID = I.IncidentID
            JOIN StatusHistory SH ON SH.IncidentID = I.IncidentID
            WHERE A.EmployeeID = %s
              AND SH.ChangeDate = (
                  SELECT MAX(ChangeDate)
                  FROM StatusHistory SH2
                  WHERE SH2.IncidentID = I.IncidentID
              )
            ORDER BY I.SubmissionDate DESC
        """, (session['user_id'],))
        assignments = cursor.fetchall()
    finally:
        cursor.close()
        conn.close()

    return render_template('employee.html', assignments=assignments, user_name=session['name'])

@app.route('/employee/incident/<incident_id>')
def employee_incident(incident_id):
    """Σελίδα που δείχνει πληροφορίες περιστατικού και φόρμα μεταβολής κατάστασης."""
    if session.get('role') != 'employee':
        return redirect(url_for('login'))

    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)

    try:
        cursor.execute("""
            SELECT I.IncidentID, I.Description, I.Street, I.StreetNumber, I.SubmissionDate,
                   SH.Status AS CurrentStatus, A.Priority, A.Comments AS AssignmentComments
            FROM Assignment A
            JOIN Incident I ON A.IncidentID = I.IncidentID
            JOIN StatusHistory SH ON I.IncidentID = SH.IncidentID
            WHERE A.EmployeeID = %s
              AND I.IncidentID = %s
              AND SH.ChangeDate = (
                  SELECT MAX(ChangeDate)
                  FROM StatusHistory SH2
                  WHERE SH2.IncidentID = I.IncidentID
              )
            LIMIT 1
        """, (session['user_id'], incident_id))
        incident = cursor.fetchone()

        if not incident:
            flash("Δεν βρέθηκε η αναφορά ή δεν σας έχει ανατεθεί.", "error")
            return redirect(url_for('employee_dashboard'))
        
        # Λεπτομέρειες ενεργειών - Χρήση της action_details_view
        sql_actions = """
            SELECT ActionDate, Cost, ActionComments, DepartmentName, ActionType
            FROM action_details_view
            WHERE IncidentID = %s
        """
        cursor.execute(sql_actions, (incident_id,))
        actions = cursor.fetchall()

    finally:
        cursor.close()
        conn.close()

    return render_template(
        'employee_incident.html',
        incident=incident,
        user_name=session['name'],
        actions=actions
    )

@app.route('/employee/update_status/<incident_id>', methods=['POST'])
def update_status(incident_id):
    """POST για αλλαγή κατάστασης συγκεκριμένου περιστατικού."""
    if session.get('role') != 'employee':
        return redirect(url_for('login'))

    new_status = request.form.get('status', '').strip()
    comments = request.form.get('comments', '').strip()

    if not new_status:
        flash("Επίλεξε νέα κατάσταση.", "error")
        return redirect(url_for('employee_incident', incident_id=incident_id))

    conn = get_db_connection()
    cursor = conn.cursor()

    try:
        # Έλεγχος δικαιώματος: έχει ο τρέχων υπάλληλος ανάθεση για αυτό το incident;
        cursor.execute("""
            SELECT 1
            FROM Assignment
            WHERE IncidentID = %s AND EmployeeID = %s
            LIMIT 1
        """, (incident_id, session['user_id']))
        if cursor.fetchone() is None:
            flash("Δεν έχετε δικαίωμα αλλαγής για αυτή την αναφορά.", "error")
            return redirect(url_for('employee_dashboard'))

        now = datetime.now()

        #hist_id = f"H{str(int(time.time()))[-9:]}"

        match new_status:
            case 'ΣΕ_ΑΝΑΘΕΣΗ': hist_id = 'HIST002'
            case 'ΣΕ_ΕΞΕΛΙΞΗ': hist_id = 'HIST003'
            case 'ΟΛΟΚΛΗΡΩΘΗΚΕ': hist_id = 'HIST004'
            case 'ΑΚΥΡΩΘΗΚΕ': hist_id = 'HIST005'

        sql_insert = """
            INSERT INTO StatusHistory (IncidentID, HistoryID, ChangeDate, Status, Comments)
            VALUES (%s, %s, %s, %s, %s)
        """
        cursor.execute(sql_insert, (incident_id, hist_id, now, new_status, comments))

        conn.commit()
        flash(f"Η κατάσταση του {incident_id} ενημερώθηκε.", "success")

    except Error as err:
        conn.rollback()
        flash(f"Σφάλμα ενημέρωσης: {err}", "error")
    finally:
        cursor.close()
        conn.close()

    return redirect(url_for('employee_dashboard'))

if __name__ == '__main__':
    app.run(debug=True)
