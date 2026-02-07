/** @type {import('tailwindcss').Config} */
export default {
  content: [
    "./index.html",
    "./src/**/*.{js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {
      colors: {
        ubBlack: '#000000',
        ubViolet: '#7D39EB',
        ubLime: '#C6FF33',
        ubWhite: '#FFFFFF',
        ubDarkGrey: '#121212',
        ubSurface: '#1E1E1E',
      },
      fontFamily: {
        sans: ['Inter', 'sans-serif'],
      },
       animation: {
        'spin-slow': 'spin 10s linear infinite',
        'pulse-slow': 'pulse 3s cubic-bezier(0.4, 0, 0.6, 1) infinite',
        'float': 'float 6s ease-in-out infinite',
        'marquee': 'marquee 25s linear infinite',
        'gradient-x': 'gradient-x 15s ease infinite',
      },
      keyframes: {
        float: {
          '0%, 100%': { transform: 'translateY(0)' },
          '50%': { transform: 'translateY(-20px)' },
        },
        marquee: {
          '0%': { transform: 'translateX(0%)' },
          '100%': { transform: 'translateX(-100%)' },
        },
        'gradient-x': {
          '0%, 100%': {
             'background-size': '200% 200%',
             'background-position': 'left center'
          },
          '50%': {
             'background-size': '200% 200%',
             'background-position': 'right center'
          },
        }
      }
    },
  },
  plugins: [],
}
