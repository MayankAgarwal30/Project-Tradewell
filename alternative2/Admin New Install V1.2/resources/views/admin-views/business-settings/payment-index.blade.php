@extends('layouts.admin.app')

@section('title','Payment Setup')

@push('css_or_js')

@endpush

@section('content')
    <div class="content container-fluid">
        <!-- Page Header -->
        <div class="page-header">
            <div class="row align-items-center">
                <div class="col-sm mb-2 mb-sm-0">
                    <h1 class="page-header-title">{{trans('messages.payment')}} {{trans('messages.gateway')}} {{trans('messages.setup')}}</h1>
                </div>
            </div>
        </div>
        <!-- End Page Header -->
        <div class="row" style="padding-bottom: 20px">
            <div class="col-md-6">
                <div class="card">
                    <div class="card-body" style="padding: 20px">
                        <h5 class="text-center">{{trans('messages.payment')}} {{trans('messages.method')}}</h5>
                        @php($config=\App\CentralLogics\Helpers::get_business_settings('cash_on_delivery'))
                        <form action="{{route('admin.business-settings.payment-method-update',['cash_on_delivery'])}}"
                              method="post">
                            @csrf
                            @if(isset($config))
                                <div class="form-group mb-2">
                                    <label class="control-label">{{trans('messages.cash_on_delivery')}}</label>
                                </div>
                                <div class="form-group mb-2 mt-2">
                                    <input type="radio" name="status" value="1" {{$config['status']==1?'checked':''}}>
                                    <label style="padding-left: 10px">{{trans('messages.active')}}</label>
                                    <br>
                                </div>
                                <div class="form-group mb-2">
                                    <input type="radio" name="status" value="0" {{$config['status']==0?'checked':''}}>
                                    <label
                                        style="padding-left: 10px">{{trans('messages.inactive')}}</label>
                                    <br>
                                </div>
                                <button type="submit" class="btn btn-primary mb-2">{{trans('messages.save')}}</button>
                            @else
                                <button type="submit" class="btn btn-primary mb-2">{{trans('messages.configure')}}</button>
                            @endif
                        </form>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="card">
                    <div class="card-body" style="padding: 20px">
                        <h5 class="text-center">{{trans('messages.payment')}} {{trans('messages.method')}}</h5>
                        @php($config=\App\CentralLogics\Helpers::get_business_settings('digital_payment'))
                        <form action="{{route('admin.business-settings.payment-method-update',['digital_payment'])}}"
                              method="post">
                            @csrf
                            @if(isset($config))
                                <div class="form-group mb-2">
                                    <label class="control-label">{{trans('messages.digital')}} {{trans('messages.payment')}}</label>
                                </div>
                                <div class="form-group mb-2 mt-2">
                                    <input type="radio" name="status" value="1" {{$config['status']==1?'checked':''}}>
                                    <label style="padding-left: 10px">{{trans('messages.active')}}</label>
                                    <br>
                                </div>
                                <div class="form-group mb-2">
                                    <input type="radio" name="status" value="0" {{$config['status']==0?'checked':''}}>
                                    <label
                                        style="padding-left: 10px">{{trans('messages.inactive')}}</label>
                                    <br>
                                </div>
                                <button type="submit" class="btn btn-primary mb-2">{{trans('messages.save')}}</button>
                            @else
                                <button type="submit" class="btn btn-primary mb-2">{{trans('messages.configure')}}</button>
                            @endif
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <div class="row" style="padding-bottom: 20px">
            <div class="col-md-6">
                <div class="card">
                    <div class="card-body" style="padding: 20px">
                        <h5 class="text-center">{{trans('messages.sslcommerz')}}</h5>
                        @php($config=\App\CentralLogics\Helpers::get_business_settings('ssl_commerz_payment'))
                        <form
                            action="{{env('APP_MODE')!='demo'?route('admin.business-settings.payment-method-update',['ssl_commerz_payment']):'javascript:'}}"
                            method="post">
                            @csrf
                            @if(isset($config))
                                <div class="form-group mb-2">
                                    <label
                                        class="control-label">{{trans('messages.sslcommerz')}} {{trans('messages.payment')}}</label>
                                </div>
                                <div class="form-group mb-2 mt-2">
                                    <input type="radio" name="status" value="1" {{$config['status']==1?'checked':''}}>
                                    <label style="padding-left: 10px">{{trans('messages.active')}}</label>
                                    <br>
                                </div>
                                <div class="form-group mb-2">
                                    <input type="radio" name="status" value="0" {{$config['status']==0?'checked':''}}>
                                    <label
                                        style="padding-left: 10px">{{trans('messages.inactive')}}</label>
                                    <br>
                                </div>
                                <div class="form-group mb-2">
                                    <label
                                        style="padding-left: 10px">{{trans('messages.store')}} {{trans('messages.id')}} </label><br>
                                    <input type="text" class="form-control" name="store_id"
                                           value="{{env('APP_MODE')!='demo'?$config['store_id']:''}}">
                                </div>
                                <div class="form-group mb-2">
                                    <label
                                        style="padding-left: 10px">{{trans('messages.store')}} {{trans('messages.password')}}</label><br>
                                    <input type="text" class="form-control" name="store_password"
                                           value="{{env('APP_MODE')!='demo'?$config['store_password']:''}}">
                                </div>
                                <button type="{{env('APP_MODE')!='demo'?'submit':'button'}}"
                                        onclick="{{env('APP_MODE')!='demo'?'':'call_demo()'}}"
                                        class="btn btn-primary mb-2">{{trans('messages.save')}}</button>
                            @else
                                <button type="submit"
                                        class="btn btn-primary mb-2">{{trans('messages.configure')}}</button>
                            @endif
                        </form>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="card">
                    <div class="card-body" style="padding: 20px">
                        <h5 class="text-center">{{trans('messages.razorpay')}}</h5>
                        @php($config=\App\CentralLogics\Helpers::get_business_settings('razor_pay'))
                        <form
                            action="{{env('APP_MODE')!='demo'?route('admin.business-settings.payment-method-update',['razor_pay']):'javascript:'}}"
                            method="post">
                            @csrf
                            @if(isset($config))
                                <div class="form-group mb-2">
                                    <label class="control-label">{{trans('messages.razorpay')}}</label>
                                </div>
                                <div class="form-group mb-2 mt-2">
                                    <input type="radio" name="status" value="1" {{$config['status']==1?'checked':''}}>
                                    <label style="padding-left: 10px">{{trans('messages.active')}}</label>
                                    <br>
                                </div>
                                <div class="form-group mb-2">
                                    <input type="radio" name="status" value="0" {{$config['status']==0?'checked':''}}>
                                    <label
                                        style="padding-left: 10px">{{trans('messages.inactive')}}</label>
                                    <br>
                                </div>
                                <div class="form-group mb-2">
                                    <label style="padding-left: 10px">{{trans('messages.razorkey')}}</label><br>
                                    <input type="text" class="form-control" name="razor_key"
                                           value="{{env('APP_MODE')!='demo'?$config['razor_key']:''}}">
                                </div>
                                <div class="form-group mb-2">
                                    <label style="padding-left: 10px">{{trans('messages.razorsecret')}}</label><br>
                                    <input type="text" class="form-control" name="razor_secret"
                                           value="{{env('APP_MODE')!='demo'?$config['razor_secret']:''}}">
                                </div>
                                <button type="{{env('APP_MODE')!='demo'?'submit':'button'}}"
                                        onclick="{{env('APP_MODE')!='demo'?'':'call_demo()'}}"
                                        class="btn btn-primary mb-2">{{trans('messages.save')}}</button>
                            @else
                                <button type="submit"
                                        class="btn btn-primary mb-2">{{trans('messages.configure')}}</button>
                            @endif
                        </form>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="card">
                    <div class="card-body" style="padding: 20px">
                        <h5 class="text-center">{{trans('messages.paypal')}}</h5>
                        @php($config=\App\CentralLogics\Helpers::get_business_settings('paypal'))
                        <form
                            action="{{env('APP_MODE')!='demo'?route('admin.business-settings.payment-method-update',['paypal']):'javascript:'}}"
                            method="post">
                            @csrf
                            @if(isset($config))
                                <div class="form-group mb-2">
                                    <label class="control-label">{{trans('messages.paypal')}}</label>
                                </div>
                                <div class="form-group mb-2 mt-2">
                                    <input type="radio" name="status" value="1" {{$config['status']==1?'checked':''}}>
                                    <label style="padding-left: 10px">{{trans('messages.active')}}</label>
                                    <br>
                                </div>
                                <div class="form-group mb-2">
                                    <input type="radio" name="status" value="0" {{$config['status']==0?'checked':''}}>
                                    <label style="padding-left: 10px">{{trans('messages.inactive')}}</label>
                                    <br>
                                </div>
                                <div class="form-group mb-2">
                                    <label
                                        style="padding-left: 10px">{{trans('messages.paypal')}} {{trans('messages.client')}} {{trans('messages.id')}}</label><br>
                                    <input type="text" class="form-control" name="paypal_client_id"
                                           value="{{env('APP_MODE')!='demo'?$config['paypal_client_id']:''}}">
                                </div>
                                <div class="form-group mb-2">
                                    <label style="padding-left: 10px">{{trans('messages.paypalsecret')}} </label><br>
                                    <input type="text" class="form-control" name="paypal_secret"
                                           value="{{env('APP_MODE')!='demo'?$config['paypal_secret']:''}}">
                                </div>
                                <button type="{{env('APP_MODE')!='demo'?'submit':'button'}}"
                                        onclick="{{env('APP_MODE')!='demo'?'':'call_demo()'}}"
                                        class="btn btn-primary mb-2">{{trans('messages.save')}}</button>
                            @else
                                <button type="submit"
                                        class="btn btn-primary mb-2">{{trans('messages.configure')}}</button>
                            @endif
                        </form>
                    </div>
                </div>
            </div>
            <div class="col-md-6 pt-4">
                <div class="card">
                    <div class="card-body" style="padding: 20px">
                        <h5 class="text-center">{{trans('messages.stripe')}}</h5>
                        @php($config=\App\CentralLogics\Helpers::get_business_settings('stripe'))
                        <form action="{{env('APP_MODE')!='demo'?route('admin.business-settings.payment-method-update',['stripe']):'javascript:'}}"
                              method="post">
                            @csrf
                            @if(isset($config))
                                <div class="form-group mb-2">
                                    <label class="control-label">{{trans('messages.stripe')}}</label>
                                </div>
                                <div class="form-group mb-2 mt-2">
                                    <input type="radio" name="status" value="1" {{$config['status']==1?'checked':''}}>
                                    <label style="padding-left: 10px">{{trans('messages.active')}}</label>
                                    <br>
                                </div>
                                <div class="form-group mb-2">
                                    <input type="radio" name="status" value="0" {{$config['status']==0?'checked':''}}>
                                    <label style="padding-left: 10px">{{trans('messages.inactive')}} </label>
                                    <br>
                                </div>
                                <div class="form-group mb-2">
                                    <label
                                        style="padding-left: 10px">{{trans('messages.published')}} {{trans('messages.key')}}</label><br>
                                    <input type="text" class="form-control" name="published_key"
                                           value="{{env('APP_MODE')!='demo'?$config['published_key']:''}}">
                                </div>

                                <div class="form-group mb-2">
                                    <label
                                        style="padding-left: 10px">{{trans('messages.api')}} {{trans('messages.key')}}</label><br>
                                    <input type="text" class="form-control" name="api_key"
                                           value="{{env('APP_MODE')!='demo'?$config['api_key']:''}}">
                                </div>
                                <button type="{{env('APP_MODE')!='demo'?'submit':'button'}}" onclick="{{env('APP_MODE')!='demo'?'':'call_demo()'}}" class="btn btn-primary mb-2">{{trans('messages.save')}}</button>
                            @else
                                <button type="submit"
                                        class="btn btn-primary mb-2">{{trans('messages.configure')}}</button>
                            @endif
                        </form>
                    </div>
                </div>
            </div>
            <div class="col-md-6 pt-4">
                <div class="card">
                    <div class="card-body" style="padding: 20px">
                        <h5 class="text-center">{{trans('messages.senang')}} {{trans('messages.pay')}}</h5>
                        @php($config=\App\CentralLogics\Helpers::get_business_settings('senang_pay'))
                        <form action="{{env('APP_MODE')!='demo'?route('admin.business-settings.payment-method-update',['senang_pay']):'javascript:'}}"
                              method="post">
                            @csrf
                            @if(isset($config))
                                <div class="form-group mb-2">
                                    <label class="control-label">{{trans('messages.senang')}} {{trans('messages.pay')}}</label>
                                </div>
                                <div class="form-group mb-2 mt-2">
                                    <input type="radio" name="status" value="1" {{$config['status']==1?'checked':''}}>
                                    <label style="padding-left: 10px">{{trans('messages.active')}}</label>
                                    <br>
                                </div>
                                <div class="form-group mb-2">
                                    <input type="radio" name="status" value="0" {{$config['status']==0?'checked':''}}>
                                    <label style="padding-left: 10px">{{trans('messages.inactive')}} </label>
                                    <br>
                                </div>
                                <div class="form-group mb-2">
                                    <label
                                        style="padding-left: 10px">{{trans('messages.secret')}} {{trans('messages.key')}}</label><br>
                                    <input type="text" class="form-control" name="secret_key"
                                           value="{{env('APP_MODE')!='demo'?$config['secret_key']:''}}">
                                </div>

                                <div class="form-group mb-2">
                                     <label
                                        style="padding-left: 10px">{{trans('messages.merchant')}} {{trans('messages.id')}}</label><br>
                                    <input type="text" class="form-control" name="merchant_id"
                                           value="{{env('APP_MODE')!='demo'?$config['merchant_id']:''}}">
                                </div>
                                <button type="{{env('APP_MODE')!='demo'?'submit':'button'}}" onclick="{{env('APP_MODE')!='demo'?'':'call_demo()'}}" class="btn btn-primary mb-2">{{trans('messages.save')}}</button>
                            @else
                                <button type="submit"
                                        class="btn btn-primary mb-2">{{trans('messages.configure')}}</button>
                            @endif
                        </form>
                    </div>
                </div>
            </div>
            <div class="col-md-6" style="margin-top: 26px!important;">
                <div class="card">
                    <div class="card-body" style="padding: 20px">
                        <h5 class="text-center">{{trans('messages.paystack')}}</h5>
                        @php($config=\App\CentralLogics\Helpers::get_business_settings('paystack'))
                        <form
                            action="{{env('APP_MODE')!='demo'?route('admin.business-settings.payment-method-update',['paystack']):'javascript:'}}"
                            method="post">
                            @csrf
                            @if(isset($config))
                                <div class="form-group mb-2">
                                    <label class="control-label">{{trans('messages.paystack')}}</label>
                                </div>
                                <div class="form-group mb-2 mt-2">
                                    <input type="radio" name="status" value="1" {{$config['status']==1?'checked':''}}>
                                    <label style="padding-left: 10px">{{trans('messages.active')}}</label>
                                    <br>
                                </div>
                                <div class="form-group mb-2">
                                    <input type="radio" name="status" value="0" {{$config['status']==0?'checked':''}}>
                                    <label style="padding-left: 10px">{{trans('messages.inactive')}}</label>
                                    <br>
                                </div>
                                <div class="form-group mb-2">
                                    <label
                                        style="padding-left: 10px">{{trans('messages.publicKey')}}</label><br>
                                    <input type="text" class="form-control" name="publicKey"
                                           value="{{env('APP_MODE')!='demo'?$config['publicKey']:''}}">
                                </div>
                                <div class="form-group mb-2">
                                    <label style="padding-left: 10px">{{trans('messages.secretKey')}} </label><br>
                                    <input type="text" class="form-control" name="secretKey"
                                           value="{{env('APP_MODE')!='demo'?$config['secretKey']:''}}">
                                </div>
                                <div class="form-group mb-2">
                                    <label style="padding-left: 10px">{{trans('messages.paymentUrl')}} </label><br>
                                    <input type="text" class="form-control" name="paymentUrl"
                                           value="{{env('APP_MODE')!='demo'?$config['paymentUrl']:''}}">
                                </div>
                                <div class="form-group mb-2">
                                    <label style="padding-left: 10px">{{trans('messages.merchantEmail')}} </label><br>
                                    <input type="text" class="form-control" name="merchantEmail"
                                           value="{{env('APP_MODE')!='demo'?$config['merchantEmail']:''}}">
                                </div>
                                <button type="{{env('APP_MODE')!='demo'?'submit':'button'}}"
                                        onclick="{{env('APP_MODE')!='demo'?'':'call_demo()'}}"
                                        class="btn btn-primary mb-2">{{trans('messages.save')}}</button>
                            @else
                                <button type="submit"
                                        class="btn btn-primary mb-2">{{trans('messages.configure')}}</button>
                            @endif
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
@endsection

@push('script_2')

@endpush
