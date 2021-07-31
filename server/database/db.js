const { Pool } = require("pg");

const pool = new Pool({
  user: process.env.PGUSER,
  host: process.env.PGHOST,
  password: process.env.PGPASSWORD,
  port: process.env.PGPORT,
  database: process.env.DATABASE,
  connectionString: process.env.DATABASE_URL,
  ssl: {
    rejectUnauthorized: false
  }
})

const connectToDatabase = async () => {
  try {
    await pool.connect();

  } catch (err) {
    console.log(err);
  }
};

module.exports = {
  pool,
  connectToDatabase,
};
