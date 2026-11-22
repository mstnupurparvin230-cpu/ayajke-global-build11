# Build 08 API Contract

The Flutter client and backend should agree on these endpoint families.

## Authentication
- POST `/api/v1/auth/request-otp`
- POST `/api/v1/auth/verify-otp`
- POST `/api/v1/auth/refresh`
- POST `/api/v1/auth/logout`

## Users
- GET `/api/v1/users/me`
- PATCH `/api/v1/users/me`

## Properties
- GET `/api/v1/properties`
- POST `/api/v1/properties`
- GET `/api/v1/properties/:id`
- PATCH `/api/v1/properties/:id`
- POST `/api/v1/properties/:id/visits`

## Marketplace
- GET `/api/v1/products`
- POST `/api/v1/products`
- GET `/api/v1/products/:id`
- PATCH `/api/v1/products/:id`

## Orders
- POST `/api/v1/orders`
- GET `/api/v1/orders`
- GET `/api/v1/orders/:id`

## Verification
- POST `/api/v1/verification/requests`
- GET `/api/v1/verification/me`

## Admin
- GET `/api/v1/admin/audit`
- PATCH `/api/v1/admin/verification/:id`

All protected endpoints must authenticate the caller and authorize the requested action server-side.
