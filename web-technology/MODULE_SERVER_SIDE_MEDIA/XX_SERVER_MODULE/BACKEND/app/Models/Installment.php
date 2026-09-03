<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

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
        'cars',
        'description',
        'price',
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
        return [];
    }

    protected $table = 'installment';

    public $timestamps = false;

    /**
     * Get the brand that owns the installment.
     */
    public function brand(): BelongsTo
    {
        return $this->belongsTo(Brand::class);
    }

    /**
     * Get the available months for the installment.
     */
    public function availableMonths(): HasMany
    {
        return $this->hasMany(AvailableMonth::class);
    }

    /**
     * Get the apply societies for the installment.
     */
    public function applySocieties(): HasMany
    {
        return $this->hasMany(InstallmentApplySocieties::class);
    }
}
