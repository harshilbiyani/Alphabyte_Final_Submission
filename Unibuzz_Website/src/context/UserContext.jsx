import React, { createContext, useState, useContext } from 'react';

const UserContext = createContext();

export const UserProvider = ({ children }) => {
  // Initialize from localStorage if available
  const [currentUser, setCurrentUser] = useState(() => {
    const savedUser = localStorage.getItem('currentUser');
    return savedUser ? JSON.parse(savedUser) : null;
  });
  
  const [isAuthenticated, setIsAuthenticated] = useState(() => {
    return !!localStorage.getItem('currentUser');
  });

  const [listings, setListings] = useState([]);
  const [events, setEvents] = useState(() => {
    const savedEvents = localStorage.getItem('userEvents');
    return savedEvents ? JSON.parse(savedEvents) : [];
  });

  const login = (userData) => {
    setCurrentUser(userData);
    setIsAuthenticated(true);
    localStorage.setItem('currentUser', JSON.stringify(userData));
  };

  const logout = () => {
    setCurrentUser(null);
    setIsAuthenticated(false);
    setListings([]);
    setEvents([]);
    localStorage.removeItem('currentUser');
    localStorage.removeItem('userEvents');
  };

  const addListing = (listing) => {
    setListings(prev => [listing, ...prev]);
  };

  const addEvent = (event) => {
    const updatedEvents = [event, ...events];
    setEvents(updatedEvents);
    localStorage.setItem('userEvents', JSON.stringify(updatedEvents));
  };

  const updateEventStatus = (eventId, status) => {
    const updatedEvents = events.map(ev => 
      ev.id === eventId ? { ...ev, status } : ev
    );
    setEvents(updatedEvents);
    localStorage.setItem('userEvents', JSON.stringify(updatedEvents));
  };

  const deleteEvent = (eventId) => {
    const updatedEvents = events.filter(ev => ev.id !== eventId);
    setEvents(updatedEvents);
    localStorage.setItem('userEvents', JSON.stringify(updatedEvents));
  };

  return (
    <UserContext.Provider value={{ 
      currentUser, 
      isAuthenticated, 
      login, 
      logout, 
      listings, 
      addListing,
      events,
      addEvent,
      updateEventStatus,
      deleteEvent
    }}>
      {children}
    </UserContext.Provider>
  );
};

export const useUser = () => {
  const context = useContext(UserContext);
  if (!context) {
    throw new Error('useUser must be used within a UserProvider');
  }
  return context;
};
