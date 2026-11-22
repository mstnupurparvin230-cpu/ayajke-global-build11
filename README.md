# Ay Ajke Global Limited — Consolidated Build 09

This release is the consolidated continuation of Builds 03–08.
Nothing from the previous build direction is intentionally removed.

## Main application
- Global Home based on the supplied reference design
- Rental / Rent & Property
- Owner / Tenant flows
- Property Add, Search and Filter
- Visit / Booking UI
- Verification UI
- Marketplace
- Product Add, Search, Filter and Details
- Cart
- Checkout demo
- Orders and status UI
- Buyer/Seller dashboard
- Account
- Secure Login / OTP UI
- Security Center
- Backend status / API integration layer

## Backend starter
- Express API server skeleton
- PostgreSQL schema
- Users and roles
- Properties and visits
- Products
- Orders and order items
- Verification requests
- Audit logs
- API contract
- Deployment checklist
- Environment-variable template

## What is NOT live yet
This package is still a development/release foundation. A real deployment requires:
- a hosted HTTPS backend
- a real PostgreSQL database
- real OTP/SMS provider
- secure token/session storage and rotation
- object storage
- payment gateway
- notification provider
- admin authentication and moderation
- production monitoring/backups

No real credentials or secrets are included.

## Security
All sensitive operations must be server-authorized. Do not trust client-supplied roles, identity verification, payment status or order totals. Keep sensitive identity documents in private storage with strict access control, encryption and audit logs.
