<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasOne;

class InstallmentApplySocieties extends Model
{
    use HasFactory;

    /**
     * The table associated with the model.
     *
     * @var string
     */
    protected $table = 'installment_apply_societies';

    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $fillable = [
        'notes',
        'available_month_id',
        'date',
        'society_id',
        'installment_id',
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
     * Get the installment that owns the application.
     */
    public function installment(): BelongsTo
    {
        return $this->belongsTo(Installment::class);
    }

    /**
     * Get the society that owns the application.
     */
    public function society(): BelongsTo
    {
        return $this->belongsTo(Society::class);
    }

    /**
     * Get the available month that owns the application.
     */
    public function availableMonth(): BelongsTo
    {
        return $this->belongsTo(AvailableMonth::class);
    }

    /**
     * Get the status for the application.
     */
    public function status(): HasOne
    {
        return $this->hasOne(InstallmentApplyStatus::class, 'installment_apply_societies_id');
    }
}
