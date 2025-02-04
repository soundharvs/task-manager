# Task Manager API
A simple RESTful API for managing tasks with user authentication. Built with Ruby on Rails.

## Features
User registration and login with JWT-based authentication.

Create, read, update, and delete tasks.

Tasks are associated with users.

Pagination for listing tasks.

Validation for task fields (title, status, due_date).

Error handling with meaningful messages.

## Requirements
Ruby 3.3.4

Rails 8.0.0

SQLite

Bundler

## Setup
### 1. Clone the Repository

git clone https://github.com/your-username/task-manager-api.git

cd task-manager-api

### 2. Install Dependencies

Install the required gems:

bundle install

### 3. Set Up the Database

Create the database:

rails db:create

Run migrations:

rails db:migrate

### 4. Set Up Credentials

Generate the credentials.yml.enc file:

rails credentials:edit

Add the secret_key_base for JWT token generation:

secret_key_base: YOUR_SECRET_KEY_BASE

### 5. Start the Server

Run the Rails server:

rails s
