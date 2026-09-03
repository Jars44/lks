import React, { useState } from 'react';
import { Head, useForm } from '@inertiajs/react';
import AppLayout from '@/layouts/app-layout';
import { type BreadcrumbItem } from '@/types';

const breadcrumbs: BreadcrumbItem[] = [
    {
        title: 'Dashboard',
        href: '/dashboard',
    },
    {
        title: 'Cars',
        href: '/installments',
    },
    {
        title: 'Toyota FT 86',
        href: '/installments/1',
    },
];

export default function InstallmentsShow() {
    const [monthlyPayment, setMonthlyPayment] = useState('Rp. 10.000.000');
    const [validationErrors, setValidationErrors] = useState<{ [key: string]: string }>({});
    const [successMessage, setSuccessMessage] = useState('');

    const { data, setData, post, processing, errors, reset } = useForm({
        months: '',
        notes: '',
    });

    const validateForm = () => {
        const errors: { [key: string]: string } = {};

        if (!data.months) {
            errors.months = 'Please select the number of months for installment.';
        }

        if (!data.notes.trim()) {
            errors.notes = 'Please provide notes explaining why your installment should be approved.';
        } else if (data.notes.trim().length < 10) {
            errors.notes = 'Notes must be at least 10 characters long.';
        }

        setValidationErrors(errors);
        return Object.keys(errors).length === 0;
    };

    const handleMonthsChange = (e: React.ChangeEvent<HTMLSelectElement>) => {
        const months = e.target.value;
        setData('months', months);

        // Calculate monthly payment based on selected months
        // This is a simple calculation - in real app it would be more complex
        const basePrice = 900000000; // Rp. 900.000.000
        const monthsNum = parseInt(months);
        const monthly = Math.round(basePrice / monthsNum);
        setMonthlyPayment(`Rp. ${monthly.toLocaleString('id-ID')}`);
    };

    const handleSubmit = (e: React.FormEvent) => {
        e.preventDefault();
        setSuccessMessage('');

        if (!validateForm()) {
            return;
        }

        post('/applications', {
            onSuccess: () => {
                setSuccessMessage('Installment application submitted successfully!');
                reset();
                setValidationErrors({});
                setMonthlyPayment('Rp. 10.000.000');
            },
            onError: (errors) => {
                // API errors are handled by Inertia's errors object
            },
        });
    };

    return (
        <AppLayout breadcrumbs={breadcrumbs}>
            <Head title="Toyota FT 86" />

            {/* Header */}
            <header className="jumbotron bg-gray-100 py-5">
                <div className="container text-center">
                    <div>
                        <h1 className="display-4 text-4xl font-bold">Toyota FT 86</h1>
                        <span className="text-muted text-gray-600">Brand : Toyota</span>
                    </div>
                </div>
            </header>

            <div className="container mx-auto px-4 py-5">
                {successMessage && (
                    <div className="alert alert-success bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded mb-4">
                        {successMessage}
                    </div>
                )}

                {Object.keys(errors).length > 0 && (
                    <div className="alert alert-danger bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-4">
                        <ul className="list-disc list-inside">
                            {Object.values(errors).map((error, index) => (
                                <li key={index}>{error}</li>
                            ))}
                        </ul>
                    </div>
                )}

                <div className="grid grid-cols-1 gap-4 mb-3">
                    <div className="form-group">
                        <h3 className="text-2xl font-bold">Description</h3>
                        <p>Toyota FT 86 car is the best</p>
                    </div>
                    <div className="form-group">
                        <h3 className="text-2xl font-bold">
                            Price : <span className="badge badge-primary bg-blue-500 text-white px-3 py-1 rounded">Rp. 900.000.000</span>
                        </h3>
                    </div>
                </div>

                <form onSubmit={handleSubmit}>
                    <div className="grid grid-cols-1 gap-4 mb-3">
                        <div className="form-group">
                            <h3 className="text-2xl font-bold">Select Months</h3>
                            <select
                                name="months"
                                className={`form-control border rounded px-3 py-2 w-full ${validationErrors.months ? 'border-red-500' : 'border-gray-300'}`}
                                value={data.months}
                                onChange={handleMonthsChange}
                            >
                                <option value="">Select months</option>
                                <option value="12">12 Months</option>
                                <option value="24">24 Months</option>
                                <option value="48">48 Months</option>
                                <option value="50">50 Months</option>
                                <option value="55">55 Months</option>
                            </select>
                            {validationErrors.months && <p className="text-red-500 text-sm mb-2">{validationErrors.months}</p>}
                        </div>
                        <div className="form-group">
                            <h3 className="text-2xl font-bold">
                                Nominal/Month : <span className="badge badge-primary bg-blue-500 text-white px-3 py-1 rounded">{monthlyPayment}</span>
                            </h3>
                        </div>

                        <div className="form-group">
                            <div className="flex items-center mb-3">
                                <label className="mr-3 mb-0 text-lg font-medium">Notes</label>
                            </div>
                            <textarea
                                className={`form-control border rounded px-3 py-2 w-full ${validationErrors.notes ? 'border-red-500' : 'border-gray-300'}`}
                                rows={6}
                                placeholder="Explain why your installment should be approved"
                                value={data.notes}
                                onChange={(e) => setData('notes', e.target.value)}
                            />
                            {validationErrors.notes && <p className="text-red-500 text-sm mb-2">{validationErrors.notes}</p>}
                        </div>
                        <div className="form-group">
                            <div className="flex items-center mb-3">
                                <button
                                    type="submit"
                                    className="btn btn-primary bg-blue-600 text-white px-6 py-3 rounded hover:bg-blue-700 disabled:opacity-50"
                                    disabled={processing}
                                >
                                    {processing ? 'Applying...' : 'Apply'}
                                </button>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </AppLayout>
    );
}
