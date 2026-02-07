import React, { useEffect, useState } from 'react';
import { motion, AnimatePresence } from 'framer-motion';

const SplashScreen = ({ onComplete }) => {
  const [show, setShow] = useState(true);
  const [refreshMessage, setRefreshMessage] = useState(null);

  useEffect(() => {
    const msg = localStorage.getItem('refresh_message');
    if (msg) {
      setRefreshMessage(msg);
      // If it's a status refresh, make it slightly faster
      const timer = setTimeout(() => {
        setShow(false);
        setTimeout(() => {
          localStorage.removeItem('refresh_message');
          onComplete();
        }, 500);
      }, 2000);
      return () => clearTimeout(timer);
    } else {
      const timer = setTimeout(() => {
        setShow(false);
        setTimeout(() => onComplete(), 500);
      }, 3000);
      return () => clearTimeout(timer);
    }
  }, [onComplete]);

  return (
    <AnimatePresence>
      {show && (
        <motion.div
          className="fixed inset-0 z-50 flex items-center justify-center bg-ubBlack"
          exit={{ opacity: 0 }}
          transition={{ duration: 0.5 }}
        >
          {/* Background Particles */}
          <div className="absolute inset-0 overflow-hidden">
            {[...Array(6)].map((_, i) => (
              <motion.div
                key={i}
                className={`absolute ${refreshMessage ? 'bg-ubViolet' : 'bg-ubLime'} rounded-full opacity-20 blur-xl`}
                initial={{
                  x: Math.random() * window.innerWidth,
                  y: Math.random() * window.innerHeight,
                  scale: 0.5,
                }}
                animate={{
                  y: [null, Math.random() * -100],
                  opacity: [0.2, 0.5, 0.2],
                }}
                transition={{
                  duration: 2 + Math.random() * 2,
                  repeat: Infinity,
                  ease: "easeInOut"
                }}
                style={{
                  width: Math.random() * 100 + 50,
                  height: Math.random() * 100 + 50,
                }}
              />
            ))}
          </div>

          <div className="relative text-center px-6">
            <motion.div
              initial={{ opacity: 0, scale: 0.8 }}
              animate={{ opacity: 1, scale: 1 }}
              transition={{ duration: 0.8, ease: "easeOut" }}
              className="mb-4"
            >
              {refreshMessage ? (
                <h1 className="text-4xl md:text-5xl font-black tracking-tight text-white drop-shadow-[0_0_20px_rgba(198,255,51,0.4)]">
                  {refreshMessage}
                </h1>
              ) : (
                <h1 className="text-6xl font-bold tracking-tighter text-transparent bg-clip-text bg-gradient-to-r from-ubViolet via-white to-ubLime drop-shadow-[0_0_15px_rgba(125,57,235,0.5)]">
                  UniBuzz
                </h1>
              )}
            </motion.div>
            
            <motion.div
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ delay: 0.5, duration: 0.8 }}
              className="text-ubWhite/70 font-light tracking-widest text-sm uppercase"
            >
              {refreshMessage ? 'Status Engine Syncing...' : 'Unified Campus Events Fabric'}
            </motion.div>

            <motion.div
              className="mt-8 h-1 w-32 mx-auto bg-gray-800 rounded-full overflow-hidden"
              initial={{ opacity: 0 }}
              animate={{ opacity: 1 }}
              transition={{ delay: 0.8 }}
            >
              <motion.div
                className={`h-full ${refreshMessage ? 'bg-ubViolet' : 'bg-ubLime'}`}
                initial={{ width: "0%" }}
                animate={{ width: "100%" }}
                transition={{ delay: 0.8, duration: refreshMessage ? 1.2 : 2, ease: "easeInOut" }}
              />
            </motion.div>
          </div>
        </motion.div>
      )}
    </AnimatePresence>
  );
};

export default SplashScreen;
