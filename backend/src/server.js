import express from 'express';
import cors from 'cors';
import helmet from 'helmet';
import morgan from 'morgan';

const app = express();
const port = Number(process.env.PORT || 8080);

app.use(helmet());
app.use(cors({ origin: false }));
app.use(express.json({ limit: '1mb' }));
app.use(morgan('combined'));

const routes = [
  'POST /api/v1/auth/request-otp',
  'POST /api/v1/auth/verify-otp',
  'POST /api/v1/auth/refresh',
  'POST /api/v1/auth/logout',
  'GET /api/v1/users/me',
  'PATCH /api/v1/users/me',
  'GET /api/v1/properties',
  'POST /api/v1/properties',
  'GET /api/v1/properties/:id',
  'PATCH /api/v1/properties/:id',
  'POST /api/v1/properties/:id/visits',
  'GET /api/v1/products',
  'POST /api/v1/products',
  'GET /api/v1/products/:id',
  'PATCH /api/v1/products/:id',
  'POST /api/v1/orders',
  'GET /api/v1/orders',
  'GET /api/v1/orders/:id',
  'POST /api/v1/verification/requests',
  'GET /api/v1/verification/me',
  'GET /api/v1/admin/audit',
  'PATCH /api/v1/admin/verification/:id'
];

app.get('/health', (_req, res) => {
  res.json({
    ok: true,
    service: 'ayajke-global-api',
    release: '09',
    database: 'not-configured',
    routes: routes.length
  });
});

app.get('/api/v1', (_req, res) => {
  res.json({
    name: 'Ay Ajke Global API',
    release: '09',
    modules: [
      'auth', 'users', 'properties', 'visits',
      'marketplace', 'orders', 'verification',
      'notifications', 'admin', 'audit'
    ],
    routes
  });
});

app.listen(port, () => {
  console.log(`Ay Ajke Global API listening on ${port}`);
});
