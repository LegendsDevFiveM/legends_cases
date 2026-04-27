/** @type {import('tailwindcss').Config} */
export default {
  content: [
    "./index.html",
    "./src/**/*.{js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {
      colors: {
        rarity: {
          milspec:    '#4b69ff',
          restricted: '#8847ff',
          classified: '#d32ce6',
          covert:     '#eb4b4b',
          gold:       '#ffd700',
        },
      },
      fontFamily: {
        sans: ['Inter', 'system-ui', '-apple-system', 'sans-serif'],
      },
      keyframes: {
        'win-pulse': {
          '0%, 100%': { transform: 'scale(1)', filter: 'brightness(1)' },
          '50%':      { transform: 'scale(1.06)', filter: 'brightness(1.3)' },
        },
        'fade-in': {
          '0%': { opacity: '0' },
          '100%': { opacity: '1' },
        },
        'rise-in': {
          '0%': { opacity: '0', transform: 'translateY(20px) scale(0.96)' },
          '100%': { opacity: '1', transform: 'translateY(0) scale(1)' },
        },
        'marker-glow': {
          '0%, 100%': { boxShadow: '0 0 12px rgba(255, 255, 255, 0.55), 0 0 28px rgba(235, 75, 75, 0.55)' },
          '50%':      { boxShadow: '0 0 18px rgba(255, 255, 255, 0.85), 0 0 44px rgba(235, 75, 75, 0.85)' },
        },
        'glow-pulse': {
          '0%, 100%': { opacity: '0.55', transform: 'scale(0.94)' },
          '50%':      { opacity: '1',    transform: 'scale(1.06)' },
        },
        'hint-pulse': {
          '0%, 100%': { opacity: '0.4' },
          '50%':      { opacity: '0.85' },
        },
      },
      animation: {
        'win-pulse':   'win-pulse 1.6s ease-in-out infinite',
        'fade-in':     'fade-in 0.25s ease-out',
        'rise-in':     'rise-in 0.45s cubic-bezier(0.16, 1, 0.3, 1)',
        'marker-glow': 'marker-glow 1.8s ease-in-out infinite',
        'glow-pulse':  'glow-pulse 2.2s ease-in-out infinite',
        'hint-pulse':  'hint-pulse 1.8s ease-in-out infinite',
      },
    },
  },
  plugins: [],
}
