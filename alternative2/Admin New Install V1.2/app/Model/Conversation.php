<?php

namespace App\Model;

use Illuminate\Database\Eloquent\Model;

class Conversation extends Model
{
    protected $casts = [
        'user_id'    => 'integer',
        'checked'    => 'integer',
        'created_at' => 'datetime',
        'updated_at' => 'datetime',
    ];
}
