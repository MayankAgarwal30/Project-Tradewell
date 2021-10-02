@extends('layouts.admin.app')

@section('title','Review List')

@push('css_or_js')

@endpush

@section('content')
    <div class="content container-fluid">
        <!-- Page Header -->
        <div class="page-header">
            <div class="row align-items-center">
                <div class="col-sm mb-2 mb-sm-0">
                    <h1 class="page-header-title">{{trans('messages.review')}} {{trans('messages.list')}}</h1>
                </div>
            </div>
        </div>
        <!-- End Page Header -->
        <div class="row gx-2 gx-lg-3">
            <div class="col-sm-12 col-lg-12 mb-3 mb-lg-2">
                <!-- Card -->
                <div class="card">
                    <!-- Header -->
                    <div class="card-header">
                        <h5 class="card-header-title"></h5>
                    </div>
                    <!-- End Header -->

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
                                <th style="width: 30%">{{trans('messages.deliveryman')}}</th>
                                <th style="width: 25%">{{trans('messages.customer')}}</th>
                                <th>{{trans('messages.review')}}</th>
                                <th>{{trans('messages.rating')}}</th>
                            </tr>
                            <tr>
                                <th></th>
                                <th>
                                    {{--<input type="text" id="column1_search" class="form-control form-control-sm"
                                           placeholder="Search">--}}
                                </th>
                                <th></th>
                                <th></th>
                                <th></th>
                            </tr>
                            </thead>

                            <tbody>
                            @foreach($reviews as $key=>$review)
                                @if($review->delivery_man)
                                    <tr>
                                        <td>{{$key+1}}</td>
                                        <td>
                                        <span class="d-block font-size-sm text-body">
                                            <a href="{{route('admin.delivery-man.preview',[$review['delivery_man_id']])}}">
                                                {{$review->delivery_man->f_name.' '.$review->delivery_man->l_name}}
                                            </a>
                                        </span>
                                        </td>
                                        <td>
                                            <a href="{{route('admin.customer.view',[$review->user_id])}}">
                                                {{$review->customer->f_name." ".$review->customer->l_name}}
                                            </a>
                                        </td>
                                        <td>
                                            {{$review->comment}}
                                        </td>
                                        <td>
                                            <label class="badge badge-soft-info">
                                                {{$review->rating}} <i class="tio-star"></i>
                                            </label>
                                        </td>
                                    </tr>
                                @endif
                            @endforeach
                            </tbody>
                        </table>
                        <hr>
                        <table>
                            <tfoot>
                            {!! $reviews->links() !!}
                            </tfoot>
                        </table>
                    </div>
                    <!-- End Table -->
                </div>
                <!-- End Card -->
            </div>
        </div>
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

            $('#column2_search').on('keyup', function () {
                datatable
                    .columns(2)
                    .search(this.value)
                    .draw();
            });

            $('#column3_search').on('change', function () {
                datatable
                    .columns(3)
                    .search(this.value)
                    .draw();
            });

            $('#column4_search').on('keyup', function () {
                datatable
                    .columns(4)
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
