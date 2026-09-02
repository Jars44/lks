<?php

namespace App\Services;

use App\Models\InstallmentApplySocieties;
use App\Models\InstallmentApplyStatus;
use App\Models\Validation as ValidationModel;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;

class WorkflowService
{
    /**
     * Status transition rules
     */
    private const STATUS_TRANSITIONS = [
        'pending' => ['approved', 'rejected', 'under_review'],
        'under_review' => ['approved', 'rejected', 'pending_validation'],
        'pending_validation' => ['approved', 'rejected'],
        'approved' => [], // Final state
        'rejected' => [], // Final state
    ];

    /**
     * Automatic status transitions based on business rules
     */
    private const AUTO_TRANSITIONS = [
        'pending' => [
            'conditions' => ['eligibility_check', 'document_verification'],
            'next_status' => 'under_review'
        ],
        'under_review' => [
            'conditions' => ['validation_complete'],
            'next_status' => 'approved'
        ]
    ];

    /**
     * Transition application status
     */
    public function transitionStatus(InstallmentApplySocieties $application, string $newStatusName, array $context = []): bool
    {
        DB::beginTransaction();
        try {
            $currentStatus = $application->status->name;

            // Validate transition
            if (!$this->isValidTransition($currentStatus, $newStatusName)) {
                throw new \Exception("Invalid status transition from {$currentStatus} to {$newStatusName}");
            }

            // Get new status
            $newStatus = InstallmentApplyStatus::where('name', $newStatusName)->first();
            if (!$newStatus) {
                throw new \Exception("Status '{$newStatusName}' not found");
            }

            // Update status
            $application->update(['status_id' => $newStatus->id]);

            // Trigger post-transition actions
            $this->triggerPostTransitionActions($application, $newStatusName, $context);

            DB::commit();
            Log::info("Status transitioned from {$currentStatus} to {$newStatusName} for application ID: {$application->id}");

            return true;
        } catch (\Exception $e) {
            DB::rollBack();
            Log::error("Status transition failed for application ID: {$application->id}", [
                'from' => $currentStatus ?? 'unknown',
                'to' => $newStatusName,
                'error' => $e->getMessage()
            ]);
            throw $e;
        }
    }

    /**
     * Check if status transition is valid
     */
    public function isValidTransition(string $fromStatus, string $toStatus): bool
    {
        return isset(self::STATUS_TRANSITIONS[$fromStatus]) &&
               in_array($toStatus, self::STATUS_TRANSITIONS[$fromStatus]);
    }

    /**
     * Get available transitions for current status
     */
    public function getAvailableTransitions(string $currentStatus): array
    {
        return self::STATUS_TRANSITIONS[$currentStatus] ?? [];
    }

    /**
     * Process automatic transitions
     */
    public function processAutomaticTransitions(InstallmentApplySocieties $application): void
    {
        $currentStatus = $application->status->name;

        if (!isset(self::AUTO_TRANSITIONS[$currentStatus])) {
            return;
        }

        $transitionRules = self::AUTO_TRANSITIONS[$currentStatus];
        $conditionsMet = true;

        foreach ($transitionRules['conditions'] as $condition) {
            if (!$this->checkCondition($application, $condition)) {
                $conditionsMet = false;
                break;
            }
        }

        if ($conditionsMet) {
            $this->transitionStatus($application, $transitionRules['next_status'], [
                'auto_transition' => true,
                'triggered_by' => $currentStatus
            ]);
        }
    }

    /**
     * Check business rule conditions
     */
    private function checkCondition(InstallmentApplySocieties $application, string $condition): bool
    {
        switch ($condition) {
            case 'eligibility_check':
                $validationService = new SocietyValidationService();
                $eligibility = $validationService->checkEligibility($application->society, $application->installment);
                return $eligibility['eligible'];

            case 'document_verification':
                // Check if required documents are uploaded
                // This would need to be implemented based on actual document model
                return true; // Placeholder

            case 'validation_complete':
                // Check if all required validations are completed
                $validations = ValidationModel::where('installment_id', $application->installment_id)->get();
                return $validations->isNotEmpty() && $validations->every(function ($validation) {
                    return in_array($validation->status, ['approved', 'rejected']);
                });

            default:
                return false;
        }
    }

    /**
     * Trigger post-transition actions
     */
    private function triggerPostTransitionActions(InstallmentApplySocieties $application, string $newStatus, array $context): void
    {
        switch ($newStatus) {
            case 'approved':
                $this->handleApprovalActions($application, $context);
                break;

            case 'rejected':
                $this->handleRejectionActions($application, $context);
                break;

            case 'under_review':
                $this->handleUnderReviewActions($application, $context);
                break;

            case 'pending_validation':
                $this->handlePendingValidationActions($application, $context);
                break;
        }

        // Send notifications
        $this->sendStatusChangeNotification($application, $newStatus);
    }

    /**
     * Handle approval actions
     */
    private function handleApprovalActions(InstallmentApplySocieties $application, array $context): void
    {
        Log::info("Processing approval actions for application: {$application->id}");

        // Create installment contract
        // Send approval notification
        // Update society status
        // Schedule payment reminders
    }

    /**
     * Handle rejection actions
     */
    private function handleRejectionActions(InstallmentApplySocieties $application, array $context): void
    {
        Log::info("Processing rejection actions for application: {$application->id}");

        // Send rejection notification with reason
        // Log rejection metrics
        // Update rejection statistics
    }

    /**
     * Handle under review actions
     */
    private function handleUnderReviewActions(InstallmentApplySocieties $application, array $context): void
    {
        Log::info("Processing under review actions for application: {$application->id}");

        // Assign to validator
        // Send review notification
        // Set review deadline
    }

    /**
     * Handle pending validation actions
     */
    private function handlePendingValidationActions(InstallmentApplySocieties $application, array $context): void
    {
        Log::info("Processing pending validation actions for application: {$application->id}");

        // Notify validators
        // Create validation tasks
        // Set validation deadline
    }

    /**
     * Send status change notification
     */
    private function sendStatusChangeNotification(InstallmentApplySocieties $application, string $newStatus): void
    {
        // Implementation would depend on notification system
        Log::info("Status change notification sent for application {$application->id}: {$newStatus}");
    }

    /**
     * Get workflow statistics
     */
    public function getWorkflowStatistics(): array
    {
        $stats = [];

        foreach (array_keys(self::STATUS_TRANSITIONS) as $status) {
            $count = InstallmentApplySocieties::whereHas('status', function ($query) use ($status) {
                $query->where('name', $status);
            })->count();

            $stats[$status] = $count;
        }

        return $stats;
    }
}
