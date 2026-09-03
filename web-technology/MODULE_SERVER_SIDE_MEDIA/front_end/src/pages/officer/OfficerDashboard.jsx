import { useEffect, useState } from 'react'
import api from '../../services/api'
import Navbar from '../../components/Navbar.jsx'

const TABS = [
  { key: 'brands', label: 'Brands' },
  { key: 'regionals', label: 'Regionals' },
  { key: 'societies', label: 'Societies' },
  { key: 'instalments', label: 'Installments' },
  { key: 'months', label: 'Available Months' },
]

function formatRp(n) {
  if (!n) return 'Rp 0'
  return 'Rp ' + Number(n).toLocaleString('id-ID')
}

export default function OfficerDashboard() {
  const [active, setActive] = useState('brands')
  const [items, setItems] = useState([])
  const [loading, setLoading] = useState(false)
  const name = localStorage.getItem('name') || 'Officer'

  const endpoints = {
    brands: '/officer/brands',
    regionals: '/officer/regionals',
    societies: '/officer/societies',
    instalments: '/officer/installments',
    months: '/officer/available-months',
  }

  const load = async (tab) => {
    setLoading(true)
    try {
      const r = await api.get(endpoints[tab])
      const d = r.data
      setItems(d.brands || d.regionals || d.societies || d.installments || d.available_months || [])
    } catch {
      setItems([])
    } finally {
      setLoading(false)
    }
  }

  useEffect(() => { load(active) }, [active])

  const renderTitle = (item) => {
    if (active === 'brands') return item.brand
    if (active === 'regionals') return item.province + ', ' + item.district
    if (active === 'societies') return item.name + ' (' + item.id_card_number + ') - ' + item.gender + ', ' + item.born_date
    if (active === 'instalments') return item.cars + ' - ' + item.brand + ' - ' + formatRp(item.price)
    if (active === 'months') return item.instalment.cars + ' - ' + item.description + ' - ' + formatRp(item.nominal)
    return '-'
  }

  return (
    <>
      <Navbar name={name} />
      <main>
        <header className="jumbotron"><div className="container"><h1 className="display-4">Officer Dashboard</h1></div></header>
        <div className="container">
          <div className="mb-4">
            {TABS.map((t) => (
              <button type="button" key={t.key} className={`btn btn-outline-primary mx-1 ${active === t.key ? 'active' : ''}`} onClick={() => setActive(t.key)}>{t.label}</button>
            ))}
          </div>
          {loading && <div className="alert alert-info">Loading...</div>}
          <div className="row">
            {items.map((item, idx) => (
              <div className="col-md-6" key={idx}>
                <div className="card card-default">
                  <div className="card-body">{renderTitle(item)}</div>
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
