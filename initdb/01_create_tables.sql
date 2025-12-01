CREATE TABLE IF NOT EXISTS subscriptions (
                                             id SERIAL PRIMARY KEY,
                                             telegram_id BIGINT NOT NULL,
                                             username TEXT,
                                             start_date TIMESTAMPTZ NOT NULL,
                                             end_date TIMESTAMPTZ NOT NULL,
                                             status TEXT DEFAULT 'active'
);