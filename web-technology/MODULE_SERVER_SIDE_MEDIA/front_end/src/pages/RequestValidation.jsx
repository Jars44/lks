import { useState } from 'react'
import { useNavigate } from 'react-router-dom'
import api from '../services/api'
import { useToast } from '../components/Toast.jsx'
import Navbar from '../components/Navbar.jsx'

export default function RequestValidation() {
  const [working, setWorking] = useState('yes')
  const [job, setJob] = useState('')
  const [jobDescription, setJobDescription] = useState('')
  const [income, setIncome] = useState('')
  const [reason, setReason] = useState('')
  const [loading, setLoading] = useState(false)
  const nav = useNavigate()
  const toast = useToast()
  const name = localStorage.getItem('name') || ''

  const handleSubmit = async (e) => {
    e.preventDefault()
    setLoading(true)
    try {
      const payload = working === 'no'
        ? { job: '-', job_description: '-', income: 0, reason_accepted: reason }
        : { job, job_description: jobDescription, income: Number(income), reason_accepted: reason }
      const r = await api.post('/validation', payload)
      toast.push(r.data.message || 'Request data validation successful', 'success')
      nav('/dashboard')
    } catch (err) {
      toast.push(err.response?.data?.message || 'Failed', 'error')
    } finally {
      setLoading(false)
    }
  }

  return (
    <>
      <Navbar name={name} />
      <main>
        <header className="jumbotron"><div className="container"><h1 className="display-4">Request Data Validation</h1></div></header>
        <div className="container">
          <div className="row justify-content-center">
            <div className="col-md-8">
              <form className="card card-default" onSubmit={handleSubmit}>
                <div className="card-body">
                  <div className="form-group row align-items-center">
                    <div className="col-4 text-right">Are you working?</div>
                    <div className="col-8">
                      <select className="form-control" value={working} onChange={(e) => setWorking(e.target.value)}>
                        <option value="yes">Yes, I have</option>
                        <option value="no">No</option>
                      </select>
                    </div>
                  </div>
                  {working === 'yes' && (
                    <>
                      <div className="form-group row align-items-center">
                        <div className="col-4 text-right">Your Job</div>
                        <div className="col-8"><input className="form-control" placeholder="Your Job" value={job} onChange={(e) => setJob(e.target.value)} required /></div>
                      </div>
                      <div className="form-group row align-items-center">
                        <div className="col-4 text-right">Job Description</div>
                        <div className="col-8"><textarea className="form-control" rows="3" placeholder="describe what you do in your job" value={jobDescription} onChange={(e) => setJobDescription(e.target.value)} required /></div>
                      </div>
                      <div className="form-group row align-items-center">
                        <div className="col-4 text-right">Income (Rp)</div>
                        <div className="col-8"><input type="number" className="form-control" placeholder="Income (Rp)" value={income} onChange={(e) => setIncome(e.target.value)} required /></div>
                      </div>
                    </>
                  )}
                  <div className="form-group row align-items-start">
                    <div className="col-4 text-right pt-2">Reason Accepted</div>
                    <div className="col-8"><textarea className="form-control" rows="3" placeholder="Explain why you should be accepted" value={reason} onChange={(e) => setReason(e.target.value)} required /></div>
                  </div>
                  <div className="form-group row align-items-center mt-4">
                    <div className="col-4"></div>
                    <div className="col-8"><button type="submit" className="btn btn-primary" disabled={loading}>{loading ? 'Sending...' : 'Send Request'}</button></div>
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