import React from 'react';
import { Head } from '@inertiajs/react';

export default function Edit() {
    return (
        <>
            <Head title="Edit Society" />
            <div className="py-12">
                <div className="max-w-7xl mx-auto sm:px-6 lg:px-8">
                    <div className="bg-white overflow-hidden shadow-sm sm:rounded-lg">
                        <div className="p-6 text-gray-900">
                            <h1 className="text-2xl font-bold mb-4">Edit Society</h1>
                            <p>This is the edit society page. API routes are available for CRUD operations.</p>
                        </div>
                    </div>
                </div>
            </div>
        </>
    );
}
