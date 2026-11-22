# Ay Ajke Global — Build 07 Backend Starter

This is a production-oriented backend STARTER architecture for the Flutter app.
It is intentionally credential-free and uses placeholders.

## Suggested stack
- Node.js + Express
- PostgreSQL
- JWT access tokens + rotating refresh tokens
- Redis for rate limiting/session controls
- Object storage for property/product images and verification documents

## Modules
- auth
- users / roles
- properties / visits
- marketplace / products
- carts / orders
- verification
- notifications
- admin / audit

## Security
- HTTPS only in deployment
- Server-side authorization on every protected route
- Input validation
- Rate limiting
- Password/OTP protection
- Short-lived access tokens
- Refresh-token rotation/revocation
- Audit logging
- Encrypted sensitive storage
- No secrets in Flutter source

## Before production
Configure real environment variables on the server and connect PostgreSQL/Redis/object storage.
Do not commit .env files or credentials.
