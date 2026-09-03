import { useEffect, useState } from 'react'
import { useNavigate, useParams } from 'react-router-dom'
import api from '../services/api'
import Navbar from '../components/Navbar.jsx'
import { useToast } from '../components/Toast.jsx'

function formatRp(n) {
  if (!n) return 'Rp. 0'
  return 'Rp. ' + Number(n).toLocaleString('id-ID')
}

export default function CarDetail() {
  const { id } = useParams()
  const [car, setCar] = useState(null)
  const [month, setMonth] = useState('')
  const [notes, setNotes] = useState('')
  const [loading, setLoading] = useState(true)
  const [submitting, setSubmitting] = useState(false)
  const nav = useNavigate()
  const toast = useToast()
  const name = localStorage.getItem('name') || ''

  useEffect(() => {
    (async () => {
      try {
        const r = await api.get(`/instalment_cars/${id}`)
        setCar(r.data.instalment)
      } catch (e) { toast.push('Failed to load car', 'error') }
      setLoading(false)
    })()
  }, [id])

  const selectedMonth = car?.available_month?.find((m) => m.month === Number(month))

  const handleSubmit = async (e) => {
    e.preventDefault()
    if (!month) { toast.push('Select months first', 'error'); return }
    setSubmitting(true)
    try {
      const r = await api.post('/applications', {
        instalment_id: Number(id),
        months: Number(month),
        notes: notes || '',
      })
      toast.push(r.data.message || 'Applying for Instalment successful', 'success')
      nav('/dashboard')
    } catch (err) {
      toast.push(err.response?.data?.message || 'Failed', 'error')
    } finally {
      setSubmitting(false)
    }
  }

  if (loading) return <><Navbar name={name} /><main className="container py-5 text-center"><div className="spinner-border" /></main></>
  if (!car) return <><Navbar name={name} /><main className="container py-5">Car not found.</main></>

  return (
    <>
      <Navbar name={name} />
      <main>
        <header className="jumbotron"><div className="container"><h1 className="display-4">{car.car}</h1><p className="lead">Brand : {car.brand}</p></div></header>
        <div className="container">
          <div className="row justify-content-center">
            <div className="col-md-8">
              <form className="card card-default" onSubmit={handleSubmit}>
                <div className="card-body">
                  <table className="table table-borderless mb-3">
                    <tbody>
                      <tr><th style={{ width: 180 }}>Description</th><td>{car.description}</td></tr>
                      <tr><th>Price</th><td><span className="badge badge-primary">{formatRp(car.price)}</span></td></tr>
                    </tbody>
                  </table>
                  <div className="form-group row align-items-center">
                    <div className="col-4 text-right">Select Months</div>
                    <div className="col-8">
                      <select className="form-control" value={month} onChange={(e) => setMonth(e.target.value)} required>
                        <option value="">-- Select --</option>
                        {car.available_month.map((m) => (
                          <option key={m.month} value={m.month}>{m.description}</option>
                        ))}
                      </select>
                    </div>
                  </div>
                  <div className="form-group row align-items-center">
                    <div className="col-4 text-right">Nominal/Month</div>
                    <div className="col-8"><span className="badge badge-primary">{formatRp(selectedMonth?.nominal)}</span></div>
                  </div>
                  <div className="form-group row align-items-start">
                    <div className="col-4 text-right pt-2">Notes</div>
                    <div className="col-8"><textarea className="form-control" rows="3" placeholder="Explain why your installment should be approved" value={notes} onChange={(e) => setNotes(e.target.value)} /></div>
                  </div>
                  <div className="form-group row align-items-center mt-4">
                    <div className="col-4"></div>
                    <div className="col-8"><button type="submit" className="btn btn-primary" disabled={submitting}>{submitting ? 'Applying...' : 'Apply'}</button></div>
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