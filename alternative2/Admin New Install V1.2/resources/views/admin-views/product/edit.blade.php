@extends('layouts.admin.app')

@section('title','Update product')

@push('css_or_js')
    <meta name="csrf-token" content="{{ csrf_token() }}">
    <link href="{{asset('public/assets/admin/css/tags-input.min.css')}}" rel="stylesheet">
@endpush

@section('content')
    <div class="content container-fluid">
        <!-- Page Header -->
        <div class="page-header">
            <div class="row align-items-center">
                <div class="col-sm mb-2 mb-sm-0">
                    <h1 class="page-header-title"><i
                            class="tio-edit"></i> {{trans('messages.product')}} {{trans('messages.update')}}</h1>
                </div>
            </div>
        </div>
        <!-- End Page Header -->
        <div class="row gx-2 gx-lg-3">
            <div class="col-sm-12 col-lg-12 mb-3 mb-lg-2">
                <form action="javascript:" method="post" id="product_form"
                      enctype="multipart/form-data">
                    @csrf
                    <div class="form-group">
                        <label class="input-label" for="exampleFormControlInput1">{{trans('messages.name')}}</label>
                        <input type="text" name="name" value="{{$product['name']}}" class="form-control"
                               placeholder="New Product" required>
                    </div>

                    <div class="row">
                        <div class="col-6">

                            <div class="form-group">
                                <label class="input-label"
                                       for="exampleFormControlInput1">{{trans('messages.capacity')}}</label>
                                <input type="number" min="0" step="0.01" value="{{ $product['capacity'] }}" name="capacity"
                                       class="form-control"
                                       placeholder="Ex : 5" required>
                            </div>

                        </div>
                        <div class="col-6">
                            <div class="form-group">
                                <label class="input-label"
                                       for="exampleFormControlInput1">{{trans('messages.unit')}}</label>
                                <select name="unit" class="form-control js-select2-custom">
                                    <option value="kg" {{$product['unit']=='kg'?'selected':''}}>
                                        {{trans('messages.kg')}}
                                    </option>
                                    <option value="gm" {{$product['unit']=='gm'?'selected':''}}>
                                        {{trans('messages.gm')}}
                                    </option>
                                    <option value="ltr" {{$product['unit']=='ltr'?'selected':''}}>
                                        {{trans('messages.ltr')}}
                                    </option>
                                    <option value="pc" {{$product['unit']=='pc'?'selected':''}}>
                                        {{trans('messages.pc')}}
                                    </option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-6">
                            <div class="form-group">
                                <label class="input-label"
                            for="exampleFormControlInput1">{{trans('messages.price')}}</label>
                       <input type="number" min="0" step="0.01" value="{{ $product['price'] }}" name="price"
                            class="form-control"
                            placeholder="Ex : 100" required>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-6">
                            <div class="form-group">
                                <label class="input-label"
                                       for="exampleFormControlInput1">{{trans('messages.tax')}}</label>
                                <input type="number" value="{{$product['tax']}}" min="0" name="tax"
                                       class="form-control" step="0.01"
                                       placeholder="Ex : 7" required>
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="form-group">
                                <label class="input-label"
                                       for="exampleFormControlInput1">{{trans('messages.tax')}} {{trans('messages.type')}}</label>
                                <select name="tax_type" class="form-control js-select2-custom">
                                    <option
                                        value="percent" {{$product['tax_type']=='percent'?'selected':''}}>{{trans('messages.percent')}}
                                    </option>
                                    <option
                                        value="amount" {{$product['tax_type']=='amount'?'selected':''}}>{{trans('messages.amount')}}
                                    </option>
                                </select>
                            </div>
                        </div>
                    </div>



                    <div class="row">
                        <div class="col-6">
                            <div class="form-group">
                                <label class="input-label"
                                       for="exampleFormControlInput1">{{trans('messages.discount')}}</label>
                                <input type="number" min="0" value="{{$product['discount']}}"
                                       name="discount" class="form-control"
                                       placeholder="Ex : 100">
                            </div>
                        </div>
                        <div class="col-md-6 col-6">
                            <div class="form-group">
                                <label class="input-label"
                                       for="exampleFormControlInput1">{{trans('messages.discount')}} {{trans('messages.type')}}</label>
                                <select name="discount_type" class="form-control js-select2-custom">
                                    <option value="percent" {{$product['discount_type']=='percent'?'selected':''}}>
                                        {{trans('messages.percent')}}
                                    </option>
                                    <option value="amount" {{$product['discount_type']=='amount'?'selected':''}}>
                                        {{trans('messages.amount')}}
                                    </option>
                                </select>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6 col-6">
                            <div class="form-group">
                                <label class="input-label"
                                       for="exampleFormControlSelect1">{{trans('messages.category')}}<span
                                        class="input-label-secondary">*</span></label>
                                <select name="category_id" id="category-id" class="form-control js-select2-custom"
                                        onchange="getRequest('{{url('/')}}/admin/product/get-categories?parent_id='+this.value,'sub-categories')">
                                    @foreach($categories as $category)
                                        <option
                                            value="{{$category['id']}}" {{ $category->id==$product_category[0]->id ? 'selected' : ''}} >{{$category['name']}}</option>
                                    @endforeach
                                </select>
                            </div>
                        </div>
                        <div class="col-md-6 col-6">
                            <div class="form-group">
                                <label class="input-label"
                                       for="exampleFormControlSelect1">{{trans('messages.sub_category')}}<span
                                        class="input-label-secondary"></span></label>
                                <select name="sub_category_id" id="sub-categories"
                                        data-id="{{count($product_category)>=2?$product_category[1]->id:''}}"
                                        class="form-control js-select2-custom"
                                        onchange="getRequest('{{url('/')}}/admin/product/get-categories?parent_id='+this.value,'sub-sub-categories')">

                                </select>
                            </div>
                        </div>
                    </div>

                    <div class="row"
                         style="border: 1px solid #80808045; border-radius: 10px;padding-top: 10px;margin: 1px">
                        <div class="col-12">
                            <div class="form-group">
                                <label class="input-label"
                                       for="exampleFormControlSelect1">{{trans('messages.attribute')}}<span
                                        class="input-label-secondary"></span></label>
                                <select name="attribute_id[]" id="choice_attributes"
                                        class="form-control js-select2-custom"
                                        multiple="multiple">
                                    @foreach(\App\Model\Attribute::orderBy('name')->get() as $attribute)
                                        <option
                                            value="{{$attribute['id']}}" {{in_array($attribute->id,json_decode($product['attributes'],true))?'selected':''}}>{{$attribute['name']}}</option>
                                    @endforeach
                                </select>
                            </div>
                        </div>
                        <div class="col-md-12 mt-2 mb-2">
                            <div class="customer_choice_options" id="customer_choice_options">
                                @include('admin-views.product.partials._choices',['choice_no'=>json_decode($product['attributes']),'choice_options'=>json_decode($product['choice_options'],true)])
                            </div>
                        </div>
                        <div class="col-md-12 mt-2 mb-2">
                            <div class="variant_combination" id="variant_combination">
                                @include('admin-views.product.partials._edit-combinations',['combinations'=>json_decode($product['variations'],true)])
                            </div>
                        </div>
                        <div class="col-12">
                            <div class="form-group">
                                <label class="input-label"
                                       for="exampleFormControlInput1">{{trans('messages.stock')}}</label>
                                <input type="number" min="0" value="{{ $product['total_stock'] }}" name="total_stock" class="form-control"
                                       placeholder="Ex : 100">
                            </div>
                        </div>
                    </div>

                    <div class="form-group pt-4">
                        <label class="input-label"
                               for="exampleFormControlInput1">{{trans('messages.short')}} {{trans('messages.description')}}</label>
                        <div id="editor" style="min-height: 15rem;">{!! $product['description'] !!}</div>
                        <textarea name="description" style="display:none" id="hiddenArea"></textarea>
                    </div>

                    <div class="form-group">
                        <label>{{trans('messages.product')}} {{trans('messages.image')}}</label><small
                            style="color: red">* ( {{trans('messages.ratio')}} 1:1 )</small>
                        <div>
                            <div class="row mb-3">
                                @foreach(json_decode($product['image'],true) as $img)
                                    <div class="col-3">
                                        <img style="height: 200px;width: 100%"
                                             src="{{asset('storage/app/public/product')}}/{{$img}}">
                                        <a href="{{route('admin.product.remove-image',[$product['id'],$img])}}"
                                           style="margin-top: -35px;border-radius: 0"
                                           class="btn btn-danger btn-block btn-sm">Remove</a>
                                    </div>
                                @endforeach
                            </div>
                            <div class="row" id="coba"></div>
                        </div>
                    </div>
                    <hr>
                    <button type="submit" class="btn btn-primary">{{trans('messages.update')}}</button>
                </form>
            </div>
        </div>
    </div>

