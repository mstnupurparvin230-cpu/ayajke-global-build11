-- Ay Ajke Global Build 07 database starter
-- PostgreSQL
-- Sensitive identity documents should live in controlled object storage,
-- while this database keeps references, status and audit metadata.

CREATE TABLE IF NOT EXISTS users (
  id UUID PRIMARY KEY,
  phone VARCHAR(32) UNIQUE NOT NULL,
  display_name VARCHAR(120),
  role VARCHAR(32) NOT NULL DEFAULT 'buyer',
  phone_verified BOOLEAN NOT NULL DEFAULT FALSE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS properties (
  id UUID PRIMARY KEY,
  owner_id UUID NOT NULL REFERENCES users(id),
  title VARCHAR(200) NOT NULL,
  property_type VARCHAR(40) NOT NULL,
  city VARCHAR(120),
  area VARCHAR(120),
  price NUMERIC(14,2),
  status VARCHAR(32) NOT NULL DEFAULT 'draft',
  verified BOOLEAN NOT NULL DEFAULT FALSE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS products (
  id UUID PRIMARY KEY,
  seller_id UUID NOT NULL REFERENCES users(id),
  name VARCHAR(200) NOT NULL,
  category VARCHAR(80) NOT NULL,
  price NUMERIC(14,2) NOT NULL,
  stock INTEGER NOT NULL DEFAULT 0,
  status VARCHAR(32) NOT NULL DEFAULT 'draft',
  verified BOOLEAN NOT NULL DEFAULT FALSE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS orders (
  id UUID PRIMARY KEY,
  buyer_id UUID NOT NULL REFERENCES users(id),
  status VARCHAR(32) NOT NULL DEFAULT 'pending',
  total NUMERIC(14,2) NOT NULL DEFAULT 0,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS audit_logs (
  id BIGSERIAL PRIMARY KEY,
  actor_user_id UUID REFERENCES users(id),
  action VARCHAR(120) NOT NULL,
  target_type VARCHAR(80),
  target_id VARCHAR(120),
  metadata JSONB,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
