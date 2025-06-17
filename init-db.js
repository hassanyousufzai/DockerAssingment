db = db.getSiblingDB('taskmanager');

db.dockerCommand.insertMany([
  {
    command: "docker build",
    description: "Build an image",
    examples: [
      { example: "docker build -t myapp .", description: "Builds image from Dockerfile in current dir" }
    ]
  }
]);
