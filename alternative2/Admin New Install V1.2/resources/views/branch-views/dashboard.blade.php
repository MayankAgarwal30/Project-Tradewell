@extends('layouts.branch.app')

@section('title','Dashboard')

@push('css_or_js')

@endpush

@section('content')
    <div class="content container-fluid">
        <!-- Page Header -->
        <div class="page-header">
            <div class="row align-items-center">
                <div class="col-sm mb-2 mb-sm-0">
                    <h1 class="page-header-title">{{trans('messages.dashboard')}}</h1>
                </div>
            </div>
        </div>
        <!-- End Page Header -->

        <!-- Card -->
        <div class="card card-body mb-3 mb-lg-5">
            <div class="row gx-lg-4">
                <div class="col-sm-6 col-lg-3">
                    <div class="media" style="cursor: pointer" onclick="location.href='{{route('branch.orders.list',['pending'])}}'">
                        <div class="media-body">
                            <h6 class="card-subtitle">{{trans('messages.pending')}}</h6>
                            <span class="card-title h3">{{\App\Model\Order::where(['order_status'=>'pending','branch_id'=>auth('branch')->id()])->count()}}</span>
                        </div>
                        <span class="icon icon-sm icon-soft-secondary icon-circle ml-3">
                          <i class="tio-airdrop"></i>
                        </span>
                    </div>
                    <div class="d-lg-none">
                        <hr>
                    </div>
                </div>

                <div class="col-sm-6 col-lg-3 column-divider-sm">
                    <div class="media" style="cursor: pointer" onclick="location.href='{{route('branch.orders.list',['confirmed'])}}'">
                        <div class="media-body">
                            <h6 class="card-subtitle">{{trans('messages.confirmed')}}</h6>
                            <span class="card-title h3">{{\App\Model\Order::where(['order_status'=>'confirmed','branch_id'=>auth('branch')->id()])->count()}}</span>
                        </div>
                        <span class="icon icon-sm icon-soft-secondary icon-circle ml-3">
                          <i class="tio-checkmark-circle"></i>
                        </span>
                    </div>
                    <div class="d-lg-none">
                        <hr>
                    </div>
                </div>

                <div class="col-sm-6 col-lg-3 column-divider-lg">
                    <div class="media" style="cursor: pointer" onclick="location.href='{{route('branch.orders.list',['processing'])}}'">
                        <div class="media-body">
                            <h6 class="card-subtitle">{{trans('messages.processing')}}</h6>
                            <span class="card-title h3">{{\App\Model\Order::where(['order_status'=>'processing','branch_id'=>auth('branch')->id()])->count()}}</span>
                        </div>
                        <span class="icon icon-sm icon-soft-secondary icon-circle ml-3">
                          <i class="tio-running"></i>
                        </span>
                    </div>
                    <div class="d-lg-none">
                        <hr>
                    </div>
                </div>

                <div class="col-sm-6 col-lg-3 column-divider-sm">
                    <div class="media" style="cursor: pointer" onclick="location.href='{{route('branch.orders.list',['out_for_delivery'])}}'">
                        <div class="media-body">
                            <h6 class="card-subtitle">{{trans('messages.out_for_delivery')}}</h6>
                            <span class="card-title h3">{{\App\Model\Order::where(['order_status'=>'out_for_delivery','branch_id'=>auth('branch')->id()])->count()}}</span>
                        </div>
                        <span class="icon icon-sm icon-soft-secondary icon-circle ml-3">
                          <i class="tio-bike"></i>
                        </span>
                    </div>
                    <div class="d-lg-none">
                        <hr>
                    </div>
                </div>
            </div>
        </div>
        <!-- End Card -->

    @php
        $array=[];
            for ($i=1;$i<=12;$i++){
                $from = date('Y-'.$i.'-01');
                $to = date('Y-'.$i.'-30');
                $array[$i]=\App\Model\Order::where(['branch_id'=>auth('branch')->id()])->whereBetween('created_at', [$from, $to])->count();
            }
    @endphp
    <!-- Stats -->
        <div class="row gx-2 gx-lg-3">
            <div class="col-sm-6 col-lg-3 mb-3 mb-lg-5">
                <!-- Card -->
                <a class="card card-hover-shadow h-100" href="{{route('branch.orders.list',['status'=>'all'])}}">
                    <div class="card-body">
                        <h6 class="card-subtitle">{{trans('messages.total')}} {{trans('messages.order')}}</h6>

                        <div class="row align-items-center gx-2 mb-1">
                            <div class="col-6">
                                <span class="card-title h2">{{\App\Model\Order::where(['branch_id'=>auth('branch')->id()])->count()}}</span>
                            </div>

                            <div class="col-6">
                                <!-- Chart -->
                                <div class="chartjs-custom" style="height: 3rem;">
                                    <canvas class="js-chart"
                                            data-hs-chartjs-options='{
                                "type": "line",
                                "data": {
                                   "labels": ["Jan","Feb","Mar","April","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],
                                   "datasets": [{
                                    "data": [{{$array[1]}},{{$array[2]}},{{$array[3]}},{{$array[4]}},{{$array[5]}},{{$array[6]}},{{$array[7]}},{{$array[8]}},{{$array[9]}},{{$array[10]}},{{$array[11]}},{{$array[12]}}],
                                    "backgroundColor": ["#01684b", "#01684b"],
                                    "borderColor": "#01684b",
                                    "borderWidth": 2,
                                    "pointRadius": 0,
                                    "pointHoverRadius": 0
                                  }]
                                },
                                "options": {
                                   "scales": {
                                     "yAxes": [{
                                       "display": false
                                     }],
                                     "xAxes": [{
                                       "display": false
                                     }]
                                   },
                                  "hover": {
                                    "mode": "nearest",
                                    "intersect": false
                                  },
                                  "tooltips": {
                                    "postfix": "",
                                    "hasIndicator": true,
                                    "intersect": false
                                  }
                                }
                              }'>
                                    </canvas>
                                </div>
                                <!-- End Chart -->
                            </div>
                        </div>
                        <!-- End Row -->

                        <span class="badge badge-soft-success">
                  <i class="tio-trending-up"></i> Jan - Dec
                </span>
                    </div>
                </a>
                <!-- End Card -->
            </div>

            <div class="col-sm-6 col-lg-3 mb-3 mb-lg-5">
                <!-- Card -->
                @php
                    $array=[];
                        for ($i=1;$i<=12;$i++){
                            $from = date('Y-'.$i.'-01');
                            $to = date('Y-'.$i.'-30');
                            $array[$i]=\App\Model\Order::where(['order_status'=>'delivered','branch_id'=>auth('branch')->id()])->whereBetween('created_at', [$from, $to])->count();
                        }
                @endphp
                <a class="card card-hover-shadow h-100" href="{{route('branch.orders.list',['status'=>'delivered'])}}">
                    <div class="card-body">
                        <h6 class="card-subtitle">{{trans('messages.delivered')}}</h6>

                        <div class="row align-items-center gx-2 mb-1">
                            <div class="col-6">
                                <span
                                    class="card-title h2">{{\App\Model\Order::where(['order_status'=>'delivered','branch_id'=>auth('branch')->id()])->count()}}</span>
                            </div>

                            <div class="col-6">
                                <!-- Chart -->
                                <div class="chartjs-custom" style="height: 3rem;">
                                    <canvas class="js-chart"
                                            data-hs-chartjs-options='{
                                    "type": "line",
                                    "data": {
                                       "labels": ["Jan","Feb","Mar","April","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],
                                       "datasets": [{
                                        "data": [{{$array[1]}},{{$array[2]}},{{$array[3]}},{{$array[4]}},{{$array[5]}},{{$array[6]}},{{$array[7]}},{{$array[8]}},{{$array[9]}},{{$array[10]}},{{$array[11]}},{{$array[12]}}],
                                        "backgroundColor": ["#01684b", "#01684b"],
                                        "borderColor": "#01684b",
                                        "borderWidth": 2,
                                        "pointRadius": 0,
                                        "pointHoverRadius": 0
                                      }]
                                    },
                                "options": {
                                   "scales": {
                                     "yAxes": [{
                                       "display": false
                                     }],
                                     "xAxes": [{
                                       "display": false
                                     }]
                                   },
                                  "hover": {
                                    "mode": "nearest",
                                    "intersect": false
                                  },
                                  "tooltips": {
                                    "postfix": "",
                                    "hasIndicator": true,
                                    "intersect": false
                                  }
                                }
                              }'>
                                    </canvas>
                                </div>
                                <!-- End Chart -->
                            </div>
                        </div>
                        <!-- End Row -->

                        <span class="badge badge-soft-success">
                  <i class="tio-trending-up"></i> Jan - Dec
                </span>
                    </div>
                </a>
                <!-- End Card -->
            </div>

            <div class="col-sm-6 col-lg-3 mb-3 mb-lg-5">
                <!-- Card -->
                @php
                    $array=[];
                        for ($i=1;$i<=12;$i++){
                            $from = date('Y-'.$i.'-01');
                            $to = date('Y-'.$i.'-30');
                            $array[$i]=\App\Model\Order::where(['order_status'=>'returned','branch_id'=>auth('branch')->id()])->whereBetween('created_at', [$from, $to])->count();
                        }
                @endphp
                <a class="card card-hover-shadow h-100" href="{{route('branch.orders.list',['status'=>'returned'])}}">
                    <div class="card-body">
                        <h6 class="card-subtitle">{{trans('messages.returned')}}</h6>

                        <div class="row align-items-center gx-2 mb-1">
                            <div class="col-6">
                                <span
                                    class="card-title h2">{{\App\Model\Order::where(['order_status'=>'returned','branch_id'=>auth('branch')->id()])->count()}}</span>
                            </div>

                            <div class="col-6">
                                <!-- Chart -->
                                <div class="chartjs-custom" style="height: 3rem;">
                                    <canvas class="js-chart"
                                            data-hs-chartjs-options='{
                                  "type": "line",
                                    "data": {
                                       "labels": ["Jan","Feb","Mar","April","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],
                                       "datasets": [{
                                        "data": [{{$array[1]}},{{$array[2]}},{{$array[3]}},{{$array[4]}},{{$array[5]}},{{$array[6]}},{{$array[7]}},{{$array[8]}},{{$array[9]}},{{$array[10]}},{{$array[11]}},{{$array[12]}}],
                                        "backgroundColor": ["#01684b", "#01684b"],
                                        "borderColor": "#01684b",
                                        "borderWidth": 2,
                                        "pointRadius": 0,
                                        "pointHoverRadius": 0
                                      }]
                                    },
                                "options": {
                                   "scales": {
                                     "yAxes": [{
                                       "display": false
                                     }],
                                     "xAxes": [{
                                       "display": false
                                     }]
                                   },
                                  "hover": {
                                    "mode": "nearest",
                                    "intersect": false
                                  },
                                  "tooltips": {
                                    "postfix": "",
                                    "hasIndicator": true,
                                    "intersect": false
                                  }
                                }
                              }'>
                                    </canvas>
                                </div>
                                <!-- End Chart -->
                            </div>
                        </div>
                        <!-- End Row -->
                        <span class="badge badge-soft-warning">
                  <i class="tio-trending-down"></i> Jan - Dec
                </span>
                    </div>
                </a>
                <!-- End Card -->
            </div>

            <div class="col-sm-6 col-lg-3 mb-3 mb-lg-5">
                <!-- Card -->
                @php
                    $array=[];
                        for ($i=1;$i<=12;$i++){
                            $from = date('Y-'.$i.'-01');
                            $to = date('Y-'.$i.'-30');
                            $array[$i]=\App\Model\Order::where(['order_status'=>'failed','branch_id'=>auth('branch')->id()])->whereBetween('created_at', [$from, $to])->count();
                        }
                @endphp
                <a class="card card-hover-shadow h-100" href="{{route('branch.orders.list',['status'=>'failed'])}}">
                    <div class="card-body">
                        <h6 class="card-subtitle">{{trans('messages.failed')}}</h6>

                        <div class="row align-items-center gx-2 mb-1">
                            <div class="col-6">
                                <span
                                    class="card-title h2">{{\App\Model\Order::where(['order_status'=>'failed','branch_id'=>auth('branch')->id()])->count()}}</span>
                            </div>

                            <div class="col-6">
                                <!-- Chart -->
                                <div class="chartjs-custom" style="height: 3rem;">
                                    <canvas class="js-chart"
                                            data-hs-chartjs-options='{
                                    "type": "line",
                                    "data": {
                                       "labels": ["Jan","Feb","Mar","April","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],
                                       "datasets": [{
                                        "data": [{{$array[1]}},{{$array[2]}},{{$array[3]}},{{$array[4]}},{{$array[5]}},{{$array[6]}},{{$array[7]}},{{$array[8]}},{{$array[9]}},{{$array[10]}},{{$array[11]}},{{$array[12]}}],
                                        "backgroundColor": ["#01684b", "#01684b"],
                                        "borderColor": "#01684b",
                                        "borderWidth": 2,
                                        "pointRadius": 0,
                                        "pointHoverRadius": 0
                                      }]
                                    },
                                "options": {
                                   "scales": {
                                     "yAxes": [{
                                       "display": false
                                     }],
                                     "xAxes": [{
                                       "display": false
                                     }]
                                   },
                                  "hover": {
                                    "mode": "nearest",
                                    "intersect": false
                                  },
                                  "tooltips": {
                                    "postfix": "",
                                    "hasIndicator": true,
                                    "intersect": false
                                  }
                                }
                              }'>
                                    </canvas>
                                </div>
                                <!-- End Chart -->
                            </div>
                        </div>
                        <!-- End Row -->

                        <span class="badge badge-soft-danger">
                  <i class="tio-trending-down"></i> Jan - Dec
                        </span>
                    </div>
                </a>
                <!-- End Card -->
            </div>
        </div>
        <!-- End Stats -->

        <div class="row gx-2 gx-lg-3">
            <div class="col-lg-12 mb-3 mb-lg-12">
                <!-- Card -->
                <div class="card h-100">
                    <!-- Body -->
                    @php
                        $array=[];
                            for ($i=1;$i<=12;$i++){
                                $from = date('Y-'.$i.'-01');
                                $to = date('Y-'.$i.'-30');
                                $array[$i]=\App\Model\Order::where(['order_status'=>'delivered','branch_id'=>auth('branch')->id()])->whereBetween('created_at', [$from, $to])->sum('order_amount');
                            }
                    @endphp
                    <div class="card-body">
                        <div class="row mb-4">
                            <div class="col-sm mb-2 mb-sm-0">
                                <div class="d-flex align-items-center">
                                    @php($this_month=\App\Model\Order::where(['order_status'=>'delivered','branch_id'=>auth('branch')->id()])->whereBetween('updated_at', [date('Y-m-01'), date('Y-m-30')])->sum('order_amount'))
                                    @php($amount=0)
                                    <span
                                        class="h1 mb-0">@foreach($array as $ar)@php($amount+=$ar)@endforeach{{$amount." ".\App\CentralLogics\Helpers::currency_symbol()}}</span>
                                    <span class="text-success ml-2">
                                        @php($amount=$amount!=0?$amount:0.01)
                                        <i class="tio-trending-up"></i> {{round(($this_month/$amount)*100)}} %
                                    </span>
                                </div>
                            </div>

                            <div class="col-sm-auto align-self-sm-end">
                                <!-- Legend Indicators -->
                                <div class="row font-size-sm">
                                    <div class="col-auto">
                                        <h5 class="card-header-title">{{trans('messages.monthly')}} {{trans('messages.earning')}}</h5>
                                    </div>
                                </div>
                                <!-- End Legend Indicators -->
                            </div>
                        </div>
                        <!-- End Row -->

                        <!-- Bar Chart -->
                        <div class="chartjs-custom">
                            <canvas id="updatingData" style="height: 20rem;"
                                    data-hs-chartjs-options='{
                            "type": "bar",
                            "data": {
                              "labels": ["Jan","Feb","Mar","April","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],
                              "datasets": [{
                                "data": [{{$array[1]}},{{$array[2]}},{{$array[3]}},{{$array[4]}},{{$array[5]}},{{$array[6]}},{{$array[7]}},{{$array[8]}},{{$array[9]}},{{$array[10]}},{{$array[11]}},{{$array[12]}}],
                                "backgroundColor": "#01684b",
                                "hoverBackgroundColor": "#01684b",
                                "borderColor": "#01684b"
                              },
                              {
                                "data": [{{$array[1]}},{{$array[2]}},{{$array[3]}},{{$array[4]}},{{$array[5]}},{{$array[6]}},{{$array[7]}},{{$array[8]}},{{$array[9]}},{{$array[10]}},{{$array[11]}},{{$array[12]}}],
                                "backgroundColor": "#e7eaf3",
                                "borderColor": "#e7eaf3"
                              }]
                            },
                            "options": {
                              "scales": {
                                "yAxes": [{
                                  "gridLines": {
                                    "color": "#e7eaf3",
                                    "drawBorder": false,
                                    "zeroLineColor": "#e7eaf3"
                                  },
                                  "ticks": {
                                    "beginAtZero": true,
                                    "stepSize": {{$amount>1?20000:1}},
                                    "fontSize": 12,
                                    "fontColor": "#97a4af",
                                    "fontFamily": "Open Sans, sans-serif",
                                    "padding": 10,
                                    "postfix": " {{\App\CentralLogics\Helpers::currency_symbol()}}"
                                  }
                                }],
                                "xAxes": [{
                                  "gridLines": {
                                    "display": false,
                                    "drawBorder": false
                                  },
                                  "ticks": {
                                    "fontSize": 12,
                                    "fontColor": "#97a4af",
                                    "fontFamily": "Open Sans, sans-serif",
                                    "padding": 5
                                  },
                                  "categoryPercentage": 0.5,
                                  "maxBarThickness": "10"
                                }]
                              },
                              "cornerRadius": 2,
                              "tooltips": {
                                "prefix": " ",
                                "hasIndicator": true,
                                "mode": "index",
                                "intersect": false
                              },
                              "hover": {
                                "mode": "nearest",
                                "intersect": true
                              }
                            }
                          }'></canvas>
                        </div>
                        <!-- End Bar Chart -->
                    </div>
                    <!-- End Body -->
                </div>
                <!-- End Card -->
            </div>
        </div>
        <!-- End Row -->
    </div>
