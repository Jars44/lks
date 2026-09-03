import { useState } from 'react'
import { useNavigate } from 'react-router-dom'
import api from '../../services/api'
import { useToast } from '../../components/Toast.jsx'
import Navbar from '../../components/Navbar.jsx'

export default function ValidatorLogin() {
  const [username, setUsername] = useState('')
  const [password, setPassword] = useState('')
  const [loading, setLoading] = useState(false)
  const nav = useNavigate()
  const toast = useToast()

  const handleSubmit = async (e) => {
    e.preventDefault()
    setLoading(true)
    try {
      const r = await api.post('/validator/login', { username, password })
      localStorage.setItem('token', r.data.token)
      localStorage.setItem('name', r.data.name)
      localStorage.setItem('role', 'validator')
      toast.push('Login success', 'success')
      nav('/validator/dashboard')
    } catch (err) {
      toast.push(err.response?.data?.message || 'Login failed', 'error')
    } finally {
      setLoading(false)
    }
  }

  return (
    <>
      <Navbar />
      <main>
        <header className="jumbotron"><div className="container text-center"><h1 className="display-4">Validator Platform</h1></div></header>
        <div className="container">
          <div className="row justify-content-center">
            <div className="col-md-6">
              <form className="card card-default" onSubmit={handleSubmit}>
                <div className="card-header"><h4 className="mb-0">Validator Login</h4></div>
                <div className="card-body">
                  <div className="form-group row align-items-center">
                    <div className="col-4 text-right">Username</div>
                    <div className="col-8"><input type="text" className="form-control" value={username} onChange={(e) => setUsername(e.target.value)} required /></div>
                  </div>
                  <div className="form-group row align-items-center">
                    <div className="col-4 text-right">Password</div>
                    <div className="col-8"><input type="password" className="form-control" value={password} onChange={(e) => setPassword(e.target.value)} required /></div>
                  </div>
                  <div className="form-group row align-items-center mt-4">
                    <div className="col-4"></div>
                    <div className="col-8"><button type="submit" className="btn btn-primary" disabled={loading}>{loading ? 'Loading...' : 'Login'}</button></div>
                  </div>
                </div>
              </form>
            </div>
          </div>
        </div>
      </main>
      <footer><div className="container"><div className="text-center py-4 text-muted">Copyright &copy; 2024 - Web Tech ID</div></div></footer>
    </>
  )
}