@endsection

@push('script')

@endpush

@push('script_2')
    <script src="{{asset('public/assets/admin/js/spartan-multi-image-picker.js')}}"></script>

    <script type="text/javascript">
        $(function () {
            $("#coba").spartanMultiImagePicker({
                fieldName: 'images[]',
                maxCount: 4,
                rowHeight: '215px',
                groupClassName: 'col-3',
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

    <script>
        function getRequest(route, id) {
            $.get({
                url: route,
                dataType: 'json',
                success: function (data) {
                    $('#' + id).empty().append(data.options);
                },
            });
        }

        $(document).ready(function () {
            setTimeout(function () {
                let category = $("#category-id").val();
                let sub_category = '{{count($product_category)>=2?$product_category[1]->id:''}}';
                let sub_sub_category = '{{count($product_category)>=3?$product_category[2]->id:''}}';
                getRequest('{{url('/')}}/admin/product/get-categories?parent_id=' + category + '&&sub_category=' + sub_category, 'sub-categories');
                getRequest('{{url('/')}}/admin/product/get-categories?parent_id=' + sub_category + '&&sub_category=' + sub_sub_category, 'sub-sub-categories');
            }, 1000)
        });
    </script>

    <script>
        $(document).on('ready', function () {
            $('.js-select2-custom').each(function () {
                var select2 = $.HSCore.components.HSSelect2.init($(this));
            });
        });
    </script>


    <script src="{{asset('public/assets/admin')}}/js/tags-input.min.js"></script>

    <script>
        $('#choice_attributes').on('change', function () {
            $('#customer_choice_options').html(null);
            $.each($("#choice_attributes option:selected"), function () {
                add_more_customer_choice_option($(this).val(), $(this).text());
            });
        });

        function add_more_customer_choice_option(i, name) {
            let n = name.split(' ').join('');
            $('#customer_choice_options').append('<div class="row"><div class="col-md-3"><input type="hidden" name="choice_no[]" value="' + i + '"><input type="text" class="form-control" name="choice[]" value="' + n + '" placeholder="Choice Title" readonly></div><div class="col-lg-9"><input type="text" class="form-control" name="choice_options_' + i + '[]" placeholder="Enter choice values" data-role="tagsinput" onchange="combination_update()"></div></div>');
            $("input[data-role=tagsinput], select[multiple][data-role=tagsinput]").tagsinput();
        }

        function combination_update() {
            $.ajaxSetup({
                headers: {
                    'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
                }
            });

            $.ajax({
                type: "POST",
                url: '{{route('admin.product.variant-combination')}}',
                data: $('#product_form').serialize(),
                success: function (data) {
                    console.log(data.view);
                    $('#variant_combination').html(data.view);
                    if (data.length > 1) {
                        $('#quantity').hide();
                    } else {
                        $('#quantity').show();
                    }
                }
            });
        }
    </script>

    <script src="https://cdn.quilljs.com/1.3.6/quill.js"></script>

    <script>
        var container = $('#editor').get(0);
        var quill = new Quill(container, {
            theme: 'snow'
        });

        $('#product_form').on('submit', function () {

            var myEditor = document.querySelector('#editor')
            $("#hiddenArea").val(myEditor.children[0].innerHTML);

            var formData = new FormData(this);

            $.ajaxSetup({
                headers: {
                    'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
                }
            });
            $.post({
                url: '{{route('admin.product.update',[$product['id']])}}',
                data: $('#product_form').serialize(),
                data: formData,
                cache: false,
                contentType: false,
                processData: false,
                success: function (data) {
                    if (data.errors) {
                        for (var i = 0; i < data.errors.length; i++) {
                            toastr.error(data.errors[i].message, {
                                CloseButton: true,
                                ProgressBar: true
                            });
                        }
                    } else {
                        toastr.success('product updated successfully!', {
                            CloseButton: true,
                            ProgressBar: true
                        });
                        setTimeout(function () {
                            location.href = '{{route('admin.product.list')}}';
                        }, 2000);
                    }
                }
            });
        });
    </script>

    <script>
        function update_qty() {
            var total_qty = 0;
            var qty_elements = $('input[name^="stock_"]');
            for(var i=0; i<qty_elements.length; i++)
            {
                total_qty += parseInt(qty_elements.eq(i).val());
            }
            if(qty_elements.length > 0)
            {
                $('input[name="total_stock"]').attr("readonly", true);
                $('input[name="total_stock"]').val(total_qty);
                console.log(total_qty)
            }
            else{
                $('input[name="total_stock"]').attr("readonly", false);
            }
        }
    </script>
@endpush


