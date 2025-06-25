import React from 'react';
import { Routes, Route, Navigate, useLocation } from 'react-router-dom';
import { AuthProvider, useAuth } from './context/AuthContext';
import Login from './pages/Login';
import Register from './pages/Register';
import Dashboard from './pages/Dashboard';
import LocationsPage from './pages/master-data/LocationsPage';
import DepartmentsPage from './pages/master-data/DepartmentsPage';
import AssetTypesPage from './pages/master-data/AssetTypesPage';
import VendorsPage from './pages/master-data/VendorsPage';
import EmployeesPage from './pages/master-data/EmployeesPage';
import AssetsPage from './pages/AssetsPage';
import TransferHistoryPage from './pages/TransferHistoryPage';
import DisposedPage from './pages/DisposedPage';
import SubLocationsPage from './pages/master-data/SubLocationsPage';
import SectionsPage from './pages/master-data/SectionsPage';
import AppLayout from './components/layout/AppLayout';

// Public route wrapper
const PublicRoute = ({ children }) => {
  const { user } = useAuth();
  return !user ? children : <Navigate to="/dashboard" replace />;
};

// Protected route wrapper with layout
const PrivateLayout = ({ children }) => {
  const { user, loading } = useAuth();
  const location = useLocation();

  if (loading) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <div className="animate-spin rounded-full h-12 w-12 border-t-2 border-b-2 border-blue-500"></div>
      </div>
    );
  }

  if (!user) {
    return <Navigate to="/login" state={{ from: location }} replace />;
  }

  return <AppLayout>{children}</AppLayout>;
};

const AppContent = () => (
  <Routes>
    {/* Public routes */}
    <Route
      path="/login"
      element={
        <PublicRoute>
          <Login />
        </PublicRoute>
      }
    />
    <Route
      path="/register"
      element={
        <PublicRoute>
          <Register />
        </PublicRoute>
      }
    />

    {/* Protected routes with layout */}
    <Route
      path="/"
      element={
        <PrivateLayout>
          <Navigate to="/dashboard" replace />
        </PrivateLayout>
      }
    />
    <Route
      path="/dashboard"
      element={
        <PrivateLayout>
          <Dashboard />
        </PrivateLayout>
      }
    />
    <Route
      path="/locations"
      element={
        <PrivateLayout>
          <LocationsPage />
        </PrivateLayout>
      }
    />
    <Route
      path="/departments"
      element={
        <PrivateLayout>
          <DepartmentsPage />
        </PrivateLayout>
      }
    />
    <Route
      path="/asset-types"
      element={
        <PrivateLayout>
          <AssetTypesPage />
        </PrivateLayout>
      }
    />
    <Route
      path="/vendors"
      element={
        <PrivateLayout>
          <VendorsPage />
        </PrivateLayout>
      }
    />
    <Route
      path="/employees"
      element={
        <PrivateLayout>
          <EmployeesPage />
        </PrivateLayout>
      }
    />
    <Route
      path="/assets"
      element={
        <PrivateLayout>
          <AssetsPage />
        </PrivateLayout>
      }
    />
    <Route
      path="/transfer-history"
      element={
        <PrivateLayout>
          <TransferHistoryPage />
        </PrivateLayout>
      }
    />
    <Route
      path="/disposed"
      element={
        <PrivateLayout>
          <DisposedPage />
        </PrivateLayout>
      }
    />
    <Route
      path="/sub-locations"
      element={
        <PrivateLayout>
          <SubLocationsPage />
        </PrivateLayout>
      }
    />
    <Route
      path="/sections"
      element={
        <PrivateLayout>
          <SectionsPage />
        </PrivateLayout>
      }
    />

    {/* 404 - Not Found */}
    <Route path="*" element={<Navigate to="/" replace />} />
  </Routes>
);

function App() {
  return (
    <AuthProvider>
      <AppContent />
    </AuthProvider>
  );
}

export default App;