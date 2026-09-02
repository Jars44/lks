<?php

namespace App\Services;

use App\Models\Society;
use App\Models\Validation as ValidationModel;
use App\Models\Validator;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;

class SocietyValidationService
{
    /**
     * Validate society for installment application
     */
    public function validateSociety(Society $society, array $validationData): ValidationModel
    {
        DB::beginTransaction();
        try {
            // Create validation record
            $validation = ValidationModel::create([
                'installment_id' => $validationData['installment_id'],
                'validator_id' => $validationData['validator_id'],
                'status' => $validationData['status'],
                'notes' => $validationData['notes'] ?? null,
                'validated_at' => now(),
            ]);

            // Update society status if validation is approved
            if ($validationData['status'] === 'approved') {
                $this->updateSocietyValidationStatus($society, 'validated');
            } elseif ($validationData['status'] === 'rejected') {
                $this->updateSocietyValidationStatus($society, 'rejected');
            }

            DB::commit();
            Log::info("Society validation completed for society ID: {$society->id}");

            return $validation;
        } catch (\Exception $e) {
            DB::rollBack();
            Log::error("Society validation failed for society ID: {$society->id}", [
                'error' => $e->getMessage(),
                'validation_data' => $validationData
            ]);
            throw $e;
        }
    }

    /**
     * Check if society meets eligibility criteria
     */
    public function checkEligibility(Society $society, $installment): array
    {
        $errors = [];
        $warnings = [];

        // Check if society has required information
        if (empty($society->name)) {
            $errors[] = 'Society name is required';
        }

        if (empty($society->email)) {
            $errors[] = 'Society email is required';
        }

        if (empty($society->phone)) {
            $errors[] = 'Society phone is required';
        }

        // Check if society belongs to a regional
        if (!$society->regional) {
            $errors[] = 'Society must belong to a regional';
        }

        // Check installment specific requirements
        if ($installment) {
            // Check if down payment is affordable (assuming society has income data)
            // This would need to be implemented based on actual business rules
            if (isset($society->monthly_income) && $installment->down_payment > ($society->monthly_income * 3)) {
                $warnings[] = 'Down payment exceeds 3 months income';
            }

            // Check tenure vs available months
            if ($installment->tenure_months > 60) { // Example: max 5 years
                $errors[] = 'Installment tenure exceeds maximum allowed period';
            }

            // Check if installment is still available
            if ($installment->end_date && $installment->end_date->isPast()) {
                $errors[] = 'Installment application period has ended';
            }

            // Check minimum down payment percentage
            $minDownPaymentPercent = 10; // 10%
            $requiredDownPayment = ($installment->total_amount * $minDownPaymentPercent) / 100;
            if ($installment->down_payment < $requiredDownPayment) {
                $errors[] = "Down payment must be at least {$minDownPaymentPercent}% of total amount";
            }
        }

        return [
            'eligible' => empty($errors),
            'errors' => $errors,
            'warnings' => $warnings
        ];
    }

    /**
     * Update society validation status
     */
    private function updateSocietyValidationStatus(Society $society, string $status): void
    {
        // Assuming Society model has a validation_status field
        // If not, this would need to be added or handled differently
        if (isset($society->validation_status)) {
            $society->update(['validation_status' => $status]);
        }

        Log::info("Society validation status updated to {$status} for society ID: {$society->id}");
    }

    /**
     * Get validation history for a society
     */
    public function getValidationHistory(Society $society): \Illuminate\Database\Eloquent\Collection
    {
        return ValidationModel::whereHas('installment.appliedSocieties', function ($query) use ($society) {
            $query->where('society_id', $society->id);
        })->with(['installment', 'validator.user'])->get();
    }

    /**
     * Get pending validations for a validator
     */
    public function getPendingValidations(Validator $validator): \Illuminate\Database\Eloquent\Collection
    {
        return ValidationModel::where('validator_id', $validator->id)
            ->where('status', 'pending')
            ->with(['installment.appliedSocieties.society'])
            ->get();
    }
}
