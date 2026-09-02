import AppLayout from '@/layouts/app-layout';
import { type BreadcrumbItem } from '@/types';
import { Head, Link } from '@inertiajs/react';

const breadcrumbs: BreadcrumbItem[] = [
    {
        title: 'Dashboard',
        href: '/dashboard',
    },
];

export default function Dashboard() {
    return (
        <AppLayout breadcrumbs={breadcrumbs}>
            <Head title="Dashboard" />

            {/* Header */}
            <header className="jumbotron bg-gray-100 py-5">
                <div className="container text-center">
                    <h1 className="display-4 text-4xl font-bold">Dashboard</h1>
                </div>
            </header>

            <div className="container mx-auto px-4 py-5">
                {/* Data Validation Section */}
                <section className="validation-section mb-5">
                    <div className="section-header mb-3">
                        <h4 className="section-title text-muted text-lg font-medium">My Data Validation</h4>
                    </div>
                    <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
                        {/* Request Data Validation */}
                        <div className="card border rounded-lg shadow-sm">
                            <div className="card-header p-4 border-b">
                                <h5 className="mb-0 font-semibold">Data Validation</h5>
                            </div>
                            <div className="card-body p-4">
                                <Link href="/validations/create" className="btn btn-primary btn-block bg-blue-600 text-white px-4 py-2 rounded block text-center hover:bg-blue-700">
                                    + Request validation
                                </Link>
                            </div>
                        </div>

                        {/* Pending Validation */}
                        <div className="card border rounded-lg shadow-sm">
                            <div className="card-header border-0 p-4">
                                <h5 className="mb-0 font-semibold">Data Validation</h5>
                            </div>
                            <div className="card-body p-0">
                                <table className="table table-striped mb-0 w-full">
                                    <tbody>
                                        <tr>
                                            <th className="p-3 border-b text-left">Status</th>
                                            <td className="p-3 border-b"><span className="badge badge-info bg-blue-500 text-white px-2 py-1 rounded">Pending</span></td>
                                        </tr>
                                        <tr>
                                            <th className="p-3 border-b text-left">Job</th>
                                            <td className="p-3 border-b text-muted">-</td>
                                        </tr>
                                        <tr>
                                            <th className="p-3 border-b text-left">Income/Month</th>
                                            <td className="p-3 border-b text-muted">Rp. 300.000</td>
                                        </tr>
                                        <tr>
                                            <th className="p-3 border-b text-left">Validator</th>
                                            <td className="p-3 border-b text-muted">-</td>
                                        </tr>
                                        <tr>
                                            <th className="p-3 border-b text-left">Validator Notes</th>
                                            <td className="p-3 border-b text-muted">-</td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>

                        {/* Accepted Validation */}
                        <div className="card border rounded-lg shadow-sm">
                            <div className="card-header border-0 p-4">
                                <h5 className="mb-0 font-semibold">Data Validation</h5>
                            </div>
                            <div className="card-body p-0">
                                <table className="table table-striped mb-0 w-full">
                                    <tbody>
                                        <tr>
                                            <th className="p-3 border-b text-left">Status</th>
                                            <td className="p-3 border-b"><span className="badge badge-success bg-green-500 text-white px-2 py-1 rounded">Accepted</span></td>
                                        </tr>
                                        <tr>
                                            <th className="p-3 border-b text-left">Job</th>
                                            <td className="p-3 border-b text-muted">Programmer</td>
                                        </tr>
                                        <tr>
                                            <th className="p-3 border-b text-left">Income/Month</th>
                                            <td className="p-3 border-b text-muted">Rp. 3.000.000</td>
                                        </tr>
                                        <tr>
                                            <th className="p-3 border-b text-left">Validator</th>
                                            <td className="p-3 border-b text-muted">Usman M.Ti</td>
                                        </tr>
                                        <tr>
                                            <th className="p-3 border-b text-left">Validator Notes</th>
                                            <td className="p-3 border-b text-muted">siap kerja</td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </section>

                {/* Installment Cars Section */}
                <section className="validation-section mb-5">
                    <div className="section-header mb-3 flex flex-col md:flex-row md:justify-between md:items-center">
                        <h4 className="section-title text-muted text-lg font-medium mb-3 md:mb-0">My Installment Cars</h4>
                        <Link href="/installments/create" className="btn btn-primary bg-blue-600 text-white px-6 py-3 rounded hover:bg-blue-700">
                            + Add Installment Cars
                        </Link>
                    </div>
                    <div className="section-body">
                        <div className="mb-4">
                            <div className="alert alert-warning bg-yellow-100 border border-yellow-400 text-yellow-700 px-4 py-3 rounded">
                                Your validation must be approved by validator to Installment Cars.
                            </div>
                        </div>

                        {/* Installment Cars Cards */}
                        <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                            {/* Toyota FT 86 */}
                            <div className="card border rounded-lg shadow-sm">
                                <div className="card-header border-0 p-4">
                                    <h5 className="mb-0 font-semibold">Toyota FT 86</h5>
                                </div>
                                <div className="card-body p-0">
                                    <table className="table table-striped mb-0 w-full">
                                        <tbody>
                                            <tr>
                                                <th className="p-3 border-b text-left">Description</th>
                                                <td className="p-3 border-b text-muted">Toyota FT 86 car is the best</td>
                                            </tr>
                                            <tr>
                                                <th className="p-3 border-b text-left">Price</th>
                                                <td className="p-3 border-b text-muted">Rp. 900.000.000</td>
                                            </tr>
                                            <tr>
                                                <th className="p-3 border-b text-left">Installment</th>
                                                <td className="p-3 border-b text-muted">
                                                    12 Months <span className="badge badge-info bg-blue-500 text-white px-2 py-1 rounded ml-2">Pending</span>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th className="p-3 border-b text-left">Apply Date</th>
                                                <td className="p-3 border-b text-muted">Desember 12, 2024</td>
                                            </tr>
                                            <tr>
                                                <th className="p-3 border-b text-left">Notes</th>
                                                <td className="p-3 border-b text-muted">I want this one, because i am rich.</td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>

                            {/* Nissan Livina */}
                            <div className="card border rounded-lg shadow-sm">
                                <div className="card-header border-0 p-4">
                                    <h5 className="mb-0 font-semibold">Nissan Livina</h5>
                                </div>
                                <div className="card-body p-0">
                                    <table className="table table-striped mb-0 w-full">
                                        <tbody>
                                            <tr>
                                                <th className="p-3 border-b text-left">Description</th>
                                                <td className="p-3 border-b text-muted">Family Cars for everyone</td>
                                            </tr>
                                            <tr>
                                                <th className="p-3 border-b text-left">Price</th>
                                                <td className="p-3 border-b text-muted">Rp. 275.000.000</td>
                                            </tr>
                                            <tr>
                                                <th className="p-3 border-b text-left">Installment</th>
                                                <td className="p-3 border-b text-muted">
                                                    24 Months <span className="badge badge-success bg-green-500 text-white px-2 py-1 rounded ml-2">Accepted</span>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th className="p-3 border-b text-left">Apply Date</th>
                                                <td className="p-3 border-b text-muted">Desember 12, 2024</td>
                                            </tr>
                                            <tr>
                                                <th className="p-3 border-b text-left">Notes</th>
                                                <td className="p-3 border-b text-muted">I want this one too.</td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
            </div>
        </AppLayout>
    );
}
