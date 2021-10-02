@extends('parcel.layout.app')
<style>
    @media screen {
  #printSection {
      display: none;
  }
}

@media print {
  body * {
    visibility:hidden;
  }
  #printSection, #printSection * {
    visibility:visible;
  }
  #printSection {
    position:absolute;
    left:0;
    top:0;
  }
}

</style>
@section ('content')

          <div class="row">
         <!-- DataTales Example -->
              <div class="card shadow" style="width:100%">
                <div class="card-header py-3">
                  <h6 class="m-0 font-weight-bold text-primary">Completed orders</h6>
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
                </div>
                <div class="card-body">
                  <div class="table-responsive">
                    <table class="table table-bordered" id="example2" width="100%" cellspacing="0">
                      <thead>
                        <tr>
                        <th>S.No</th>
                        <th>Cart Id</th>
                        <th>Total Price</th>
                        <th>Distance</th>
                        <th>Charges</th>
                        <th>Pickup Date</th>
                        <th>User Name</th>
                        <th>Details</th>
                        </tr>
                      </thead>
                      
                      <tbody>
                      @if(count($nextdayorder)>0)
                                      @php $i=1; @endphp
                                      @foreach($nextdayorder as $nextdayorders)
                                      
                                    <tr>
                                        <td>{{$i}}</td>
                                        <td>{{$nextdayorders->cart_id}}</td>
                                        <td>{{$nextdayorders->total_price}}</td>
                                         <td>{{$nextdayorders->distance}}</td>
                                         <td>{{$nextdayorders->charges}}</td>
                                        <td>{{$nextdayorders->pickup_date}}</td>
                                        <td>{{$nextdayorders->user_name}}</td>
                                       <td><button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal1{{$nextdayorders->parcel_id}}">Details</button></td>
                                        
                                    </tr>
                                    <div class="modal fade" id="exampleModal{{$nextdayorders->parcel_id}}" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                	<div class="modal-dialog" role="document">
                                		<div class="modal-content">
                                			<div class="modal-header">
                                				<h5 class="modal-title" id="exampleModalLabel">Assign Delivery Boy/ Incentive</h5>
                                					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                						<span aria-hidden="true">&times;</span>
                                					</button>
                                			</div>
                                			@if($boy_area_id !='N/A')
                                			<!--//form-->
                                			<form action="{{route('assigned_order')}}" method="post">   
                                			{{csrf_field()}}
                                			<div class="modal-body">
                                			 <div class="form-group">
                                                <label for="exampleFormControlSelect3">choose a Delivery Boy<sup>*</sup></label>
                                                <input type="hidden" name="order_id" value="{{$nextdayorders->parcel_id}}">
                                                <select class="form-control form-control-sm" id="exampleFormControlSelect3 " name="delivery_boy_name">
                                                  @foreach($delivery_boy as $delivery_boys)
                                                 
                            		          	    <option value="{{$delivery_boys->delivery_boy_id}}"><span style="font-weight:bold">{{$delivery_boys->delivery_boy_name}}</span> 
                            		          	    </option>
                            		          	 
                            		              @endforeach
                                                  
                                                  
                                                </select>
                                                </div>
                                                
                                                  <!--<label for="exampleInputName1">Incentive for this order</label>-->
                                                  <!--<input type="text" class="form-control" id="exampleInputName1" name="incentive" placeholder="Incentive for this order">-->
                                                  <input type="hidden" class="form-control" name="subs_id" value={{$nextdayorders->parcel_id}}>
                                                
                                                
                                			</div>
                                			<div class="modal-footer">
                                			    <button type="submit" class="btn btn-success mr-2">Assign</button>
                                				<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                			</div>
                                			</form>
                                			<!--//form-->
                                			@else
                                			<h4>Uh-Oh! your delivery boys for this delivery area are offline</h4>
                                			@endif
                                		</div>
                                	</div>
                                </div>
                                    @php $i++; @endphp
                                    @endforeach
                                  @else
                                    <tr>
                                      <td>No data found</td>
                                    </tr>
                                  @endif
                                   
                      </tbody>
                    </table>
                  </div>
                </div>
              </div>

          </div>

        </div>
        <!-- /.container-fluid -->
<!--/////////details model//////////-->
@foreach($nextdayorder as $nextdayorders)

  <div id="printThis">
<div class="modal fade" id="exampleModal1{{$nextdayorders->parcel_id}}" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="container">
     
    	<div class="modal-dialog" role="document">
    		<div class="modal-content">
    			<div class="modal-header">
    				<h5 class="modal-title" id="exampleModalLabel">Order Details</h5>
    					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
    						<span aria-hidden="true">&times;</span>
    					</button>
    			</div>
        <div class="material-datatables">
              <form role="form" method="post" action="" >
            <table id="datatables" class="table table-striped table-no-bordered table-hover" cellspacing="0" width="100%" style="width:100%" data-background-color="purple">

                
                <tbody>
                    <tr>
                        <td colspan="3">
                            <table class="table">
                                <tr>
                                    <td valign="top" style="width:50%">
                                    <strong> Source Address </strong> 
                                    <br>
                                    {{$nextdayorders->source_add}},
                                   
                                    {{$nextdayorders->source_city}},
                                   
                                    {{$nextdayorders->source_state}},
                                    {{$nextdayorders->source_pincode}}
                                    
                                    <td  style="width:50%" align="right">
                                        <strong> Destination </strong>
                                       <br>
                                   
                                    {{$nextdayorders->destination_add}},
                                    
                                    {{$nextdayorders->destination_city}},
                                   
                                    {{$nextdayorders->destination_state}},
                                     {{$nextdayorders->destination_pincode}}
                                        
                                     </td>
                                    
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <!---->
                     <tr>
                        <td colspan="3">
                            <table class="table">
                                <tr>
                                    <td valign="top" style="width:50%" >
                                    <strong> Weight </strong> 
                                    <br>
                                    {{$nextdayorders->weight}}
                                    
                                    <td  style="width:50%">
                                        <strong> Height </strong>
                                       <br>
                                   
                                    {{$nextdayorders->height}}
                                   
                                      
                                     </td>
                                    <td  style="width:50%">
                                        <strong> Width </strong>
                                       <br>
                                   
                                    {{$nextdayorders->width}}
                                   
                                        
                                     </td>
                                     <td  style="width:50%">
                                        <strong> Charges </strong>
                                       <br>
                                   
                                    {{$nextdayorders->charges}}
                                   
                                        
                                     </td>
                                    
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <!---->

               
                   
                   
          
                </tbody>
            </table>
            </form>
        </div>
         <div class="modal-footer">
       <button class="btn" data-dismiss="modal" aria-hidden="true">Close</button>
      <button id="btnPrint" type="button" class="btn btn-default">Print</button>
      </div>
    </div>
    
    <!-- end content-->
</div></div>
                            <!--  end card  -->
	
		</div>
	</div>
</div>

                                
         @endforeach                       
                                
      </div>
      <!-- End of Main Content -->

<script>
    document.getElementById("btnPrint").onclick = function () {
    printElement(document.getElementById("printThis"));
}

function printElement(elem) {
    var domClone = elem.cloneNode(true);
    
    var $printSection = document.getElementById("printSection");
    
    if (!$printSection) {
        var $printSection = document.createElement("div");
        $printSection.id = "printSection";
        document.body.appendChild($printSection);
    }
    
    $printSection.innerHTML = "";
    $printSection.appendChild(domClone);
    window.print();
}
</script>

    


@endsection