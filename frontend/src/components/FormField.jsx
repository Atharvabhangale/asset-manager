import React from 'react';
import { useField } from 'formik';

export const FormField = ({ label, children, as, ...props }) => {
  const [field, meta] = useField(props);
  const hasError = meta.touched && meta.error;
  
  const baseClasses = 'shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline';
  const errorClasses = hasError ? 'border-red-500' : '';
  const inputClasses = `${baseClasses} ${errorClasses}`;
  
  // Handle different input types
  if (as === 'select') {
    return (
      <div className="mb-4">
        {label && (
          <label className="block text-gray-700 text-sm font-bold mb-2" htmlFor={props.id || props.name}>
            {label}
          </label>
        )}
        <select
          className={inputClasses}
          {...field}
          {...props}
        >
          {children}
        </select>
        {hasError && (
          <p className="text-red-500 text-xs italic mt-1">{meta.error}</p>
        )}
      </div>
    );
  }
  
  if (as === 'textarea') {
    return (
      <div className="mb-4">
        {label && (
          <label className="block text-gray-700 text-sm font-bold mb-2" htmlFor={props.id || props.name}>
            {label}
          </label>
        )}
        <textarea
          className={inputClasses}
          rows={props.rows || 3}
          {...field}
          {...props}
        />
        {hasError && (
          <p className="text-red-500 text-xs italic mt-1">{meta.error}</p>
        )}
      </div>
    );
  }

  // Default to input
  return (
    <div className="mb-4">
      {label && (
        <label className="block text-gray-700 text-sm font-bold mb-2" htmlFor={props.id || props.name}>
          {label}
        </label>
      )}
      <input
        className={inputClasses}
        {...field}
        {...props}
      />
      {hasError && (
        <p className="text-red-500 text-xs italic mt-1">{meta.error}</p>
      )}
    </div>
  );
};
