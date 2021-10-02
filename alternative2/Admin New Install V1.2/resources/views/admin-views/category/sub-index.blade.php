@extends('layouts.admin.app')

@section('title','Add new sub category')

@push('css_or_js')
    <meta name="csrf-token" content="{{ csrf_token() }}">
@endpush

@section('content')
    <div class="content container-fluid">
        <!-- Page Header -->
        <div class="page-header">
            <div class="row align-items-center">
                <div class="col-sm mb-2 mb-sm-0">
                    <h1 class="page-header-title"><i
                            class="tio-add-circle-outlined"></i> {{trans('messages.add')}} {{trans('messages.new')}} {{trans('messages.sub_category')}}
                    </h1>
                </div>
            </div>
        </div>
        <!-- End Page Header -->
        <div class="row gx-2 gx-lg-3">
            <div class="col-sm-12 col-lg-12 mb-3 mb-lg-2">
                <form action="{{route('admin.category.store')}}" method="post">
                    @csrf
                    <div class="row">
                        <div class="col-6">
                            <div class="form-group">
                                <label class="input-label"
                                       for="exampleFormControlSelect1">{{trans('messages.main')}} {{trans('messages.category')}}
                                    <span class="input-label-secondary">*</span></label>
                                <select id="exampleFormControlSelect1" name="parent_id" class="form-control" required>
                                    @foreach(\App\Model\Category::where(['position'=>0])->get() as $category)
                                        <option value="{{$category['id']}}">{{$category['name']}}</option>
                                    @endforeach
                                </select>
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="form-group">
                                <label class="input-label"
                                       for="exampleFormControlInput1">{{trans('messages.name')}}</label>
                                <input type="text" name="name" class="form-control" placeholder="New Sub Category"
                                       required>
                            </div>
                            <input name="position" value="1" style="display: none">
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
                                <th style="width: 50%">{{trans('messages.main')}} {{trans('messages.category')}}</th>
                                <th style="width: 50%">{{trans('messages.sub_category')}}</th>
                                <th style="width: 20%">{{trans('messages.status')}}</th>
                                <th style="width: 10%">{{trans('messages.action')}}</th>
                            </tr>
                            <tr>
                                <th></th>
                                <th>
                                    <form action="javascript:" id="search-form">
                                        <!-- Search -->
                                        <div class="input-group input-group-merge input-group-flush">
                                            <div class="input-group-prepend">
                                                <div class="input-group-text">
                                                    <i class="tio-search"></i>
                                                </div>
                                            </div>
                                            <input id="datatableSearch_" type="search" name="search"
                                                   class="form-control"
                                                   placeholder="Search" aria-label="Search" required>
                                            <button type="submit" class="btn btn-primary">search</button>

                                        </div>
                                        <!-- End Search -->
                                    </form>
                                </th>

                                <th></th>

                                <th>
                                    <select id="column3_search" class="js-select2-custom"
                                            data-hs-select2-options='{
                                              "minimumResultsForSearch": "Infinity",
                                              "customClass": "custom-select custom-select-sm text-capitalize"
                                            }'>
                                        <option value="">{{trans('messages.any')}}</option>
                                        <option value="Active">{{trans('messages.active')}}</option>
                                        <option value="Disabled">{{trans('messages.disabled')}}</option>
                                    </select>
                                </th>
                                <th>
                                    {{--<input type="text" id="column4_search" class="form-control form-control-sm"
                                           placeholder="Search countries">--}}
                                </th>
                            </tr>
                            </thead>

                            <tbody id="set-rows">
                            @foreach($categories as $key=>$category)
                                <tr>
                                    <td>{{$key+1}}</td>
                                    <td>
                                        <span class="d-block font-size-sm text-body">
                                            {{$category->parent['name']}}
                                        </span>
                                    </td>

                                    <td>
                                        <span class="d-block font-size-sm text-body">
                                            {{$category['name']}}
                                        </span>
                                    </td>

                                    <td>
                                        @if($category['status']==1)
                                            <div style="padding: 10px;border: 1px solid;cursor: pointer"
                                                 onclick="location.href='{{route('admin.category.status',[$category['id'],0])}}'">
                                                <span
                                                    class="legend-indicator bg-success"></span>{{trans('messages.active')}}
                                            </div>
                                        @else
                                            <div style="padding: 10px;border: 1px solid;cursor: pointer"
                                                 onclick="location.href='{{route('admin.category.status',[$category['id'],1])}}'">
                                                <span
                                                    class="legend-indicator bg-danger"></span>{{trans('messages.disabled')}}
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
                                                   href="{{route('admin.category.edit',[$category['id']])}}">{{trans('messages.edit')}}</a>
                                                <a class="dropdown-item" href="javascript:"
                                                   onclick="form_alert('category-{{$category['id']}}','Want to delete this category ?')">{{trans('messages.delete')}}</a>
                                                <form action="{{route('admin.category.delete',[$category['id']])}}"
                                                      method="post" id="category-{{$category['id']}}">
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
                        <hr>
                        <div class="page-area">
                            <table>
                                <tfoot>
                                {!! $categories->links() !!}
                                </tfoot>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <!-- End Table -->
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


            // INITIALIZATION OF SELECT2
            // =======================================================
            $('.js-select2-custom').each(function () {
                var select2 = $.HSCore.components.HSSelect2.init($(this));
            });
        });
    </script>

    <script>
        $('#search-form').on('submit', function () {
            var formData = new FormData(this);
            $.ajaxSetup({
                headers: {
                    'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
                }
            });
            $.post({
                url: '{{route('admin.category.search')}}',
                data: formData,
                cache: false,
                contentType: false,
                processData: false,
                beforeSend: function () {
                    $('#loading').show();
                },
                success: function (data) {
                    $('#set-rows').html(data.view);
                    $('.page-area').hide();
                },
                complete: function () {
                    $('#loading').hide();
                },
            });
        });
    </script>
@endpush
