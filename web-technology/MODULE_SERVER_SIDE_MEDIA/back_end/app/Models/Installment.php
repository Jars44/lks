<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;

class Installment extends Model
{
    use HasFactory;

    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $fillable = [
        'brand_id',
        'society_id',
        'name',
        'description',
        'total_amount',
        'down_payment',
        'monthly_installment',
        'interest_rate',
        'tenure_months',
        'start_date',
        'end_date',
        'status',
    ];

    /**
     * The attributes that should be hidden for serialization.
     *
     * @var array<int, string>
     */
    protected $hidden = [
        //
    ];

    /**
     * Get the attributes that should be cast.
     *
     * @return array<string, string>
     */
    protected function casts(): array
    {
        return [
            'total_amount' => 'decimal:2',
            'down_payment' => 'decimal:2',
            'monthly_installment' => 'decimal:2',
            'interest_rate' => 'decimal:2',
            'start_date' => 'date',
            'end_date' => 'date',
        ];
    }

    /**
     * Get the brand that owns the installment.
     */
    public function brand(): BelongsTo
    {
        return $this->belongsTo(Brand::class);
    }

    /**
     * Get the society that owns the installment.
     */
    public function society(): BelongsTo
    {
        return $this->belongsTo(Society::class);
    }

    /**
     * Get the available months for the installment.
     */
    public function availableMonths(): HasMany
    {
        return $this->hasMany(AvailableMonth::class);
    }

    /**
     * The societies that applied for the installment.
     */
    public function appliedSocieties(): BelongsToMany
    {
        return $this->belongsToMany(Society::class, 'installment_apply_societies')
                    ->withPivot('status_id', 'applied_at')
                    ->withTimestamps();
    }

    /**
     * Get the validations for the installment.
     */
    public function validations(): HasMany
    {
        return $this->hasMany(Validation::class);
    }
}
