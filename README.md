# Newsletter Subscriber Management System

A full-stack application for managing newsletter subscribers with a Rails API backend and React frontend. This system allows you to add, view, and update subscriber statuses with proper validation and pagination.

## Technology Stack

**Backend**
- Ruby 3.1.2
- Rails 6.1 (API mode)
- PostgreSQL database
- RSpec for testing

**Frontend**
- React 17
- Tailwind CSS for styling
- Yarn for package management

## Development Setup

### Prerequisites
- Docker and Docker Compose
- Git

### Getting Started

1. Clone the repository
   ```
   git clone https://github.com/Neeharika019/NK_Beehiiv_Challenge.git
   cd NK_Beehiiv_Challenge
   ```

2. Start the application using Docker
   ```
   docker-compose up --build
   ```

3. The application will be available at http://localhost:3000

### Environment Variables

The application uses the following environment variables:
- `BASIC_AUTH_USERNAME` - Username for basic authentication (default: admin)
- `BASIC_AUTH_PASSWORD` - Password for basic authentication (default: secret123)
- `DATABASE_URL` - PostgreSQL connection string

## Features

**Subscriber Management**
- Add new subscribers with name and email
- View all subscribers with server-side pagination
- Update subscriber status (active/inactive)
- Email validation and normalization
- Case-insensitive email uniqueness

**Data Validation**
- Email addresses are normalized (lowercase, trimmed)
- Duplicate emails are prevented
- Status must be either 'active' or 'inactive'
- Proper error handling and user feedback

**User Interface**
- Clean, responsive design
- Modal forms for adding and updating subscribers
- Real-time status updates
- Pagination controls
- Error notifications

## API Endpoints

- `GET /api/subscribers` - List subscribers with pagination
- `POST /api/subscribers` - Create a new subscriber
- `PATCH /api/subscribers/:id` - Update subscriber status

## Testing

Run the test suite:
```
docker-compose exec web bundle exec rspec
```

The test suite covers:
- Model validations and callbacks
- Controller actions and error handling
- Email normalization and uniqueness
- API response formats

## Database Schema

The application uses a single `subscribers` table with:
- `id` - Primary key
- `name` - Optional subscriber name
- `email` - Required, unique email address
- `status` - Subscriber status (active/inactive)
- `created_at` and `updated_at` - Timestamps

## Deployment

This application is configured for deployment on Render. The Docker setup makes it easy to deploy to Render's container-based platform. Simply connect your GitHub repository to Render and it will automatically build and deploy your application.

## Authentication

Basic authentication is implemented using environment variables. The default credentials are admin/secret123 but should be changed in production using environment variables.
