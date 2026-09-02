<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;

class Society extends Model
{
    use HasFactory;

    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $fillable = [
        'name',
        'address',
        'phone',
        'email',
        'regional_id',
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
            //
        ];
    }

    /**
     * Get the regional that owns the society.
     */
    public function regional(): BelongsTo
    {
        return $this->belongsTo(Regional::class);
    }

    /**
     * Get the installments for the society.
     */
    public function installments(): HasMany
    {
        return $this->hasMany(Installment::class);
    }

    /**
     * The installments that belong to the society through application.
     */
    public function appliedInstallments(): BelongsToMany
    {
        return $this->belongsToMany(Installment::class, 'installment_apply_societies')
                    ->withPivot('status_id', 'applied_at')
                    ->withTimestamps();
    }
}
