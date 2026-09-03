import { useEffect, useState } from 'react'
import api from '../../services/api'
import { useToast } from '../../components/Toast.jsx'
import Navbar from '../../components/Navbar.jsx'

function formatRp(n) {
  if (!n) return 'Rp 0'
  return 'Rp ' + Number(n).toLocaleString('id-ID')
}

function badge(s) {
  if (s === 'accepted') return <span className="badge badge-success">Accepted</span>
  if (s === 'rejected') return <span className="badge badge-danger">Rejected</span>
  if (s === 'pending') return <span className="badge badge-info">Pending</span>
  return <span className="badge badge-secondary">-</span>
}

export default function ValidatorDashboard() {
  const [items, setItems] = useState([])
  const [loading, setLoading] = useState(true)
  const [saving, setSaving] = useState(null)
  const toast = useToast()
  const name = localStorage.getItem('name') || 'Validator'

  const load = async () => {
    setLoading(true)
    try {
      const r = await api.get('/validator/validations')
      setItems(r.data.validations || [])
    } catch {
      setItems([])
    } finally {
      setLoading(false)
    }
  }

  useEffect(() => { load() }, [])

  const decide = async (id, status) => {
    setSaving(id)
    try {
      await api.put(`/validator/validations/${id}`, { status, validator_notes: 'Verified by validator' })
      toast.push('Validation ' + status, 'success')
      await load()
    } catch (err) {
      toast.push(err.response?.data?.message || 'Update failed', 'error')
    } finally {
      setSaving(null)
    }
  }

  return (
    <>
      <Navbar name={name} />
      <main>
        <header className="jumbotron"><div className="container"><h1 className="display-4">Validator Dashboard</h1></div></header>
        <div className="container">
          {loading && <div className="alert alert-info">Loading...</div>}
          {!loading && items.length === 0 && <div className="alert alert-info">No validation requests yet.</div>}
          <div className="row">
            {items.map((v) => (
              <div className="col-md-6" key={v.id}>
                <div className="card card-default">
                  <div className="card-header border-0"><h5 className="mb-0">{v.society?.name || '-'}</h5></div>
                  <div className="card-body p-0">
                    <table className="table table-striped mb-0">
                      <tbody>
                        <tr><th>Status</th><td>{badge(v.status)}</td></tr>
                        <tr><th>Job</th><td className="text-muted">{v.job || '-'}</td></tr>
                        <tr><th>Income/Month</th><td className="text-muted">{formatRp(v.income)}</td></tr>
                        <tr><th>Reason</th><td className="text-muted">{v.reason || '-'}</td></tr>
                        <tr><th>Validator Notes</th><td className="text-muted">{v.validator_notes || '-'}</td></tr>
                      </tbody>
                    </table>
                  </div>
                  <div className="card-footer">
                    <div className="row">
                      <div className="col-6"><button type="button" className="btn btn-success btn-block" disabled={saving === v.id} onClick={() => decide(v.id, 'accepted')}>Accept</button></div>
                      <div className="col-6"><button type="button" className="btn btn-danger btn-block" disabled={saving === v.id} onClick={() => decide(v.id, 'rejected')}>Reject</button></div>
                    </div>
                  </div>
                </div>
              </div>
            ))}
          </div>
        </div>
      </main>
      <footer><div className="container"><div className="text-center py-4 text-muted">Copyright &copy; 2024 - Web Tech ID</div></div></footer>
    </>
  )
}
