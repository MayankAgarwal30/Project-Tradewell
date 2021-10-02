<?php

namespace App\Http\Controllers\Api\V1\Auth;

use App\CentralLogics\Helpers;
use App\Http\Controllers\Controller;
use App\Mail\EmailVerification;
use App\Model\BusinessSetting;
use App\Model\EmailVerifications;
use App\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Mail;
use Illuminate\Support\Facades\Validator;

class CustomerAuthController extends Controller
{
    public function verify_phone(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'phone' => 'required|min:11|max:14|unique:users'
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => Helpers::error_processor($validator)], 403);
        }

        return response()->json([
            'message' => 'Number is ready to register',
            'otp' => 'inactive'
        ], 200);
    }

    public function check_email(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'email' => 'required|unique:users'
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => Helpers::error_processor($validator)], 403);
        }


        if (BusinessSetting::where(['key'=>'email_verification'])->first()->value){
            $token = rand(1000, 9999);
            DB::table('email_verifications')->insert([
                'email' => $request['email'],
                'token' => $token,
                'created_at' => now(),
                'updated_at' => now(),
            ]);
            Mail::to($request['email'])->send(new EmailVerification($token));

            return response()->json([
                'message' => 'Email is ready to register',
                'token' => 'active'
            ], 200);
        }else{
            return response()->json([
                'message' => 'Email is ready to register',
                'token' => 'inactive'
            ], 200);
        }
    }

    public function verify_email(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'email' => 'required'
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => Helpers::error_processor($validator)], 403);
        }

        $verify = EmailVerifications::where(['email' => $request['email'], 'token' => $request['token']])->first();

        if (isset($verify)) {
            $verify->delete();
            return response()->json([
                'message' => 'Token verified!',
            ], 200);
        }

        return response()->json(['errors' => [
            ['code' => 'token', 'message' => 'Token is not found!']
        ]], 404);
    }

    public function register(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'f_name' => 'required',
            'l_name' => 'required',
            'email' => 'required|unique:users',
            'phone' => 'required|unique:users',
            'password' => 'required|min:6',
        ], [
            'f_name.required' => 'The first name field is required.',
            'l_name.required' => 'The last name field is required.',
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => Helpers::error_processor($validator)], 403);
        }

        $user = User::create([
            'f_name' => $request->f_name,
            'l_name' => $request->l_name,
            'email' => $request->email,
            'phone' => $request->phone,
            'password' => bcrypt($request->password)
        ]);

        $token = $user->createToken('RestaurantCustomerAuth')->accessToken;

        return response()->json(['token' => $token], 200);
    }

    public function login(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'email' => 'required',
            'password' => 'required|min:6'
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => Helpers::error_processor($validator)], 403);
        }

        $data = [
            'email' => $request->email,
            'password' => $request->password
        ];

        if (auth()->attempt($data)) {
            $token = auth()->user()->createToken('RestaurantCustomerAuth')->accessToken;
            return response()->json(['token' => $token], 200);
        } else {
            $errors = [];
            array_push($errors, ['code' => 'auth-001', 'message' => 'Unauthorized.']);
            return response()->json([
                'errors' => $errors
            ], 401);
        }
    }
}
