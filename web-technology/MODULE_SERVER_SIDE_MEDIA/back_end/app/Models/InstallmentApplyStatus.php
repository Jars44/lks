<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class InstallmentApplyStatus extends Model
{
    use HasFactory;

    /**
     * The table associated with the model.
     *
     * @var string
     */
    protected $table = 'installment_apply_status';

    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $fillable = [
        'date',
        'society_id',
        'installment_id',
        'available_month_id',
        'installment_apply_societies_id',
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
            'date' => 'date',
        ];
    }

    public $timestamps = false;

    /**
     * Get the society that owns the status.
     */
    public function society(): BelongsTo
    {
        return $this->belongsTo(Society::class);
    }

    /**
     * Get the installment that owns the status.
     */
    public function installment(): BelongsTo
    {
        return $this->belongsTo(Installment::class);
    }

    /**
     * Get the available month that owns the status.
     */
    public function availableMonth(): BelongsTo
    {
        return $this->belongsTo(AvailableMonth::class);
    }

    /**
     * Get the apply society that owns the status.
     */
    public function applySociety(): BelongsTo
    {
        return $this->belongsTo(InstallmentApplySocieties::class, 'installment_apply_societies_id');
    }
}
