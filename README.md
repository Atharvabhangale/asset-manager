# Exide IT Asset Manager

A comprehensive IT Asset Management System built with React.js and Supabase, designed to help organizations track and manage their IT assets efficiently.

## Features

### Asset Management
- Track IT assets with detailed information (make, model, serial number, status)
- Asset status tracking (In Stock, Assigned, In Maintenance, Retired)
- Asset assignment to employees
- Asset transfer history
- Search and filter assets

### Master Data Management
- Locations management
- Departments management
- Employee directory
- Vendor management
- Asset types/categories

### Transfer Management
- Track asset transfers between employees, departments, and locations
- View complete transfer history
- Filter transfers by date, asset, employee, department, or location

### User Management
- Role-based access control (Admin, Manager, Employee)
- Secure authentication with Supabase Auth
- User registration and profile management

### Dashboard
- Quick overview of asset status
- Recent activities
- Asset distribution by status

## Tech Stack

### Frontend
- React.js
- React Router for navigation
- Tailwind CSS for styling
- Formik & Yup for form handling and validation
- React Icons

### Backend & Database
- Supabase (PostgreSQL)
- Supabase Auth for authentication
- Row Level Security (RLS) for data protection

## Prerequisites

- Node.js (v14 or later)
- npm or yarn
- Supabase account

## Getting Started

### 1. Clone the repository

```bash
git clone <repository-url>
cd asset-manager
```

### 2. Set up Supabase

1. Create a new project in [Supabase](https://supabase.com/)
2. Run the SQL scripts from the `supabase/` directory to set up your database schema
3. Enable Row Level Security (RLS) on all tables
4. Set up authentication providers in Supabase Dashboard

### 3. Configure Environment Variables

Create a `.env` file in the `frontend` directory with the following variables:

```env
REACT_APP_SUPABASE_URL=your_supabase_url
REACT_APP_SUPABASE_ANON_KEY=your_supabase_anon_key
```

### 4. Install Dependencies

```bash
cd frontend
npm install
# or
yarn install
```

### 5. Start the Development Server

```bash
npm start
# or
yarn start
```

The application will be available at `http://localhost:3000`

## Available Scripts

In the project directory, you can run:

- `npm start` - Runs the app in development mode
- `npm test` - Launches the test runner
- `npm run build` - Builds the app for production
- `npm run eject` - Ejects from Create React App (use with caution)

## Project Structure

```
asset-manager/
├── frontend/                 # Frontend React application
│   ├── public/               # Static files
│   └── src/                  # Source files
│       ├── components/       # Reusable UI components
│       ├── hooks/            # Custom React hooks
│       ├── pages/            # Page components
│       ├── App.jsx           # Main App component
│       └── index.js          # Application entry point
└── supabase/                 # Database schema and seed data
    ├── schema.sql           # Database schema
    └── seed.sql            # Sample data
```

## Deployment

### Building for Production

```bash
cd frontend
npm run build
```

This will create a `build` directory with the production build of your app.

### Deployment Options

1. **Vercel** (Recommended)
   - Connect your GitHub repository
   - Set up environment variables
   - Deploy!

2. **Netlify**
   - Drag and drop the `build` folder to Netlify
   - Or connect your GitHub repository

3. **Static Hosting**
   - The build folder is ready to be deployed as static files

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## Recent Updates

### July 2025
- **Hostname field** added to Assets table and UI (CRUD + filters + reports).
- Cascading filters on Assets & Reports pages:
  - Location → Sub-Location
  - Department → Section
  - Make → Model
- New **Disposed Assets** section and report.
- Transfer History report with advanced filters and CSV export.
- Sections & Sub-Locations master-data CRUD pages added.
- `useDepartments` hook restored; all master-data hooks follow identical pattern.
- Supabase auth trigger functions now set `username` (part before `@`) in `profiles` table and keep it in sync.
- Local development now defaults to `http://127.0.0.1:54321` Supabase dev stack; update `frontend/src/supabaseClient.js` if you use a remote project.

---

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support

For support, please open an issue in the GitHub repository.
# asset-manager
