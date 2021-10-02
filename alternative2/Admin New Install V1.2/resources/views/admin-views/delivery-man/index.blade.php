@extends('layouts.admin.app')

@section('title','Add new delivery-man')

@push('css_or_js')

@endpush

@section('content')
    <div class="content container-fluid">
        <!-- Page Header -->
        <div class="page-header">
            <div class="row align-items-center">
                <div class="col-sm mb-2 mb-sm-0">
                    <h1 class="page-header-title"><i class="tio-add-circle-outlined"></i> {{trans('messages.add')}} {{trans('messages.new')}} {{trans('messages.deliveryman')}}</h1>
                </div>
            </div>
        </div>
        <!-- End Page Header -->
        <div class="row gx-2 gx-lg-3">
            <div class="col-sm-12 col-lg-12 mb-3 mb-lg-2">
                <form action="{{route('admin.delivery-man.store')}}" method="post" enctype="multipart/form-data">
                    @csrf
                    <div class="row">
                        <div class="col-md-6 col-12">
                            <div class="form-group">
                                <label class="input-label" for="exampleFormControlInput1">{{trans('messages.first')}} {{trans('messages.name')}}</label>
                                <input type="text" name="f_name" class="form-control" placeholder="{{trans('messages.first')}} {{trans('messages.name')}}"
                                       required>
                            </div>
                        </div>
                        <div class="col-md-6 col-12">
                            <div class="form-group">
                                <label class="input-label" for="exampleFormControlInput1">{{trans('messages.last')}} {{trans('messages.name')}}</label>
                                <input type="text" name="l_name" class="form-control" placeholder="{{trans('messages.last')}} {{trans('messages.name')}}"
                                       required>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-4 col-12">
                            <div class="form-group">
                                <label class="input-label" for="exampleFormControlInput1">{{trans('messages.email')}}</label>
                                <input type="email" name="email" class="form-control" placeholder="Ex : ex@example.com"
                                       required>
                            </div>
                        </div>
                        <div class="col-md-4 col-12">
                            <div class="form-group">
                                <label class="input-label" for="exampleFormControlInput1">{{trans('messages.phone')}}</label>
                                <input type="text" name="phone" class="form-control" placeholder="Ex : 017********"
                                       required>
                            </div>
                        </div>
                        <div class="col-md-4 col-12">
                            <div class="form-group">
                                <label class="input-label" for="exampleFormControlInput1">{{trans('messages.branch')}}</label>
                                <select name="branch_id" class="form-control">
                                    <option value="0">{{trans('messages.all')}}</option>
                                    @foreach(\App\Model\Branch::all() as $branch)
                                        <option value="{{$branch['id']}}">{{$branch['name']}}</option>
                                    @endforeach
                                </select>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6 col-12">
                            <div class="form-group">
                                <label class="input-label" for="exampleFormControlInput1">{{trans('messages.identity')}} {{trans('messages.type')}}</label>
                                <select name="identity_type" class="form-control">
                                    <option value="passport">{{trans('messages.passport')}}</option>
                                    <option value="driving_license">{{trans('messages.driving')}} {{trans('messages.license')}}</option>
                                    <option value="nid">{{trans('messages.nid')}}</option>
                                    <option value="restaurant_id">{{trans('messages.restaurant')}} {{trans('messages.id')}}</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-md-6 col-12">
                            <div class="form-group">
                                <label class="input-label" for="exampleFormControlInput1">{{trans('messages.identity')}} {{trans('messages.number')}}</label>
                                <input type="text" name="identity_number" class="form-control"
                                       placeholder="Ex : DH-23434-LS"
                                       required>
                            </div>
                        </div>
                        <div class="col-md-12 col-12">
                            <div class="form-group">
                                <label class="input-label" for="exampleFormControlInput1">{{trans('messages.identity')}} {{trans('messages.image')}}</label>
                                <div>
                                    <div class="row" id="coba"></div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="input-label" for="exampleFormControlInput1">{{trans('messages.password')}}</label>
                        <input type="text" name="password" class="form-control" placeholder="Ex : password"
                               required>
                    </div>

                    <div class="form-group">
                        <label>{{trans('messages.deliveryman')}} {{trans('messages.image')}}</label><small style="color: red">* ( {{trans('messages.ratio')}} 1:1 )</small>
                        <div class="custom-file">
                            <input type="file" name="image" id="customFileEg1" class="custom-file-input"
                                   accept=".jpg, .png, .jpeg, .gif, .bmp, .tif, .tiff|image/*" required>
                            <label class="custom-file-label" for="customFileEg1">{{trans('messages.choose')}} {{trans('messages.file')}}</label>
                        </div>
                        <hr>
                        <center>
                            <img style="height: 200px;border: 1px solid; border-radius: 10px;" id="viewer"
                                 src="{{asset('public/assets/admin/img/400x400/img2.jpg')}}" alt="delivery-man image"/>
                        </center>
                    </div>
                    <hr>
                    <button type="submit" class="btn btn-primary">{{trans('messages.submit')}}</button>
                </form>
            </div>
        </div>
    </div>

@endsection

@push('script_2')
    <script>
        function readURL(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();

                reader.onload = function (e) {
                    $('#viewer').attr('src', e.target.result);
                }

                reader.readAsDataURL(input.files[0]);
            }
        }

        $("#customFileEg1").change(function () {
            readURL(this);
        });
    </script>

    <script src="{{asset('public/assets/admin/js/spartan-multi-image-picker.js')}}"></script>

    <script type="text/javascript">
        $(function () {
            $("#coba").spartanMultiImagePicker({
                fieldName: 'identity_image[]',
                maxCount: 5,
                rowHeight: '120px',
                groupClassName: 'col-2',
                maxFileSize: '',
                placeholderImage: {
                    image: '{{asset('public/assets/admin/img/400x400/img2.jpg')}}',
                    width: '100%'
                },
                dropFileLabel: "Drop Here",
                onAddRow: function (index, file) {

                },
                onRenderedPreview: function (index) {

                },
                onRemoveRow: function (index) {

                },
                onExtensionErr: function (index, file) {
                    toastr.error('Please only input png or jpg type file', {
                        CloseButton: true,
                        ProgressBar: true
                    });
                },
                onSizeErr: function (index, file) {
                    toastr.error('File size too big', {
                        CloseButton: true,
                        ProgressBar: true
                    });
                }
            });
        });
    </script>
@endpush
