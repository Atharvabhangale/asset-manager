import React from 'react';
import { Link, useLocation } from 'react-router-dom';
import { useAuth } from '../../context/AuthContext';
import { 
  FiHome, 
  FiMapPin, 
  FiUsers, 
  FiTruck, 
  FiLayers, 
  FiPackage,
  FiRepeat,
  FiTrash2,
  FiSettings,
  FiChevronDown,
  FiChevronRight
} from 'react-icons/fi';

const menuItems = [
  {
    title: 'Dashboard',
    path: '/dashboard',
    icon: <FiHome className="h-5 w-5" />,
  },
  {
    title: 'Master Data',
    icon: <FiSettings className="h-5 w-5" />,
    children: [
      {
        title: 'Locations',
        path: '/locations',
        icon: <FiMapPin className="h-5 w-5" />,
      },
      {
        title: 'Sub-Locations',
        path: '/sub-locations',
        icon: <FiMapPin className="h-5 w-5" />,
      },
      {
        title: 'Departments',
        path: '/departments',
        icon: <FiUsers className="h-5 w-5" />,
      },
      {
        title: 'Sections',
        path: '/sections',
        icon: <FiLayers className="h-5 w-5" />,
      },
      {
        title: 'Employees',
        path: '/employees',
        icon: <FiUsers className="h-5 w-5" />,
      },
      {
        title: 'Vendors',
        path: '/vendors',
        icon: <FiTruck className="h-5 w-5" />,
      },
      {
        title: 'Asset Types',
        path: '/asset-types',
        icon: <FiLayers className="h-5 w-5" />,
      },
    ],
  },
  {
    title: 'Manage Assets',
    icon: <FiPackage className="h-5 w-5" />,
    children: [
      {
        title: 'Assets',
        path: '/assets',
        icon: <FiPackage className="h-5 w-5" />,
      },
      {
        title: 'Transfer History',
        path: '/transfer-history',
        icon: <FiRepeat className="h-5 w-5" />,
      },
      {
        title: 'Disposed',
        path: '/disposed',
        icon: <FiTrash2 className="h-5 w-5" />,
      }
    ],
  }
];

const SidebarItem = ({ item, isActive, onClick, isChild = false }) => {
  const hasChildren = item.children && item.children.length > 0;
  const [isOpen, setIsOpen] = React.useState(false);

  // If item has a path and no children, render a Link
  if (item.path && !hasChildren) {
    return (
      <Link
        to={item.path}
        onClick={onClick}
        className={`flex items-center justify-between px-4 py-3 text-sm font-medium rounded-md transition-colors ${
          isActive ? 'bg-blue-50 text-blue-700' : 'text-gray-600 hover:bg-gray-50'
        } ${isChild ? 'pl-10' : ''}`}
      >
        <div className="flex items-center">
          <span className="mr-3">{item.icon}</span>
          {item.title}
        </div>
      </Link>
    );
  }

  // Otherwise, render expandable/collapsible parent
  return (
    <div>
      <div
        onClick={() => {
          if (hasChildren) {
            setIsOpen(!isOpen);
          }
        }}
        className={`flex items-center justify-between px-4 py-3 text-sm font-medium rounded-md cursor-pointer transition-colors ${
          isActive && !hasChildren ? 'bg-blue-50 text-blue-700' : 'text-gray-600 hover:bg-gray-50'
        } ${isChild ? 'pl-10' : ''}`}
      >
        <div className="flex items-center">
          <span className="mr-3">{item.icon}</span>
          {item.title}
        </div>
        {hasChildren && (
          <span className="text-gray-400">
            {isOpen ? <FiChevronDown className="h-4 w-4" /> : <FiChevronRight className="h-4 w-4" />}
          </span>
        )}
      </div>
      {hasChildren && isOpen && (
        <div className="mt-1 space-y-1">
          {item.children.map((child) => (
            <SidebarItem
              key={child.path}
              item={child}
              isActive={window.location.pathname === child.path}
              onClick={onClick}
              isChild
            />
          ))}
        </div>
      )}
    </div>
  );
};

