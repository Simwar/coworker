import { PostgresStore } from '@mastra/pg';

function getConnectionString(): string {
  if (process.env.DATABASE_URL) return process.env.DATABASE_URL;
  const host = process.env.KNOWLEDGE_PG_HOST ?? 'knowledge-pg';
  const port = process.env.KNOWLEDGE_PG_PORT ?? '5432';
  const db = process.env.POSTGRES_DB ?? 'coworker';
  const user = process.env.POSTGRES_USER ?? 'postgres';
  const password = process.env.POSTGRES_PASSWORD ?? 'postgres';
  return `postgresql://${user}:${password}@${host}:${port}/${db}`;
}

export const connectionString = getConnectionString();

/** Single shared storage instance — passed to Mastra (which calls init()), Harness, and Memory. */
export const storage = new PostgresStore({ id: 'coworker-storage', connectionString });
