import React from 'react';
import { FiLoader } from 'react-icons/fi';

const Button = ({
  children,
  variant = 'primary',
  size = 'md',
  type = 'button',
  onClick,
  disabled = false,
  loading = false,
  className = '',
  icon: Icon,
  ...props
}) => {
  // Base button classes
  const baseClasses = 'inline-flex items-center justify-center font-medium rounded-md focus:outline-none focus:ring-2 focus:ring-offset-2 transition-colors';
  
  // Variant classes
  const variants = {
    primary: 'text-white bg-blue-600 hover:bg-blue-700 focus:ring-blue-500',
    secondary: 'text-gray-700 bg-white border border-gray-300 hover:bg-gray-50 focus:ring-blue-500',
    danger: 'text-white bg-red-600 hover:bg-red-700 focus:ring-red-500',
    success: 'text-white bg-green-600 hover:bg-green-700 focus:ring-green-500',
    ghost: 'text-gray-700 hover:bg-gray-100 focus:ring-gray-200',
  };

  // Size classes
  const sizes = {
    sm: 'px-3 py-1.5 text-xs',
    md: 'px-4 py-2 text-sm',
    lg: 'px-6 py-3 text-base',
  };

  // Disabled state
  const disabledClasses = disabled || loading ? 'opacity-50 cursor-not-allowed' : '';

  // Combine all classes
  const buttonClasses = `
    ${baseClasses}
    ${variants[variant] || variants.primary}
    ${sizes[size] || sizes.md}
    ${disabledClasses}
    ${className}
  `.replace(/\s+/g, ' ').trim();

  // Render icon if provided
  const renderIcon = () => {
    if (loading) {
      return <FiLoader className={`animate-spin ${children ? 'mr-2' : ''}`} />;
    }

    if (!Icon) return null;

    // If icon is passed as a React element (<FiPlus />)
    if (React.isValidElement(Icon)) {
      return React.cloneElement(Icon, {
        className: `${Icon.props.className || ''} ${children ? 'mr-2' : ''}`.trim(),
      });
    }

    // If icon is a component reference (FiPlus)
    if (typeof Icon === 'function') {
      const IconComponent = Icon;
      return <IconComponent className={`${children ? 'mr-2' : ''}`} />;
    }

    return null;
  };

  return (
    <button
      type={type}
      className={buttonClasses}
      onClick={onClick}
      disabled={disabled || loading}
      {...props}
    >
      {renderIcon()}
      {children}
    </button>
  );
};

export default Button;
