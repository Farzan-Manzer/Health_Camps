Authentication Endpoints

- POST /auth/login - User login (app.py:131)
- POST /auth/register - Register new user (app.py:245)
- POST /auth/verify - Verify user session/token (app.py:321)

User Management Endpoints

- GET /users - Get all users (app.py:372)
- GET /users/<int:user_id> - Get user details (app.py:406)

Forms Endpoints

- GET /forms - Get all forms with fields, sections, and conditions (app.py:460)

Parameters Endpoints

- GET /parameters - Get all active parameters (app.py:604)
- GET /parameters/<int:parameter_id> - Get parameter details (app.py:637)

Conditions Endpoints

- GET /forms/<int:form_id>/conditions - Get form conditional logic rules (app.py:675)
- GET /conditions/<int:condition_id> - Get condition details (app.py:853)
- POST /evaluate-conditions - Evaluate conditions based on form state (app.py:888)

Draft Submission Endpoints

- POST /forms/<int:form_id>/drafts - Save draft submission (app.py:718, rate-limited)
- GET /forms/<int:form_id>/drafts - Get draft submission (app.py:776)
- DELETE /forms/<int:form_id>/drafts - Delete draft submission (app.py:818)

Camps Endpoints

- GET /camps - Get all camps (app.py:1010)
- GET /camps/<int:camp_id> - Get camp details (app.py:1044)

Patients Endpoints

- GET /patients/search - Search patients by name/phone/ID (app.py:1085, token required)
- GET /patients/<patient_id> - Get patient details (app.py:1164)
- GET /patients - Get all patients (paginated) (app.py:1199, token required)
- GET /patients/all - Get all patients for offline caching (app.py:1267, token required)
- POST /patients - Create new patient (app.py:1339)

Submissions Endpoints

- POST /submissions - Submit form as clinical assessments (app.py:1420, rate-limited)
- GET /submissions - Get submissions for dashboard/reporting (app.py:1675)

Health Check

- GET / - Server health check (app.py:454)

Rate Limits:

- Default: 200 per day, 50 per hour
- /forms/<form_id>/drafts (POST): 100 per minute
- /submissions (POST): 100 per minute

Authentication: Some endpoints require JWT token in Authorization header (Bearer token).
