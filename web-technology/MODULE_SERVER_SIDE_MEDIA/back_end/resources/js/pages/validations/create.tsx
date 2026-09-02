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
        title: 'Request Data Validation',
        href: '/validations/create',
    },
];

export default function CreateValidation() {
    const { data, setData, post, processing, errors, wasSuccessful, reset } = useForm({
        is_working: '',
        job: '',
        job_description: '',
        income: '',
        reason: '',
    });

    const [validationErrors, setValidationErrors] = useState<{ [key: string]: string }>({});
    const [successMessage, setSuccessMessage] = useState('');

    const validateForm = () => {
        const errors: { [key: string]: string } = {};

        if (!data.is_working) {
            errors.is_working = 'Please select whether you are working.';
        }

        if (data.is_working === 'yes') {
            if (!data.job.trim()) {
                errors.job = 'Job is required when you are working.';
            }
            if (!data.job_description.trim()) {
                errors.job_description = 'Job description is required when you are working.';
            }
            if (!data.income || isNaN(Number(data.income)) || Number(data.income) <= 0) {
                errors.income = 'Please enter a valid income amount greater than 0.';
            }
        }

        if (!data.reason.trim()) {
            errors.reason = 'Reason for acceptance is required.';
        }

        setValidationErrors(errors);
        return Object.keys(errors).length === 0;
    };

    const handleSubmit = (e: React.FormEvent) => {
        e.preventDefault();
        setSuccessMessage('');

        if (!validateForm()) {
            return;
        }

        post('/validations', {
            onSuccess: () => {
                setSuccessMessage('Validation request submitted successfully!');
                reset();
                setValidationErrors({});
            },
            onError: (errors) => {
                // API errors are handled by Inertia's errors object
            },
        });
    };

    return (
        <AppLayout breadcrumbs={breadcrumbs}>
            <Head title="Request Data Validation" />

            {/* Header */}
            <header className="jumbotron bg-gray-100 py-5">
                <div className="container text-center">
                    <h1 className="display-4 text-4xl font-bold">Request Data Validation</h1>
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

                <form onSubmit={handleSubmit}>
                    <div className="grid grid-cols-1 md:grid-cols-2 gap-4 mb-4">
                        <div className="form-group">
                            <div className="flex items-center mb-3">
                                <label className="mr-3 mb-0">Are you working?</label>
                                <select
                                    className={`form-control-sm border rounded px-2 py-1 ${validationErrors.is_working ? 'border-red-500' : 'border-gray-300'}`}
                                    value={data.is_working}
                                    onChange={(e) => setData('is_working', e.target.value)}
                                >
                                    <option value="">Select</option>
                                    <option value="yes">Yes, I have</option>
                                    <option value="no">No</option>
                                </select>
                            </div>
                            {validationErrors.is_working && <p className="text-red-500 text-sm mb-2">{validationErrors.is_working}</p>}

                            <input
                                type="text"
                                placeholder="Your Job"
                                className={`form-control border rounded px-3 py-2 mb-2 w-full ${validationErrors.job ? 'border-red-500' : 'border-gray-300'}`}
                                value={data.job}
                                onChange={(e) => setData('job', e.target.value)}
                            />
                            {validationErrors.job && <p className="text-red-500 text-sm mb-2">{validationErrors.job}</p>}

                            <textarea
                                className={`form-control border rounded px-3 py-2 w-full ${validationErrors.job_description ? 'border-red-500' : 'border-gray-300'}`}
                                rows={5}
                                placeholder="describe what you do in your job"
                                value={data.job_description}
                                onChange={(e) => setData('job_description', e.target.value)}
                            />
                            {validationErrors.job_description && <p className="text-red-500 text-sm mb-2">{validationErrors.job_description}</p>}

                            <input
                                type="number"
                                placeholder="Income (Rp)"
                                className={`form-control border rounded px-3 py-2 mt-2 w-full ${validationErrors.income ? 'border-red-500' : 'border-gray-300'}`}
                                value={data.income}
                                onChange={(e) => setData('income', e.target.value)}
                                min="0"
                            />
                            {validationErrors.income && <p className="text-red-500 text-sm mb-2">{validationErrors.income}</p>}
                        </div>

                        <div className="form-group">
                            <div className="flex items-center mb-3">
                                <label className="mr-3 mb-0">Reason Accepted</label>
                            </div>
                            <textarea
                                className={`form-control border rounded px-3 py-2 w-full ${validationErrors.reason ? 'border-red-500' : 'border-gray-300'}`}
                                rows={6}
                                placeholder="Explain why you should be accepted"
                                value={data.reason}
                                onChange={(e) => setData('reason', e.target.value)}
                            />
                            {validationErrors.reason && <p className="text-red-500 text-sm mb-2">{validationErrors.reason}</p>}
                        </div>
                    </div>

                    <button
                        type="submit"
                        className="btn btn-primary bg-blue-600 text-white px-4 py-2 rounded hover:bg-blue-700 disabled:opacity-50"
                        disabled={processing}
                    >
                        {processing ? 'Sending...' : 'Send Request'}
                    </button>
                </form>
            </div>
        </AppLayout>
    );
}
