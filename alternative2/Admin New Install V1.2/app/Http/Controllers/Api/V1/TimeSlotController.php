<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use App\Model\TimeSlot;

class TimeSlotController extends Controller
{
    public function getTime_slot()
    {
        try {
            return response()->json(TimeSlot::active()->get(), 200);
        } catch (\Exception $e) {
            return response()->json([], 200);
        }
    }

}
