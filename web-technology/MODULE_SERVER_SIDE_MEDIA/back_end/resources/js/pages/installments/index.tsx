import React from 'react';
import { Head, Link } from '@inertiajs/react';
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
];

export default function InstallmentsIndex() {
    // Mock data - in real app this would come from props
    const cars = [
        {
            id: 1,
            name: 'Toyota FT 86',
            description: 'Toyota FT 86 car is the best',
            availableMonths: ['12 Months', '24 Months', '48 Months'],
            available: true,
        },
        {
            id: 2,
            name: 'Nissan Livina',
            description: 'Family Cars for everyone',
            availableMonths: ['12 Months', '24 Months'],
            available: false, // Already applied
        },
        {
            id: 3,
            name: 'Toyota FT 86',
            description: 'Toyota FT 86 car is the best',
            availableMonths: ['12 Months', '24 Months', '48 Months'],
            available: true,
        },
    ];

    return (
        <AppLayout breadcrumbs={breadcrumbs}>
            <Head title="Cars" />

            {/* Header */}
            <header className="jumbotron bg-gray-100 py-5">
                <div className="container text-center">
                    <h1 className="display-4 text-4xl font-bold">Cars</h1>
                </div>
            </header>

            <div className="container mx-auto px-4 py-5 mb-5">
                <div className="section-header mb-4">
                    <h4 className="section-title text-muted text-lg font-medium">List of Cars</h4>
                </div>

                <div className="section-body space-y-6">
                    {cars.map((car) => (
                        <article
                            key={car.id}
                            className={`spot p-8 border rounded-lg shadow-sm ${
                                car.available ? 'bg-gray-50' : 'bg-gray-100 opacity-50'
                            }`}
                        >
                            <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
                                <div className="col-span-1">
                                    <h5 className="text-primary text-xl font-semibold text-blue-600">{car.name}</h5>
                                    <span className="text-muted text-gray-600">{car.description}</span>
                                </div>
                                <div className="col-span-1">
                                    <h5 className="font-semibold">Available Month</h5>
                                    <span className="text-muted text-gray-600">{car.availableMonths.join(', ')}</span>
                                </div>
                                <div className="col-span-1 flex justify-end">
                                    {car.available ? (
                                        <Link
                                            href={`/installments/${car.id}`}
                                            className="btn btn-danger bg-red-600 text-white px-6 py-3 rounded-lg hover:bg-red-700 text-center block"
                                        >
                                            Detail
                                        </Link>
                                    ) : (
                                        <div className="bg-success text-white p-3 rounded">
                                            Vacancies have been submitted
                                        </div>
                                    )}
                                </div>
                            </div>
                        </article>
                    ))}
                </div>
            </div>
        </AppLayout>
    );
}
