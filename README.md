# Ay Ajke Global Limited — Consolidated Build 10

Build 10 is the consolidated continuation of the previous build. The existing Rent & Property, Marketplace, Account/Security and backend foundation are retained.

## Build 10 additions
- Added **আরও সেবা / ইত্যাদি** hub inside the main app.
- Added a dedicated **More** bottom-navigation destination.
- Added future-service placeholders for Delivery & Courier, Home Services, Jobs & Careers, Payment/Financial, Education, News & Media, Transport and Coming Soon.
- The More Services hub is designed so new modules can be connected later without creating a separate app/project.

## Existing modules retained
- Global Home / main dashboard foundation
- Rental / Rent & Property
- Owner / Tenant flows
- Property Add, Search and Filter
- Visit / Booking
- Verification
- Marketplace, Product Add/Search/Details
- Cart, Checkout demo, Orders
- Buyer/Seller dashboard
- Account, Login/OTP UI, Security Center
- Backend/API foundation

## Important
This is still a development build. Production deployment requires a hosted HTTPS backend, real database, OTP provider, secure session/token storage, private document storage, payment gateway, notification provider, admin controls, monitoring and backups.

Never trust client-supplied roles, identity verification, payment status or order totals; enforce authorization and validation on the server.
