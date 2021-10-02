@extends('layouts.admin.app')

@section('title','Add new Time Slot')

@push('css_or_js')

@endpush

@section('content')
    <div class="content container-fluid">
        <!-- Page Header -->
        <div class="page-header">
            <div class="row align-items-center">
                <div class="col-sm mb-2 mb-sm-0">
                    <h1 class="page-header-title">{{trans('messages.Time Slot')}}</h1>
                </div>
            </div>
        </div>
        <!-- End Page Header -->
        <div class="row gx-2 gx-lg-3">
            <div class="col-sm-12 col-lg-12 mb-3 mb-lg-2">
                <form action="{{route('admin.timeSlot.store')}}" method="post">
                    @csrf
                    <div class="row">
                        <div class="col-6">
                            <div class="form-group">
                                <label class="input-label" for="exampleFormControlInput1"> {{trans('messages.Time')}} {{trans('messages.Start')}} </label>
                                <input type="time" name="start_time" class="form-control" value="10:30:00"
                                       placeholder="Ex : 10:30 am" required>
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="form-group">
                                <label class="input-label" for="exampleFormControlInput1"> {{trans('messages.Time')}} {{trans('messages.Ends')}} </label>
                                <input type="time" name="end_time" class="form-control" value="19:30:00" placeholder="5:45 pm"
                                       required>
                            </div>
                        </div>
                    </div>

                    <button type="submit" class="btn btn-primary">{{trans('messages.submit')}}</button>
                </form>
            </div>

            <div class="col-sm-12 col-lg-12 mb-3 mb-lg-2">
                <hr>
                <div class="card">
                    <div class="card-header">
                        <h5 class="card-header-title"></h5>
                    </div>
                    <!-- Table -->
                    <div class="table-responsive datatable-custom">
                        <table id="columnSearchDatatable"
                               class="table table-borderless table-thead-bordered table-nowrap table-align-middle card-table"
                               data-hs-datatables-options='{
                                 "order": [],
                                 "orderCellsTop": true
                               }'>
                            <thead class="thead-light">
                            <tr>
                                <th>{{trans('messages.#')}}</th>

                                <th class="text-center">{{trans('messages.Start')}} {{trans('messages.Time')}} </th>
                                <th class="text-center">{{trans('messages.End')}} {{trans('messages.Time')}}  </th>
                                <th>{{trans('messages.status')}}</th>
                                <th style="width: 100px">{{trans('messages.action')}}</th>
                            </tr>
                            </thead>

                            <tbody>
                            @foreach($timeSlots as $key=>$timeSlot)
                                <tr>
                                    <td>{{$key+1}}</td>


                                    <td class="text-center" ><input style="background: white !important; border: none !important; " type="time" value="{{$timeSlot['start_time']}}" disabled> </td>
                                    <td class="text-center" ><input  style="background: white !important; border: none !important; "type="time" value="{{$timeSlot['end_time']}}" disabled></td>
                                    <td>
                                        @if($timeSlot['status']==1)
                                            <div style="padding: 10px;border: 1px solid;cursor: pointer"
                                                 onclick="location.href='{{route('admin.timeSlot.status',[$timeSlot['id'],0])}}'">
                                                <span class="legend-indicator bg-success"></span>{{trans('messages.active')}}
                                            </div>
                                        @else
                                            <div style="padding: 10px;border: 1px solid;cursor: pointer"
                                                 onclick="location.href='{{route('admin.timeSlot.status',[$timeSlot['id'],1])}}'">
                                                <span class="legend-indicator bg-danger"></span>{{trans('messages.disabled')}}
                                            </div>
                                        @endif
                                    </td>
                                    <td>
                                        <!-- Dropdown -->
                                        <div class="dropdown">
                                            <button class="btn btn-secondary dropdown-toggle" type="button"
                                                    id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true"
                                                    aria-expanded="false">
                                                <i class="tio-settings"></i>
                                            </button>
                                            <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                                                <a class="dropdown-item"
                                                   href="{{route('admin.timeSlot.update',[$timeSlot['id']])}}">{{trans('messages.edit')}}</a>
                                                <a class="dropdown-item" href="javascript:"
                                                onclick="form_alert('timeSlot-{{$timeSlot['id']}}','Want to delete this Time Slot')">{{trans('messages.delete')}}  </a>
                                                <form action="{{route('admin.timeSlot.delete',[$timeSlot['id']])}}"
                                                      method="post" id="timeSlot-{{$timeSlot['id']}}">
                                                    @csrf @method('delete')
                                                </form>
                                            </div>
                                        </div>
                                        <!-- End Dropdown -->
                                    </td>
                                </tr>
                            @endforeach
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <!-- End Table -->
        </div>
    </div>

@endsection

@push('script_2')

@endpush
