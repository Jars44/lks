import { StrictMode } from 'react'
import { createRoot } from 'react-dom/client'
import { BrowserRouter } from 'react-router-dom'
import App from './App.jsx'
import './assets/bootstrap.css'
import './assets/custom.css'
import './styles.css'

createRoot(document.getElementById('root')).render(
  <StrictMode>
    <BrowserRouter basename="/XX_SERVER_MODULE/FRONTEND">
      <App />
    </BrowserRouter>
  </StrictMode>,
)