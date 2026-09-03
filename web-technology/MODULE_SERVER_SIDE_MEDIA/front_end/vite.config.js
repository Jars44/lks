import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

// Build the React app so it can be reached at <host>/XX_SERVER_MODULE/FRONTEND/
// (a subpath, no port, no /public suffix per spec). Update base when packing.
export default defineConfig({
  base: '/XX_SERVER_MODULE/FRONTEND/',
  plugins: [react()],
  server: {
    proxy: {
      '/api': {
        target: 'http://localhost:8000',
        changeOrigin: true,
      },
    },
  },
})