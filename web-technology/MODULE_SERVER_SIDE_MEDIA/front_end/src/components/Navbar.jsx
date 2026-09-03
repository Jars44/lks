import { Link, useLocation } from 'react-router-dom'
import api from '../services/api'

export default function Navbar({ name, onLogout }) {
  const location = useLocation()
  const isAuth = !location.pathname.endsWith('/login') && !location.pathname.endsWith('/officer/login') && !location.pathname.endsWith('/validator/login')
  const handleLogout = async () => {
    try {
      const tok = localStorage.getItem('token')
      if (tok) await api.post('/auth/logout')
    } catch (e) {}
    localStorage.clear()
    if (onLogout) onLogout()
    window.location.href = '/XX_SERVER_MODULE/FRONTEND/login'
  }

  return (
    <nav className="navbar navbar-expand-md navbar-dark fixed-top bg-primary">
      <div className="container">
        <Link className="navbar-brand" to="/dashboard">Installment Cars</Link>
        <div className="collapse navbar-collapse">
          <ul className="navbar-nav ml-auto">
            {!isAuth && (
              <li className="nav-item"><Link className="nav-link" to="/login">Login</Link></li>
            )}
            {isAuth && (
              <>
                {name && <li className="nav-item"><span className="nav-link">{name}</span></li>}
                <li className="nav-item"><button type="button" className="nav-link btn btn-link" style={{ border: 0 }} onClick={handleLogout}>Logout</button></li>
              </>
            )}
          </ul>
        </div>
      </div>
    </nav>
  )
}