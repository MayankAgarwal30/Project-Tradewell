@foreach($orders as $key=>$order)

    <tr class="status-{{$order['order_status']}} class-all">
        <td class="">
            {{$key+1}}
        </td>
        <td class="table-column-pl-0">
            <a href="{{route('branch.orders.details',['id'=>$order['id']])}}">{{$order['id']}}</a>
        </td>
        <td>{{date('d M Y',strtotime($order['created_at']))}}</td>
        <td>
            @if($order->customer)
                <a class="text-body text-capitalize"
                   href="{{route('branch.orders.details',['id'=>$order['id']])}}">{{$order->customer['f_name'].' '.$order->customer['l_name']}}</a>
            @else
                <label
                    class="badge badge-danger">{{trans('messages.invalid')}} {{trans('messages.customer')}} {{trans('messages.data')}}</label>
            @endif
        </td>
        <td>
            @if($order->payment_status=='paid')
                <span class="badge badge-soft-success">
                                      <span class="legend-indicator bg-success"></span>{{trans('messages.paid')}}
                                    </span>
            @else
                <span class="badge badge-soft-danger">
                                      <span class="legend-indicator bg-danger"></span>{{trans('messages.unpaid')}}
                                    </span>
            @endif
        </td>
        <td>
            <div class="d-flex align-items-center">
                <span class="text-dark">{{$order['payment_method']}}</span>
            </div>
        </td>
        <td>{{$order['order_amount'] ." ". \App\CentralLogics\Helpers::currency_symbol()}}</td>
        <td class="text-capitalize">
            @if($order['order_status']=='pending')
                <span class="badge badge-soft-info ml-2 ml-sm-3">
                                        <span class="legend-indicator bg-info"></span>{{trans('messages.pending')}}
                                    </span>
            @elseif($order['order_status']=='confirmed')
                <span class="badge badge-soft-info ml-2 ml-sm-3">
                                      <span class="legend-indicator bg-info"></span>{{trans('messages.confirmed')}}
                                    </span>
            @elseif($order['order_status']=='processing')
                <span class="badge badge-soft-warning ml-2 ml-sm-3">
                                      <span class="legend-indicator bg-warning"></span>{{trans('messages.processing')}}
                                    </span>
            @elseif($order['order_status']=='out_for_delivery')
                <span class="badge badge-soft-warning ml-2 ml-sm-3">
                                      <span class="legend-indicator bg-warning"></span>{{trans('messages.out_for_delivery')}}
                                    </span>
            @elseif($order['order_status']=='delivered')
                <span class="badge badge-soft-success ml-2 ml-sm-3">
                                      <span class="legend-indicator bg-success"></span>{{trans('messages.delivered')}}
                                    </span>
            @else
                <span class="badge badge-soft-danger ml-2 ml-sm-3">
                                      <span class="legend-indicator bg-danger"></span>{{str_replace('_',' ',$order['order_status'])}}
                                    </span>
            @endif
        </td>
        <td>
            <div class="dropdown">
                <button class="btn btn-outline-secondary dropdown-toggle" type="button"
                        id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true"
                        aria-expanded="false">
                    <i class="tio-settings"></i>
                </button>
                <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                    <a class="dropdown-item"
                       href="{{route('branch.orders.details',['id'=>$order['id']])}}"><i
                            class="tio-visible"></i> {{trans('messages.view')}}</a>
                    <a class="dropdown-item" target="_blank"
                       href="{{route('branch.orders.generate-invoice',[$order['id']])}}"><i
                            class="tio-download"></i> {{trans('messages.invoice')}}</a>
                </div>
            </div>
        </td>
    </tr>

@endforeach
