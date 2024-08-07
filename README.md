Digital Empowerment Challenge
# Empowering Merchants Through Virtual Assistance

### Abstract
Currently, Grab has expanded its sales channels for food merchants, focusing on growth and scaling within specific channels. However, to better support merchants, Grab needs to establish a presence across all sales channels and ensure a consistent experience throughout. The DAFBA team has developed a solution to address these challenges.

The solution is based on Virtual Assistance with Gen AI backend. Furthermore, it uses NLP with machine learning model, fundamental meaning, knowledge graph and ranking and resolver engine.

### Project Description
The Dafba team proposes a solution to empower Grab's food merchants by integrating virtual assistance to provide consistent experiences across all sales channels. The solution leverages social media marketing, SEO, online listings, and email marketing to enhance merchant visibility both inside and outside the Grab ecosystem. Virtual assistance standardizes interactions, automates tasks, handles high volumes of requests, and supports personalization, ensuring uniform customer experiences. By joining the Grab ecosystem, merchants can utilize targeted marketing campaigns and promotional tools, while virtual assistance offers scalable, localized support, acting as an abstraction layer on top of Grab's functionalities to boost growth and customer recognition.

### Selected hackathon track
Digital Empowerment

### Technology  Stack 
- Kore.AI Bot Platform for Virtual Assistance
- Node.js for Backend API
- Docker
- Postgre DB with Postgis
- Digital Ocean Cloud (or any cloud)

![Grava Architecture](https://github.com/Ganuzaz/GraVA-Hackjakarta/blob/main/grava-arsitektur.png "Grava Architecture")

### Development Team
1. Fikri Ainul Yaqin
2. Davis Tannata
3. Achmad Amri
4. Medisa Aris Ginanjar

### Demo Link
You can try our demo at https://grab.dafba.com/
or
See our demo at https://www.youtube.com/watch?v=Bd4-gyH0gw8

### How to deploy
Backend
1. Create .env file based on .env.template
2. Run 'docker compose up -d'
3. Run the migration.sql file inside db/migration.sql

Virtual Assistance
1. Sign in on kore.ai
2. Import the VA data from the data inside "bot_data/GrabVA Hackjakarta.zip" on kore.ai Deploy -> App Management -> Import & Export (https://platform.kore.ai/builder/app/importexport)
