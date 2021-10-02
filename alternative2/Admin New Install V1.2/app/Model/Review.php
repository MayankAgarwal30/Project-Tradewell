<?php

namespace App\Model;

use App\User;
use Illuminate\Database\Eloquent\Model;

class Review extends Model
{
    protected $casts = [
        'product_id' => 'integer',
        'status'     => 'integer',
        'user_id'    => 'integer',
        'order_id'   => 'integer',
        'rating'     => 'integer',
        'created_at' => 'datetime',
        'updated_at' => 'datetime',
    ];

    public function product()
    {
        return $this->belongsTo(Product::class);
    }

    public function customer()
    {
        return $this->belongsTo(User::class, 'user_id');
    }
}