@endsection

@push('script')
    <script src="{{asset('public/assets/admin')}}/vendor/chart.js/dist/Chart.min.js"></script>
    <script src="{{asset('public/assets/admin')}}/vendor/chart.js.extensions/chartjs-extensions.js"></script>
    <script
        src="{{asset('public/assets/admin')}}/vendor/chartjs-plugin-datalabels/dist/chartjs-plugin-datalabels.min.js"></script>
@endpush


@push('script_2')
    <script>
        // INITIALIZATION OF CHARTJS
        // =======================================================
        Chart.plugins.unregister(ChartDataLabels);

        $('.js-chart').each(function () {
            $.HSCore.components.HSChartJS.init($(this));
        });

        var updatingChart = $.HSCore.components.HSChartJS.init($('#updatingData'));

        // CALL WHEN TAB IS CLICKED
        // =======================================================
        $('[data-toggle="chart-bar"]').click(function (e) {
            let keyDataset = $(e.currentTarget).attr('data-datasets')

            if (keyDataset === 'lastWeek') {
                updatingChart.data.labels = ["Apr 22", "Apr 23", "Apr 24", "Apr 25", "Apr 26", "Apr 27", "Apr 28", "Apr 29", "Apr 30", "Apr 31"];
                updatingChart.data.datasets = [
                    {
                        "data": [120, 250, 300, 200, 300, 290, 350, 100, 125, 320],
                        "backgroundColor": "#377dff",
                        "hoverBackgroundColor": "#377dff",
                        "borderColor": "#377dff"
                    },
                    {
                        "data": [250, 130, 322, 144, 129, 300, 260, 120, 260, 245, 110],
                        "backgroundColor": "#e7eaf3",
                        "borderColor": "#e7eaf3"
                    }
                ];
                updatingChart.update();
            } else {
                updatingChart.data.labels = ["May 1", "May 2", "May 3", "May 4", "May 5", "May 6", "May 7", "May 8", "May 9", "May 10"];
                updatingChart.data.datasets = [
                    {
                        "data": [200, 300, 290, 350, 150, 350, 300, 100, 125, 220],
                        "backgroundColor": "#377dff",
                        "hoverBackgroundColor": "#377dff",
                        "borderColor": "#377dff"
                    },
                    {
                        "data": [150, 230, 382, 204, 169, 290, 300, 100, 300, 225, 120],
                        "backgroundColor": "#e7eaf3",
                        "borderColor": "#e7eaf3"
                    }
                ]
                updatingChart.update();
            }
        })


        // INITIALIZATION OF BUBBLE CHARTJS WITH DATALABELS PLUGIN
        // =======================================================
        $('.js-chart-datalabels').each(function () {
            $.HSCore.components.HSChartJS.init($(this), {
                plugins: [ChartDataLabels],
                options: {
                    plugins: {
                        datalabels: {
                            anchor: function (context) {
                                var value = context.dataset.data[context.dataIndex];
                                return value.r < 20 ? 'end' : 'center';
                            },
                            align: function (context) {
                                var value = context.dataset.data[context.dataIndex];
                                return value.r < 20 ? 'end' : 'center';
                            },
                            color: function (context) {
                                var value = context.dataset.data[context.dataIndex];
                                return value.r < 20 ? context.dataset.backgroundColor : context.dataset.color;
                            },
                            font: function (context) {
                                var value = context.dataset.data[context.dataIndex],
                                    fontSize = 25;

                                if (value.r > 50) {
                                    fontSize = 35;
                                }

                                if (value.r > 70) {
                                    fontSize = 55;
                                }

                                return {
                                    weight: 'lighter',
                                    size: fontSize
                                };
                            },
                            offset: 2,
                            padding: 0
                        }
                    }
                },
            });
        });
    </script>
@endpush