const AppLayout = ({ children }) => {
  const location = useLocation();
  const { user, profile, signOut } = useAuth();
  const [mobileMenuOpen, setMobileMenuOpen] = React.useState(false);

  const isActive = (path) => location.pathname === path;

  return (
    <div className="min-h-screen bg-gray-50 flex">
      {/* Mobile menu button */}
      <div className="lg:hidden">
        <button
          onClick={() => setMobileMenuOpen(!mobileMenuOpen)}
          className="fixed top-4 left-4 z-50 p-2 rounded-md text-gray-500 hover:text-gray-600 hover:bg-gray-100 focus:outline-none focus:ring-2 focus:ring-inset focus:ring-blue-500"
        >
          <span className="sr-only">Open sidebar</span>
          <svg
            className="h-6 w-6"
            fill="none"
            viewBox="0 0 24 24"
            stroke="currentColor"
            aria-hidden="true"
          >
            <path
              strokeLinecap="round"
              strokeLinejoin="round"
              strokeWidth={2}
              d="M4 6h16M4 12h16M4 18h16"
            />
          </svg>
        </button>
      </div>

      {/* Sidebar */}
<div
  className={`fixed inset-y-0 left-0 z-40 w-64 bg-white shadow-lg transform ${
    mobileMenuOpen ? 'translate-x-0' : '-translate-x-full'
  } lg:translate-x-0 transition-transform duration-200 ease-in-out`}
>
  <div className="flex items-center justify-center h-16 px-4 border-b border-gray-200">
    <h1 className="text-xl font-bold text-gray-900">Exide</h1>
  </div>
  <nav className="px-2 py-4 space-y-1">
    {menuItems.map((item) => (
      <SidebarItem
        key={item.path || item.title}
        item={item}
        isActive={isActive(item.path) || item.children?.some((child) => isActive(child.path))}
        onClick={() => setMobileMenuOpen(false)}
      />
    ))}
    {/* Admin-only link for Permissions */}
    <div className="mt-4 px-4 py-2">
      {profile?.role === 'admin' && (
        <Link
          to="/permissions"
          onClick={() => setMobileMenuOpen(false)}
          className="mt-2 flex items-center px-4 py-2 text-sm font-medium rounded-md transition-colors bg-blue-100 text-blue-700 hover:bg-blue-200"
        >
          <span className="mr-2">
            <FiSettings className="h-4 w-4" />
          </span>
          Permissions (Admin)
        </Link>
      )}
      {/* Nothing is rendered for non-admins */}
    </div>
  </nav>
</div>


      {/* Main content */}
      <div className="flex-1 flex flex-col lg:pl-64">
        {/* Top navigation */}
        <header className="bg-white shadow-sm">
          <div className="px-4 sm:px-6 lg:px-8 py-3 flex justify-between items-center">
            <div className="flex-1">
              <h1 className="text-xl font-semibold text-gray-900">
                It Asset Manager
              </h1>
            </div>
            <div className="flex items-center space-x-4">
              <div className="relative">
                <button className="p-1 rounded-full text-gray-400 hover:text-gray-500 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500">
                  <span className="sr-only">View notifications</span>
                  <svg
                    className="h-6 w-6"
                    fill="none"
                    viewBox="0 0 24 24"
                    stroke="currentColor"
                  >
                    <path
                      strokeLinecap="round"
                      strokeLinejoin="round"
                      strokeWidth={2}
                      d="M15 17h5l-1.405-1.405A2.032 2.032 0 0118 14.158V11a6.002 6.002 0 00-4-5.659V5a2 2 0 10-4 0v.341C7.67 6.165 6 8.388 6 11v3.159c0 .538-.214 1.055-.595 1.436L4 17h5m6 0v1a3 3 0 11-6 0v-1m6 0H9"
                    />
                  </svg>
                </button>
              </div>
              <div className="relative">
                <div className="flex items-center">
                  <div className="ml-3">
                    <div className="text-sm font-medium text-gray-700">{user?.email}</div>
                    <div className="text-xs text-gray-500">
                      {user?.user_metadata?.role || 'User'}
                    </div>
                  </div>
                  <button
                    onClick={signOut}
                    className="ml-4 inline-flex items-center px-3 py-1.5 border border-transparent text-xs font-medium rounded-md shadow-sm text-white bg-red-600 hover:bg-red-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-red-500"
                  >
                    Sign out
                  </button>
                </div>
              </div>
            </div>
          </div>
        </header>

        {/* Page content */}
        <main className="flex-1">
          <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-6">
            {children}
          </div>
        </main>
      </div>
    </div>
  );
};

export default AppLayout;
