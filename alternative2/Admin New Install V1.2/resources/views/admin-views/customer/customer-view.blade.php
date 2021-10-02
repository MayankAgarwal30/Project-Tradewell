@extends('layouts.admin.app')

@section('title','Customer Details')

@push('css_or_js')

@endpush

@section('content')
    <div class="content container-fluid">
        <!-- Page Header -->
        <div class="d-print-none pb-2">
            <div class="row align-items-center">
                <div class="col-sm mb-2 mb-sm-0">
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb breadcrumb-no-gutter">
                            <li class="breadcrumb-item">
                                <a class="breadcrumb-link"
                                   href="{{route('admin.customer.list')}}">
                                    {{trans('messages.customers')}}
                                </a>
                            </li>
                            <li class="breadcrumb-item active" aria-current="page">{{trans('messages.customer')}} {{trans('messages.details')}}</li>
                        </ol>
                    </nav>

                    <div class="d-sm-flex align-items-sm-center">
                        <h1 class="page-header-title">{{trans('messages.customer')}} {{trans('messages.id')}} #{{$customer['id']}}</h1>
                        <span class="ml-2 ml-sm-3">
                        <i class="tio-date-range">
                        </i> {{trans('messages.joined_at')}} : {{date('d M Y H:i:s',strtotime($customer['created_at']))}}
                        </span>
                    </div>
                    <div class="row border-top pt-3">
                        <div class="col-12">
                            <a href="{{route('admin.dashboard')}}" class="btn btn-primary">
                                <i class="tio-home-outlined"></i> {{trans('messages.dashboard')}}
                            </a>
                        </div>
                    </div>
                </div>

                <div class="col-sm-auto">
                    <a class="btn btn-icon btn-sm btn-ghost-secondary rounded-circle mr-1"
                       href="{{route('admin.customer.view',[$customer['id']-1])}}"
                       data-toggle="tooltip" data-placement="top" title="Previous customer">
                        <i class="tio-arrow-backward"></i>
                    </a>
                    <a class="btn btn-icon btn-sm btn-ghost-secondary rounded-circle"
                       href="{{route('admin.customer.view',[$customer['id']+1])}}" data-toggle="tooltip"
                       data-placement="top" title="Next customer">
                        <i class="tio-arrow-forward"></i>
                    </a>
                </div>
            </div>
        </div>
        <!-- End Page Header -->

        <div class="row" id="printableArea">
            <div class="col-lg-8 mb-3 mb-lg-0">
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
                                <th style="width: 50%" class="text-center">{{trans('messages.order')}} {{trans('messages.id')}}</th>
                                <th style="width: 50%">{{trans('messages.total')}}</th>
                                <th style="width: 10%">{{trans('messages.action')}}</th>
                            </tr>
                            <tr>
                                <th></th>
                                <th>
                                    <input type="text" id="column1_search" class="form-control form-control-sm"
                                           placeholder="Search ID">
                                </th>
                                <th></th>
                                <th>
                                    {{--<input type="text" id="column4_search" class="form-control form-control-sm"
                                           placeholder="Search countries">--}}
                                </th>
                            </tr>
                            </thead>

                            <tbody>
                            @foreach($orders as $key=>$order)
                                <tr>
                                    <td>{{$key+1}}</td>
                                    <td class="table-column-pl-0 text-center">
                                        <a href="{{route('admin.orders.details',['id'=>$order['id']])}}">{{$order['id']}}</a>
                                    </td>
                                    <td>{{$order['order_amount']." ".\App\CentralLogics\Helpers::currency_symbol()}}</td>
                                    <td>
                                        <!-- Dropdown -->
                                        <div class="dropdown">
                                            <button class="btn btn-outline-secondary dropdown-toggle" type="button"
                                                    id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true"
                                                    aria-expanded="false">
                                                <i class="tio-settings"></i>
                                            </button>
                                            <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                                                <a class="dropdown-item"
                                                   href="{{route('admin.orders.details',['id'=>$order['id']])}}"><i
                                                        class="tio-visible"></i> {{trans('messages.view')}}</a>
                                                <a class="dropdown-item" target="_blank"
                                                   href="{{route('admin.orders.generate-invoice',[$order['id']])}}"><i
                                                        class="tio-download"></i> {{trans('messages.invoice')}}</a>
                                            </div>
                                        </div>
                                        <!-- End Dropdown -->
                                    </td>
                                </tr>
                            @endforeach
                            </tbody>
                        </table>
                        <!-- Footer -->
                        <div class="card-footer">
                            <!-- Pagination -->
                        {!! $orders->links() !!}
                        <!-- End Pagination -->
                        </div>
                        <!-- End Footer -->
                    </div>
                </div>
            </div>

            <div class="col-lg-4">
                <!-- Card -->
                <div class="card">
                    <!-- Header -->
                    <div class="card-header">
                        <h4 class="card-header-title">{{trans('messages.customer')}}</h4>
                    </div>
                    <!-- End Header -->

                    <!-- Body -->
                    @if($customer)
                        <div class="card-body">
                            <div class="media align-items-center" href="javascript:">
                                <div class="avatar avatar-circle mr-3">
                                    <img
                                        class="avatar-img"
                                        onerror="this.src='{{asset('public/assets/admin/img/160x160/img1.jpg')}}'"
                                        src="{{asset('storage/app/public/profile/'.$customer->image)}}"
                                        alt="Image Description">
                                </div>
                                <div class="media-body">
                                <span
                                    class="text-body text-hover-primary">{{$customer['f_name'].' '.$customer['l_name']}}</span>
                                </div>
                                <div class="media-body text-right">
                                    {{--<i class="tio-chevron-right text-body"></i>--}}
                                </div>
                            </div>

                            <hr>

                            <div class="media align-items-center" href="javascript:">
                                <div class="icon icon-soft-info icon-circle mr-3">
                                    <i class="tio-shopping-basket-outlined"></i>
                                </div>
                                <div class="media-body">
                                    <span
                                        class="text-body text-hover-primary">{{$customer->orders->count()}} {{trans('messages.orders')}}</span>
                                </div>
                                <div class="media-body text-right">
                                    {{--<i class="tio-chevron-right text-body"></i>--}}
                                </div>
                            </div>

                            <hr>

                            <div class="d-flex justify-content-between align-items-center">
                                <h5>{{trans('messages.contact')}} {{trans('messages.info')}}</h5>
                            </div>

                            <ul class="list-unstyled list-unstyled-py-2">
                                <li>
                                    <i class="tio-online mr-2"></i>
                                    {{$customer['email']}}
                                </li>
                                <li>
                                    <i class="tio-android-phone-vs mr-2"></i>
                                    {{$customer['phone']}}
                                </li>
                            </ul>

                            <div class="d-flex justify-content-between align-items-center">
                                <h5>{{trans('messages.addresses')}}</h5>
                            </div>

                            @foreach($customer->addresses as $address)
                                <ul class="list-unstyled list-unstyled-py-2">
                                    <li>
                                        <i class="tio-tab mr-2"></i>
                                        {{$address['address_type']}}
                                    </li>
                                    <li>
                                        <i class="tio-android-phone-vs mr-2"></i>
                                        {{$address['contact_person_umber']}}
                                    </li>
                                    <li style="cursor: pointer">
                                        <a target="_blank" href="http://maps.google.com/maps?z=12&t=m&q=loc:{{$address['latitude']}}+{{$address['longitude']}}">
                                            <i class="tio-map mr-2"></i>
                                            {{$address['address']}}
                                        </a>
                                    </li>
                                </ul>
                                <hr>
                            @endforeach

                        </div>
                @endif
                <!-- End Body -->
                </div>
                <!-- End Card -->
            </div>
        </div>
        <!-- End Row -->
    </div>
@endsection

@push('script_2')

    <script>
        $(document).on('ready', function () {
            // INITIALIZATION OF DATATABLES
            // =======================================================
            var datatable = $.HSCore.components.HSDatatables.init($('#columnSearchDatatable'));

            $('#column1_search').on('keyup', function () {
                datatable
                    .columns(1)
                    .search(this.value)
                    .draw();
            });


            $('#column3_search').on('change', function () {
                datatable
                    .columns(2)
                    .search(this.value)
                    .draw();
            });


            // INITIALIZATION OF SELECT2
            // =======================================================
            $('.js-select2-custom').each(function () {
                var select2 = $.HSCore.components.HSSelect2.init($(this));
            });
        });
    </script>
@endpush
