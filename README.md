# Slickdeals Clone

A modern web application for sharing and discovering deals, discounts, and promotions. Built with the MERN stack (MongoDB, Express.js, React, Node.js).

## Features

- User authentication and authorization
- Post and share deals
- Like and comment on deals
- Save favorite deals
- User reputation system
- Responsive design

## Tech Stack

- Frontend: React.js
- Backend: Node.js, Express.js
- Database: MongoDB
- Authentication: JWT

## Prerequisites

- Node.js (v14 or higher)
- MongoDB
- npm or yarn

## Installation

1. Clone the repository:
```bash
git clone <repository-url>
cd slickdeals-clone
```

2. Install server dependencies:
```bash
npm install
```

3. Install client dependencies:
```bash
cd client
npm install
```

4. Create a .env file in the root directory and add:
```
MONGODB_URI=your_mongodb_connection_string
JWT_SECRET=your_jwt_secret
PORT=5000
```

5. Start the development server:
```bash
# Run backend only
npm run dev

# Run frontend only
npm run client

# Run both frontend and backend
npm run dev:full
```

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License. 