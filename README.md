┌────────────────────┐       docker network        ┌────────────────────────┐
│  Node.js App       │◀──────────────────────────▶│     MongoDB (Seeded)   │
│  (Port 3000)       │                            │  Custom Image w/ Init   │
│  Container: nodeapp│                            │  Container: mongodb     │
└────────────────────┘                            └──────────────────────── ┘
        │                                                 ▲
        │ logs                                            │
        ▼                                                 │
   Host Volume: ./logs                          Volume: mongo-data



docker network create nodeapp-network

docker volume create mongo-data

docker build -f mongo.dockerfile -t mongo-seed .

docker run -d ^
  --name mongodb ^
  --network nodeapp-network ^
  -v mongo-data:/data/db ^
  mongo-seed

docker build -f node.dockerfile -t nodeapp .

docker run -d ^
  --name nodeapp ^
  --network nodeapp-network ^
  -p 3000:3000 ^
  -v ${PWD}\logs:/var/www/logs ^
  -e NODE_ENV=production ^
  -e APP_VERSION=1.0 ^
  nodeapp


docker ps

Open your browser and go to:
http://localhost:3000

