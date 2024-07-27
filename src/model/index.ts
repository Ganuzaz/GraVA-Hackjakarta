import { Sequelize } from 'sequelize-typescript';
import path from 'path';


const sequelize = new Sequelize({
  dialect: 'postgres',
  host: process.env.POSTGRES_HOST,
  port: parseInt(process.env.POSTGRES_PORT || '5432', 10),
  username: process.env.POSTGRES_USER,
  password: process.env.POSTGRES_PASSWORD,
  database: process.env.POSTGRES_DB,
  models: [path.join(__dirname, "/*.model.*")], // path to your models
  modelMatch: (filename, member) => {
    const tempFile = filename
      .substring(0, filename.indexOf(".model"))
      .replaceAll("-", "")
      .toLowerCase();
    return tempFile === member.toLowerCase();
  },
});

sequelize.authenticate()
  .then(() => {
    console.log('Connection has been established successfully.');
  })
  .catch((err: Error) => {
    console.error('Unable to connect to the database:', err);
  });

export default sequelize;
