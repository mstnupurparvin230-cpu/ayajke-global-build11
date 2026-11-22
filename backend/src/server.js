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

app.get('/health', (_req, res) => {
  res.json({ ok: true, service: 'ayajke-global-api', build: '07' });
});

app.get('/api/v1', (_req, res) => {
  res.json({
    name: 'Ay Ajke Global API',
    modules: ['auth', 'users', 'properties', 'marketplace', 'orders', 'verification', 'notifications', 'admin']
  });
});

app.listen(port, () => {
  console.log(`Ay Ajke Global API listening on ${port}`);
});
