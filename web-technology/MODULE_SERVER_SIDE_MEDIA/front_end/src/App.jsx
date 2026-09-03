import { Routes, Route, Navigate } from 'react-router-dom'
import { ToastProvider } from './components/Toast.jsx'
import Login from './pages/Login.jsx'
import Dashboard from './pages/Dashboard.jsx'
import RequestValidation from './pages/RequestValidation.jsx'
import CarList from './pages/CarList.jsx'
import CarDetail from './pages/CarDetail.jsx'
import OfficerLogin from './pages/officer/OfficerLogin.jsx'
import OfficerDashboard from './pages/officer/OfficerDashboard.jsx'
import ValidatorLogin from './pages/validator/ValidatorLogin.jsx'
import ValidatorDashboard from './pages/validator/ValidatorDashboard.jsx'

function RequireToken({ children }) {
  const t = localStorage.getItem('token')
  if (!t) return <Navigate to="/login" replace />
  return children
}

export default function App() {
  return (
    <ToastProvider>
      <Routes>
        <Route path="/" element={<Navigate to="/login" replace />} />
        <Route path="/login" element={<Login />} />
        <Route path="/dashboard" element={<RequireToken><Dashboard /></RequireToken>} />
        <Route path="/data-validation" element={<RequireToken><RequestValidation /></RequireToken>} />
        <Route path="/instalments" element={<RequireToken><CarList /></RequireToken>} />
        <Route path="/instalments/:id" element={<RequireToken><CarDetail /></RequireToken>} />

        <Route path="/officer/login" element={<OfficerLogin />} />
        <Route path="/officer/dashboard" element={<OfficerDashboard />} />
        <Route path="/officer/*" element={<OfficerDashboard />} />

        <Route path="/validator/login" element={<ValidatorLogin />} />
        <Route path="/validator/*" element={<ValidatorDashboard />} />

        <Route path="*" element={<Navigate to="/login" replace />} />
      </Routes>
    </ToastProvider>
  )
}