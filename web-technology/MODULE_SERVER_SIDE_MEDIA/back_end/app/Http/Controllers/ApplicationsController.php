<?php

namespace App\Http\Controllers;

use App\Models\InstallmentApplySocieties;
use App\Models\Society;
use App\Models\Installment;
use App\Services\InstallmentApprovalService;
use App\Services\WorkflowService;
use App\Http\Requests\StoreInstallmentApplySocietiesRequest;
use App\Http\Requests\UpdateInstallmentApplySocietiesRequest;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;

class ApplicationsController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index(Request $request): JsonResponse
    {
        $query = InstallmentApplySocieties::with(['installment.brand', 'society.regional', 'status']);

        // Search functionality
        if ($request->has('search') && !empty($request->search)) {
            $search = $request->search;
            $query->where(function ($q) use ($search) {
                $q->whereHas('installment', function ($installmentQuery) use ($search) {
                    $installmentQuery->where('name', 'like', "%{$search}%");
                })
                ->orWhereHas('society', function ($societyQuery) use ($search) {
                    $societyQuery->where('name', 'like', "%{$search}%");
                });
            });
        }

        // Filter by installment
        if ($request->has('installment_id') && !empty($request->installment_id)) {
            $query->where('installment_id', $request->installment_id);
        }

        // Filter by society
        if ($request->has('society_id') && !empty($request->society_id)) {
            $query->where('society_id', $request->society_id);
        }

        // Filter by status
        if ($request->has('status_id') && !empty($request->status_id)) {
            $query->where('status_id', $request->status_id);
        }

        $applications = $query->paginate(15);

        return response()->json($applications);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(StoreInstallmentApplySocietiesRequest $request): JsonResponse
    {
        try {
            $society = Society::findOrFail($request->society_id);
            $installment = Installment::findOrFail($request->installment_id);

            $approvalService = new InstallmentApprovalService();
            $application = $approvalService->submitApplication($society, $installment);

            return response()->json([
                'message' => 'Application created successfully.',
                'data' => $application->load(['installment.brand', 'society.regional', 'status'])
            ], 201);
        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Failed to create application.',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Display the specified resource.
     */
    public function show(InstallmentApplySocieties $application): JsonResponse
    {
        return response()->json($application->load(['installment.brand', 'society.regional', 'status']));
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(UpdateInstallmentApplySocietiesRequest $request, InstallmentApplySocieties $application): JsonResponse
    {
        try {
            $application->update($request->validated());

            // Trigger workflow if status changed
            if ($request->has('status_id') && $request->status_id !== $application->status_id) {
                $workflowService = new WorkflowService();
                $newStatus = $application->status;
                $workflowService->processAutomaticTransitions($application);
            }

            return response()->json([
                'message' => 'Application updated successfully.',
                'data' => $application->load(['installment.brand', 'society.regional', 'status'])
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Failed to update application.',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Approve application
     */
    public function approve(InstallmentApplySocieties $application): JsonResponse
    {
        try {
            $approvalService = new InstallmentApprovalService();
            $result = $approvalService->approveApplication($application);

            return response()->json([
                'message' => 'Application approved successfully.',
                'data' => $application->load(['installment.brand', 'society.regional', 'status'])
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Failed to approve application.',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Reject application
     */
    public function reject(Request $request, InstallmentApplySocieties $application): JsonResponse
    {
        try {
            $reason = $request->input('reason');
            $approvalService = new InstallmentApprovalService();
            $result = $approvalService->rejectApplication($application, $reason);

            return response()->json([
                'message' => 'Application rejected successfully.',
                'data' => $application->load(['installment.brand', 'society.regional', 'status'])
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Failed to reject application.',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(InstallmentApplySocieties $application): JsonResponse
    {
        try {
            $application->delete();

            return response()->json([
                'message' => 'Application deleted successfully.'
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Failed to delete application.',
                'error' => $e->getMessage()
            ], 500);
        }
    }
}
