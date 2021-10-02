<?php

namespace App\Http\Controllers\Admin;

use App\CentralLogics\Helpers;
use App\Http\Controllers\Controller;
use App\Model\Admin;
use Brian2694\Toastr\Facades\Toastr;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class SystemController extends Controller
{
    public function dashboard()
    {
        return view('admin-views.dashboard');
    }

    public function restaurant_data()
    {
        $new_order = DB::table('orders')->where(['checked' => 0])->count();
        return response()->json([
            'success' => 1,
            'data' => ['new_order' => $new_order]
        ]);
    }

    public function settings()
    {
        return view('admin-views.settings');
    }

    public function settings_update(Request $request)
    {
        $request->validate([
            'f_name' => 'required',
            'l_name' => 'required',
            'email' => 'required',
            'phone' => 'required',
        ], [
            'f_name.required' => 'First name is required!',
            'l_name.required' => 'Last name is required!',
        ]);

        $admin = Admin::find(auth('admin')->id());

        if ($request->has('image')) {
            $image_name =Helpers::update('admin/', $admin->image, 'png', $request->file('image'));
        } else {
            $image_name = $admin['image'];
        }

        $admin->f_name = $request->f_name;
        $admin->l_name = $request->l_name;
        $admin->email = $request->email;
        $admin->phone = $request->phone;
        $admin->image = $image_name;
        $admin->save();
        Toastr::success('Admin updated successfully!');
        return back();
    }

    public function settings_password_update(Request $request)
    {
        $request->validate([
            'password' => 'required|same:confirm_password|min:8',
            'confirm_password' => 'required',
        ]);

        $admin = Admin::find(auth('admin')->id());
        $admin->password = bcrypt($request['password']);
        $admin->save();
        Toastr::success('Admin password updated successfully!');
        return back();
    }
}
