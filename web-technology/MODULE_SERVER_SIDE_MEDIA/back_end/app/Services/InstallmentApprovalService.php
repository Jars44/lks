<?php

namespace App\Services;

use App\Models\InstallmentApplySocieties;
use App\Models\InstallmentApplyStatus;
use App\Models\Society;
use App\Models\Installment;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;

class InstallmentApprovalService
{
    /**
     * Submit installment application for a society
     */
    public function submitApplication(Society $society, Installment $installment): InstallmentApplySocieties
    {
        DB::beginTransaction();
        try {
            // Check if society is eligible
            $validationService = new SocietyValidationService();
            $eligibility = $validationService->checkEligibility($society, $installment);

            if (!$eligibility['eligible']) {
                throw new \Exception('Society is not eligible: ' . implode(', ', $eligibility['errors']));
            }

            // Get pending status
            $pendingStatus = InstallmentApplyStatus::where('name', 'pending')->first();
            if (!$pendingStatus) {
                throw new \Exception('Pending status not found');
            }

            // Create application
            $application = InstallmentApplySocieties::create([
                'installment_id' => $installment->id,
                'society_id' => $society->id,
                'status_id' => $pendingStatus->id,
                'applied_at' => now(),
            ]);

            // Trigger workflow
            $this->triggerWorkflow($application);

            DB::commit();
            Log::info("Installment application submitted for society ID: {$society->id}, installment ID: {$installment->id}");

            return $application;
        } catch (\Exception $e) {
            DB::rollBack();
            Log::error("Application submission failed", [
                'society_id' => $society->id,
                'installment_id' => $installment->id,
                'error' => $e->getMessage()
            ]);
            throw $e;
        }
    }

    /**
     * Approve installment application
     */
    public function approveApplication(InstallmentApplySocieties $application): bool
    {
        DB::beginTransaction();
        try {
            $approvedStatus = InstallmentApplyStatus::where('name', 'approved')->first();
            if (!$approvedStatus) {
                throw new \Exception('Approved status not found');
            }

            $application->update(['status_id' => $approvedStatus->id]);

            // Trigger post-approval workflow
            $this->triggerPostApprovalWorkflow($application);

            DB::commit();
            Log::info("Application approved for ID: {$application->id}");

            return true;
        } catch (\Exception $e) {
            DB::rollBack();
            Log::error("Application approval failed for ID: {$application->id}", [
                'error' => $e->getMessage()
            ]);
            throw $e;
        }
    }

    /**
     * Reject installment application
     */
    public function rejectApplication(InstallmentApplySocieties $application, string $reason = null): bool
    {
        DB::beginTransaction();
        try {
            $rejectedStatus = InstallmentApplyStatus::where('name', 'rejected')->first();
            if (!$rejectedStatus) {
                throw new \Exception('Rejected status not found');
            }

            $application->update(['status_id' => $rejectedStatus->id]);

            // Log rejection reason if provided
            if ($reason) {
                Log::info("Application rejected for ID: {$application->id}, reason: {$reason}");
            }

            DB::commit();
            return true;
        } catch (\Exception $e) {
            DB::rollBack();
            Log::error("Application rejection failed for ID: {$application->id}", [
                'error' => $e->getMessage()
            ]);
            throw $e;
        }
    }

    /**
     * Get applications by status
     */
    public function getApplicationsByStatus(string $statusName): \Illuminate\Database\Eloquent\Collection
    {
        return InstallmentApplySocieties::whereHas('status', function ($query) use ($statusName) {
            $query->where('name', $statusName);
        })->with(['installment.brand', 'society.regional', 'status'])->get();
    }

    /**
     * Check if society can apply for installment
     */
    public function canSocietyApply(Society $society, Installment $installment): array
    {
        $reasons = [];

        // Check if society already has an application for this installment
        $existingApplication = InstallmentApplySocieties::where('society_id', $society->id)
            ->where('installment_id', $installment->id)
            ->first();

        if ($existingApplication) {
            $reasons[] = 'Society already has an application for this installment';
        }

        // Check eligibility
        $validationService = new SocietyValidationService();
        $eligibility = $validationService->checkEligibility($society, $installment);

        if (!$eligibility['eligible']) {
            $reasons = array_merge($reasons, $eligibility['errors']);
        }

        return [
            'can_apply' => empty($reasons),
            'reasons' => $reasons
        ];
    }

    /**
     * Trigger workflow after application submission
     */
    private function triggerWorkflow(InstallmentApplySocieties $application): void
    {
        // Auto-approve if society meets all criteria and has good history
        // This is a simplified example - in real implementation, this would be more complex
        $society = $application->society;
        $validationService = new SocietyValidationService();
        $eligibility = $validationService->checkEligibility($society, $application->installment);

        if ($eligibility['eligible'] && empty($eligibility['warnings'])) {
            // Could auto-approve or move to validation stage
            Log::info("Application eligible for fast-track approval: {$application->id}");
        }
    }

    /**
     * Trigger post-approval workflow
     */
    private function triggerPostApprovalWorkflow(InstallmentApplySocieties $application): void
    {
        // Send notifications, update records, etc.
        Log::info("Post-approval workflow triggered for application: {$application->id}");

        // Could integrate with notification service, email service, etc.
    }
}
