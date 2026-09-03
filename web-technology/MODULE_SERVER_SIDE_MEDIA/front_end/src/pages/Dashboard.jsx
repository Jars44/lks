import { useEffect, useState } from 'react'
import { Link } from 'react-router-dom'
import api from '../services/api'
import Navbar from '../components/Navbar.jsx'

function formatRp(n) {
  if (!n) return 'Rp. 0'
  return 'Rp. ' + Number(n).toLocaleString('id-ID')
}

function formatDate(d) {
  if (!d) return '-'
  try { return new Date(d).toLocaleDateString('en-US', { year: 'numeric', month: 'long', day: 'numeric' }) } catch { return d }
}

export default function Dashboard() {
  const [validation, setValidation] = useState(null)
  const [apps, setApps] = useState([])
  const [loading, setLoading] = useState(true)
  const name = localStorage.getItem('name') || ''

  const load = async () => {
    setLoading(true)
    try {
      const v = await api.get('/validations')
      setValidation(v.data.validation)
    } catch { setValidation(null) }
    try {
      const a = await api.get('/applications')
      setApps(a.data.instalments || [])
    } catch { setApps([]) }
    setLoading(false)
  }
  useEffect(() => { load() }, [])

  const badge = (s) => {
    if (s === 'accepted') return <span className="badge badge-success">Accepted</span>
    if (s === 'rejected') return <span className="badge badge-danger">Rejected</span>
    if (s === 'pending') return <span className="badge badge-info">Pending</span>
    return <span className="badge badge-secondary">-</span>
  }

  const accepted = validation?.status === 'accepted'

  return (
    <>
      <Navbar name={name} />
      <main>
        <header className="jumbotron"><div className="container"><h1 className="display-4">Dashboard</h1></div></header>
        <div className="container">
          <section className="validation-section mb-5">
            <div className="section-header mb-3"><h4 className="section-title text-muted">My Data Validation</h4></div>
            <div className="row">
              {!validation && (
                <div className="col-md-4">
                  <div className="card card-default">
                    <div className="card-header"><h5 className="mb-0">Data Validation</h5></div>
                    <div className="card-body"><Link to="/data-validation" className="btn btn-primary btn-block">+ Request validation</Link></div>
                  </div>
                </div>
              )}
              {validation && (
                <div className="col-md-4">
                  <div className="card card-default">
                    <div className="card-header border-0"><h5 className="mb-0">Data Validation</h5></div>
                    <div className="card-body p-0">
                      <table className="table table-striped mb-0">
                        <tbody>
                          <tr><th>Status</th><td>{badge(validation.status)}</td></tr>
                          <tr><th>Job</th><td className="text-muted">{validation.job || '-'}</td></tr>
                          <tr><th>Income/Month</th><td className="text-muted">{formatRp(validation.income)}</td></tr>
                          <tr><th>Validator</th><td className="text-muted">{validation.validator?.name || '-'}</td></tr>
                          <tr><th>Validator Notes</th><td className="text-muted">{validation.validator_notes || '-'}</td></tr>
                        </tbody>
                      </table>
                    </div>
                  </div>
                </div>
              )}
            </div>
          </section>

          <section className="validation-section mb-5">
            <div className="section-header mb-3">
              <div className="row">
                <div className="col-md-8"><h4 className="section-title text-muted">My Installment Cars</h4></div>
                <div className="col-md-4">{accepted && <Link to="/instalments" className="btn btn-primary btn-lg btn-block">+ Add Installment Cars</Link>}</div>
              </div>
            </div>
            <div className="section-body">
              <div className="row mb-4">
                {!accepted && (
                  <div className="col-md-12">
                    <div className="alert alert-warning">Your validation must be approved by validator to Installment Cars.</div>
                  </div>
                )}
                {accepted && apps.length === 0 && (
                  <div className="col-md-12">
                    <div className="alert alert-info">No instalment applications yet. Click + Add Installment Cars to apply.</div>
                  </div>
                )}
                {apps.map((car) => (car.applications || []).map((app, idx) => (
                  <div className="col-md-6" key={car.id + '-' + idx}>
                    <div className="card card-default">
                      <div className="card-header border-0"><h5 className="mb-0">{car.car}</h5></div>
                      <div className="card-body p-0">
                        <table className="table table-striped mb-0">
                          <tbody>
                            <tr><th>Description</th><td className="text-muted">{car.description}</td></tr>
                            <tr><th>Price</th><td className="text-muted">{formatRp(car.price)}</td></tr>
                            <tr><th>Installment</th><td className="text-muted">{app.month} Months {badge(app.apply_status)}</td></tr>
                            <tr><th>Apply Date</th><td className="text-muted">{formatDate(new Date())}</td></tr>
                            <tr><th>Notes</th><td className="text-muted">{app.notes}</td></tr>
                          </tbody>
                        </table>
                      </div>
                    </div>
                  </div>
                )))}
              </div>
            </div>
          </section>
        </div>
      </main>
      <footer><div className="container"><div className="text-center py-4 text-muted">Copyright &copy; 2024 - Web Tech ID</div></div></footer>
    </>
  )
}