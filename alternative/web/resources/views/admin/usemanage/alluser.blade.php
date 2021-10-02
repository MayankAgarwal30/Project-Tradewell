@extends('admin.layout.app')

@section ('content')


<!-- Begin Page Content -->
<div class="container-fluid">
 

  <!-- DataTales Example -->
  <div class="card shadow mb-4">
    <div class="card-header py-3">
      <h6 class="m-0 font-weight-bold text-primary">{{ __('messages.User Details')}}</h6>
      @if (count($errors) > 0)
                  @if($errors->any())
                    <div class="alert alert-primary" role="alert">
                      {{$errors->first()}}
                      <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                        <span aria-hidden="true">×</span>
                      </button>
                    </div>
                  @endif
              @endif
        <!--<a class="btn btn-success m-auto" style="float: right;" href="{{route('addUser')}}">{{ __('messages.Add')}}</a>-->
    </div>
    <div class="card-body">
      <div class="table-responsive">
        <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
          <thead>
            <tr>
                <th>{{ __('messages.serial no')}}</th>
                <th>{{ __('messages.User Name')}}</th>
                <th>{{ __('messages.User Number')}}</th>
                <th>{{ __('messages.Wallet Amount')}}</th>
                <th>{{ __('messages.Action')}}</th>
            </tr>
          </thead>
         
          <tbody>
          @if(count($alluser)>0)
                          @php $i=1; @endphp
                          @foreach($alluser as $user)
                        <tr>
                            <td>{{$i}}</td>
                            <td>{{$user->user_name}}</td>
                            <td>{{$user->user_phone}}</td>
                            <td>{{$user->wallet_credits}}</td>
                            
                            <td>
                               <a href="{{route('edit-users',$user->user_id)}}" style="width: 28px; padding-left: 6px;" class="btn btn-info"  style="width: 10px;padding-left: 9px;" style="color: #fff;"><i class="fa fa-edit" style="width: 10px;"></i></a>
                               <button type="button" style="width: 28px; padding-left: 6px;" class="btn btn-danger" data-toggle="modal" data-target="#exampleModal{{$user->user_id}}"><i class="fa fa-trash"></i></button>
							
							</td>

                        </tr>
                        @php $i++; @endphp
                        @endforeach
                      @else
                        <tr>
                          <td>No data found</td>
                        </tr>
                      @endif
                       {!! $alluser->links("pagination::bootstrap-4") !!}
          </tbody>
        </table>
      </div>
    </div>
  </div>

</div>
<!-- /.container-fluid -->
</div>
</div>
   
 @foreach($alluser as $user)
<!-- Modal -->
<div class="modal fade" id="exampleModal{{$user->user_id}}" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">{{ __('messages.Delete')}}</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
			</div>
			<div class="modal-body">
			{{ __('messages.Are you want to delete')}}
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">{{ __('messages.Close')}}</button>
				<a href="{{route('delete_user', $user->user_id)}}" class="btn btn-primary">{{ __('messages.Delete')}}</a>
			</div>
		</div>
	</div>
</div>
@endforeach
@endsection