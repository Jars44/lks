import { useEffect, useState } from 'react'
import { Link } from 'react-router-dom'
import api from '../services/api'
import Navbar from '../components/Navbar.jsx'
import { useToast } from '../components/Toast.jsx'

export default function CarList() {
  const [cars, setCars] = useState([])
  const [apps, setApps] = useState([])
  const [loading, setLoading] = useState(true)
  const toast = useToast()
  const name = localStorage.getItem('name') || ''

  useEffect(() => {
    (async () => {
      try {
        const r = await api.get('/instalment_cars')
        setCars(r.data.cars || [])
      } catch (e) { toast.push('Failed to load cars', 'error') }
      try {
        const a = await api.get('/applications')
        setApps(a.data.instalments || [])
      } catch {}
      setLoading(false)
    })()
  }, [])

  const appliedIds = new Set(apps.map((a) => a.id))

  return (
    <>
      <Navbar name={name} />
      <main>
        <header className="jumbotron"><div className="container"><h1 className="display-4">Cars</h1></div></header>
        <div className="container">
          <h4 className="section-title text-muted mb-4">List of Cars</h4>
          {loading ? (
            <div className="text-center py-5"><div className="spinner-border" /></div>
          ) : (
            <div className="row">
              {cars.map((car) => (
                <div className="col-md-6 mb-4" key={car.id}>
                  <div className="card card-default">
                    <div className="card-header border-0"><h5 className="mb-0">{car.car}</h5></div>
                    <div className="card-body">
                      <p className="text-muted">{car.description}</p>
                      <p className="mb-3"><strong>Available Month:</strong> {car.available_month.map((m) => m.description).join(', ')}</p>
                      {appliedIds.has(car.id) ? (
                        <span className="badge badge-success">Vacancies have been submitted</span>
                      ) : (
                        <Link to={`/instalments/${car.id}`} className="btn btn-danger">Detail</Link>
                      )}
                    </div>
                  </div>
                </div>
              ))}
            </div>
          )}
        </div>
      </main>
      <footer><div className="container"><div className="text-center py-4 text-muted">Copyright &copy; 2024 - Web Tech ID</div></div></footer>
    </>
  )
}