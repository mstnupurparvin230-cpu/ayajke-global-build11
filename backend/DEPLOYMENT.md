# Build 09 deployment checklist

1. Deploy the API behind HTTPS.
2. Provision PostgreSQL and apply `schema.sql`.
3. Provision Redis or an equivalent rate-limit/session service.
4. Set secrets only as server environment variables.
5. Configure object storage for images/documents with private access.
6. Connect the Flutter `ApiConfig.baseUrl` to the deployed HTTPS API.
7. Implement real OTP delivery and server-side OTP verification.
8. Implement access/refresh token rotation and revocation.
9. Add server-side role and resource authorization.
10. Add payment provider only after the order flow is server-authoritative.
11. Add monitoring, backups, audit review and incident response.

Never commit `.env`, private keys, payment secrets, OTP secrets, or identity documents.
