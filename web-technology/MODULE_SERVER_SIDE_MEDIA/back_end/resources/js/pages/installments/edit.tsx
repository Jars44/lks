import React from 'react';
import { Head } from '@inertiajs/react';

export default function ${page^}() {
    return (
        <>
            <Head title="${dir^} ${page^}" />
            <div className="py-12">
                <div className="max-w-7xl mx-auto sm:px-6 lg:px-8">
                    <div className="bg-white overflow-hidden shadow-sm sm:rounded-lg">
                        <div className="p-6 text-gray-900">
                            <h1 className="text-2xl font-bold mb-4">${dir^} ${page^}</h1>
                            <p>This is the $page $dir page. API routes are available for CRUD operations.</p>
                        </div>
                    </div>
                </div>
            </div>
        </>
    );
}
