@extends('layouts.admin.app')

@section('title','Update Time Slot')

@push('css_or_js')

@endpush

@section('content')
    <div class="content container-fluid">
        <!-- Page Header -->
        <div class="page-header">
            <div class="row align-items-center">
                <div class="col-sm mb-2 mb-sm-0">
                    <h1 class="page-header-title">{{trans('messages.Time Slot')}} {{trans('messages.update')}}  </h1>
                </div>
            </div>
        </div>
        <!-- End Page Header -->
        <div class="row gx-2 gx-lg-3">
            <div class="col-sm-12 col-lg-12 mb-3 mb-lg-2">
                <form action="{{route('admin.timeSlot.update',[$timeSlots['id']])}}" method="post">
                    @csrf
                  

                    <div class="row">
                     
                        <div class="col-6">
                            <div class="form-group">
                                <label class="input-label" for="exampleFormControlInput1">{{trans('messages.Time')}} {{trans('messages.Start')}}</label>
                                <input type="time" value="{{$timeSlots['start_time']}}" name="start_time" class="form-control">
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="form-group">
                                <label class="input-label" for="exampleFormControlInput1">{{trans('messages.Time')}} {{trans('messages.Ends')}}</label>
                                <input type="time" value="{{$timeSlots['end_time']}}" name="end_time" class="form-control">
                            </div>
                        </div>
                    </div>

                  
                    <button type="submit" class="btn btn-primary">{{trans('messages.update')}}</button>
                </form>
            </div>
            <!-- End Table -->
        </div>
    </div>

@endsection

@push('script_2')

@endpush
