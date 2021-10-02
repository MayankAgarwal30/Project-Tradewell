<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Model\TimeSlot;
use Brian2694\Toastr\Facades\Toastr;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class TimeSlotController extends Controller
{
    public function add_new()
    {
        $timeSlots = TimeSlot::latest()->get();
        return view('admin-views.timeSlot.index', compact('timeSlots'));
    }

    public function store(Request $request)
    {
        $request->validate([

            'start_time' => 'required',
            'end_time'   => 'required|after:start_time',

        ]);

        DB::table('time_slots')->insert([

            'start_time' => $request->start_time,
            'end_time'   => $request->end_time,
            'date'       => date('Y-m-d'),
            'status'     => 1,
            'created_at' => now(),
            'updated_at' => now(),
        ]);

        Toastr::success('TIme Slot added successfully!');
        return back();
    }

    public function edit($id)
    {
        $timeSlots = TimeSlot::where(['id' => $id])->first();
        return view('admin-views.timeSlot.edit', compact('timeSlots'));
    }

    public function update(Request $request, $id)
    {
        $request->validate([

            'start_time' => 'required',
            'end_time'   => 'required|after:start_time',

        ]);

        DB::table('time_slots')->where(['id' => $id])->update([
            'start_time' => $request->start_time,
            'end_time'   => $request->end_time,
            'date'       => date('Y-m-d'),
            'status'     => 1,
            'updated_at' => now(),
        ]);

        Toastr::success('Time Slot updated successfully!');
        return back();
    }

    public function status(Request $request)
    {
        $timeSlot = TimeSlot::find($request->id);
        $timeSlot->status = $request->status;
        $timeSlot->save();
        Toastr::success('TimeSlot status updated!');
        return back();
    }

    public function delete(Request $request)
    {
        $timeSlot = TimeSlot::find($request->id);
        $timeSlot->delete();
        Toastr::success('Time Slot removed!');
        return back();
    }
}
