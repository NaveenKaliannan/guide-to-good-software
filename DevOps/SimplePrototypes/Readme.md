# REST API Prototype for Software, Hardware, and Software-Hardware Databases

This README provides examples of curl commands to interact with a REST API for managing software, hardware, and software-hardware databases. 
This REST API prototype provides a comprehensive set of endpoints for managing software, hardware, and software-hardware databases. 
It includes user management functionality with signup and signin capabilities for different types of users (software developers, hardware engineers, and full-stack developers). 
The API allows authenticated users to add software and hardware entries to their respective databases, each with unique identifiers, names, versions, and additional details. 
Users can also retrieve all databases. The API uses JSON for data exchange and implements token-based authentication for secure access to protected endpoints. 
It's designed to run on a local server (localhost:5000) and demonstrates the use of HTTP methods (POST and GET) for various operations, making it a suitable prototype for testing and development purposes

### User Management

#### Sign Up

##### Software Developer

```bash
curl -X POST http://localhost:5000/api/signup -H "Content-Type: application/json" -d '{
  "first_name": "Alice",
  "last_name": "Smith",
  "email": "alice@example.com",
  "password": "password123",
  "dob": "1990-01-01",
  "expertise": "Software Development",
  "experience": 5,
  "department": "software"
}'
```

#####  Hardware Engineer
```bash
curl -X POST http://localhost:5000/api/signup -H "Content-Type: application/json" -d '{
  "first_name": "Bob",
  "last_name": "Johnson",
  "email": "bob@example.com",
  "password": "password123",
  "dob": "1985-05-05",
  "expertise": "Hardware Engineering",
  "experience": 7,
  "department": "hardware"
}'
```

##### Full Stack Developer
```bash
curl -X POST http://localhost:5000/api/signup -H "Content-Type: application/json" -d '{
  "first_name": "Charlie",
  "last_name": "Brown",
  "email": "charlie@example.com",
  "password": "password123",
  "dob": "1992-03-03",
  "expertise": "Full Stack Development",
  "experience": 4,
  "department": "software-hardware"
}'
```

#### Sign In
##### Sign In for Alice
```bash
curl -X POST http://localhost:5000/api/signin -H "Content-Type: application/json" -d '{
  "email": "alice@example.com",
  "password": "password123"
}'
```

##### Sign In for Bob
```bash
curl -X POST http://localhost:5000/api/signin -H "Content-Type: application/json" -d '{
  "email": "bob@example.com",
  "password": "password123"
}'
```

##### Sign In for Charlie
```bash
curl -X POST http://localhost:5000/api/signin -H "Content-Type: application/json" -d '{
  "email": "charlie@example.com",
  "password": "password123"
}'
```
##### Quick Sign Up and Sign In
This command combines sign up and sign in for a new user:
```bash
curl -X POST http://localhost:5000/api/signup -H "Content-Type: application/json" -d '{
  "first_name": "Charlie",
  "last_name": "Brown",
  "email": "charlie@example.com",
  "password": "password123",
  "dob": “1992-03-03”,
  “expertise”: “Full Stack Development”,
   “experience”:4,
   “department”:“software-hardware”
}' ; 
curl -X POST http://localhost:5000/api/signin -H “Content-Type: application/json” -d ‘{
   “email”: “charlie@example.com”,
   “password”: “password123”
}’
```

#### Database Management
##### Add Software Entry
```bash
curl -X POST http://localhost:5000/api/software -H "Authorization: Bearer YOUR_TOKEN_HERE" -H "Content-Type: application/json" -d '{
  "unique_id": "your_unique_id",
  "name": "Software Name",
  "version": "1.0",
  "description": "Description of the software"
}'
```

##### Add Hardware Entry
```bash
curl -X POST http://localhost:5000/api/hardware -H "Authorization: Bearer YOUR_TOKEN_HERE" -H "Content-Type: application/json" -d '{
  "name": "HardwareName",
  "specifications": "HardwareSpecifications",
  "unique_id": "unique123",
  "version": "1.0"
}'
```

#### Get All Databases
```bash
curl -X GET http://localhost:5000/api/databases -H "Authorization: Bearer YOUR_TOKEN_HERE"
```

