# Ay Ajke Global Limited — Build 06

Build 06 keeps the complete Build 03–05 direction and adds a backend-ready security foundation.

## Added
- Secure Login / OTP UI
- Session model
- Auth repository abstraction
- API configuration placeholder
- Security Center
- Backend security rules/checklist
- Role/authorization architecture notes

## Production backend still required
This package deliberately does NOT contain real server credentials or a fake production API.

A real backend should provide:
- HTTPS API
- User registration/login
- Server-side OTP verification
- Secure session/token rotation
- User roles and permissions
- Property APIs
- Marketplace/product APIs
- Cart/order APIs
- Verification/KYC workflow with consent
- Notifications
- Admin moderation
- Audit logs
- Payment gateway integration

## Security requirements
- Never put API secrets in Flutter code.
- Never trust role, identity, payment or verification status from the client.
- Use server-side authorization on every protected endpoint.
- Rate-limit OTP/login attempts.
- Encrypt sensitive data at rest and in transit.
- Store identity documents only in a controlled backend storage system.
- Keep an auditable trail for sensitive operations.

## Run
1. Install Flutter.
2. Run `flutter pub get`.
3. Run `flutter run`.


## Build 07
A credential-free backend starter is included under `backend/`.
It contains an Express health/API skeleton, PostgreSQL schema starter, environment template and security notes.
The Flutter app remains fully usable as the UI foundation; real API wiring should be enabled only after a real server is deployed and secured.


## Build 08
The Flutter project now includes a backend integration layer and a Backend Status screen.
`backend/API_CONTRACT.md` defines the planned frontend/backend endpoint contract.
The app intentionally does not contain real production server credentials.
