<div id="sidebarMain" class="d-none">
    <aside
        class="js-navbar-vertical-aside navbar navbar-vertical-aside navbar-vertical navbar-vertical-fixed navbar-expand-xl navbar-bordered  ">
        <div class="navbar-vertical-container text-capitalize">
            <div class="navbar-vertical-footer-offset">
                <div class="navbar-brand-wrapper justify-content-between">
                    <!-- Logo -->

                    @php($restaurant_logo=\App\Model\BusinessSetting::where(['key'=>'logo'])->first()->value)
                    <a class="navbar-brand" href="{{route('admin.dashboard')}}" aria-label="Front">
                        <img class="navbar-brand-logo"
                             onerror="this.src='{{asset('public/assets/admin/img/160x160/img2.jpg')}}'"
                             src="{{asset('storage/app/public/restaurant/'.$restaurant_logo)}}"
                             alt="Logo">
                        <img class="navbar-brand-logo-mini"
                             onerror="this.src='{{asset('public/assets/admin/img/160x160/img2.jpg')}}'"
                             src="{{asset('storage/app/public/restaurant/'.$restaurant_logo)}}" alt="Logo">
                    </a>

                    <!-- End Logo -->

                    <!-- Navbar Vertical Toggle -->
                    <button type="button"
                            class="js-navbar-vertical-aside-toggle-invoker navbar-vertical-aside-toggle btn btn-icon btn-xs btn-ghost-dark">
                        <i class="tio-clear tio-lg"></i>
                    </button>
                    <!-- End Navbar Vertical Toggle -->
                </div>

                <!-- Content -->
                <div class="navbar-vertical-content">
                    <ul class="navbar-nav navbar-nav-lg nav-tabs">
                        <!-- Dashboards -->
                        <li class="navbar-vertical-aside-has-menu {{Request::is('admin')?'show':''}}">
                            <a class="js-navbar-vertical-aside-menu-link nav-link"
                               href="{{route('admin.dashboard')}}" title="Dashboards">
                                <i class="tio-home-vs-1-outlined nav-icon"></i>
                                <span class="navbar-vertical-aside-mini-mode-hidden-elements text-truncate">
                                    {{trans('messages.dashboard')}}
                                </span>
                            </a>
                        </li>
                        <!-- End Dashboards -->


                        <li class="nav-item">
                            <small
                                class="nav-subtitle">{{trans('messages.order')}} {{trans('messages.section')}}</small>
                            <small class="tio-more-horizontal nav-subtitle-replacer"></small>
                        </li>

                        <!-- Pages -->
                        <li class="navbar-vertical-aside-has-menu {{Request::is('admin/orders*')?'active':''}}">
                            <a class="js-navbar-vertical-aside-menu-link nav-link nav-link-toggle" href="javascript:">
                                <i class="tio-shopping-cart nav-icon"></i>
                                <span class="navbar-vertical-aside-mini-mode-hidden-elements text-truncate">
                                    {{trans('messages.order')}}
                                </span>
                            </a>
                            <ul class="js-navbar-vertical-aside-submenu nav nav-sub"
                                style="display: {{Request::is('admin/order*')?'block':'none'}}">
                                <li class="nav-item {{Request::is('admin/orders/list/all')?'active':''}}">
                                    <a class="nav-link" href="{{route('admin.orders.list',['all'])}}" title="">
                                        <span class="tio-circle nav-indicator-icon"></span>
                                        <span class="text-truncate">
                                            {{trans('messages.all')}}
                                            <span class="badge badge-info badge-pill ml-1">
                                                {{\App\Model\Order::count()}}
                                            </span>
                                        </span>
                                    </a>
                                </li>
                                <li class="nav-item {{Request::is('admin/orders/list/pending')?'active':''}}">
                                    <a class="nav-link " href="{{route('admin.orders.list',['pending'])}}" title="">
                                        <span class="tio-circle nav-indicator-icon"></span>
                                        <span class="text-truncate">
                                            {{trans('messages.pending')}}
                                            <span class="badge badge-soft-info badge-pill ml-1">
                                                {{\App\Model\Order::where(['order_status'=>'pending'])->count()}}
                                            </span>
                                        </span>
                                    </a>
                                </li>
                                <li class="nav-item {{Request::is('admin/orders/list/confirmed')?'active':''}}">
                                    <a class="nav-link " href="{{route('admin.orders.list',['confirmed'])}}" title="">
                                        <span class="tio-circle nav-indicator-icon"></span>
                                        <span class="text-truncate">
                                            {{trans('messages.confirmed')}}
                                                <span class="badge badge-soft-success badge-pill ml-1">
                                                {{\App\Model\Order::where(['order_status'=>'confirmed'])->count()}}
                                            </span>
                                        </span>
                                    </a>
                                </li>
                                <li class="nav-item {{Request::is('admin/orders/list/processing')?'active':''}}">
                                    <a class="nav-link " href="{{route('admin.orders.list',['processing'])}}" title="">
                                        <span class="tio-circle nav-indicator-icon"></span>
                                        <span class="text-truncate">
                                            {{trans('messages.processing')}}
                                                <span class="badge badge-warning badge-pill ml-1">
                                                {{\App\Model\Order::where(['order_status'=>'processing'])->count()}}
                                            </span>
                                        </span>
                                    </a>
                                </li>
                                <li class="nav-item {{Request::is('admin/orders/list/out_for_delivery')?'active':''}}">
                                    <a class="nav-link " href="{{route('admin.orders.list',['out_for_delivery'])}}"
                                       title="">
                                        <span class="tio-circle nav-indicator-icon"></span>
                                        <span class="text-truncate">
                                            {{trans('messages.out_for_delivery')}}
                                                <span class="badge badge-warning badge-pill ml-1">
                                                {{\App\Model\Order::where(['order_status'=>'out_for_delivery'])->count()}}
                                            </span>
                                        </span>
                                    </a>
                                </li>
                                <li class="nav-item {{Request::is('admin/orders/list/delivered')?'active':''}}">
                                    <a class="nav-link " href="{{route('admin.orders.list',['delivered'])}}" title="">
                                        <span class="tio-circle nav-indicator-icon"></span>
                                        <span class="text-truncate">
                                            {{trans('messages.delivered')}}
                                                <span class="badge badge-success badge-pill ml-1">
                                                {{\App\Model\Order::where(['order_status'=>'delivered'])->count()}}
                                            </span>
                                        </span>
                                    </a>
                                </li>
                                <li class="nav-item {{Request::is('admin/orders/list/returned')?'active':''}}">
                                    <a class="nav-link " href="{{route('admin.orders.list',['returned'])}}" title="">
                                        <span class="tio-circle nav-indicator-icon"></span>
                                        <span class="text-truncate">
                                            {{trans('messages.returned')}}
                                                <span class="badge badge-soft-danger badge-pill ml-1">
                                                {{\App\Model\Order::where(['order_status'=>'returned'])->count()}}
                                            </span>
                                        </span>
                                    </a>
                                </li>
                                <li class="nav-item {{Request::is('admin/orders/list/failed')?'active':''}}">
                                    <a class="nav-link " href="{{route('admin.orders.list',['failed'])}}" title="">
                                        <span class="tio-circle nav-indicator-icon"></span>
                                        <span class="text-truncate">
                                            {{trans('messages.failed')}}
                                            <span class="badge badge-danger badge-pill ml-1">
                                                {{\App\Model\Order::where(['order_status'=>'failed'])->count()}}
                                            </span>
                                        </span>
                                    </a>
                                </li>

                                <li class="nav-item {{Request::is('admin/orders/list/canceled')?'active':''}}">
                                    <a class="nav-link " href="{{route('admin.orders.list',['canceled'])}}" title="">
                                        <span class="tio-circle nav-indicator-icon"></span>
                                        <span class="text-truncate">
                                            {{trans('messages.canceled')}}
                                                <span class="badge badge-soft-dark badge-pill ml-1">
                                                {{\App\Model\Order::where(['order_status'=>'canceled'])->count()}}
                                            </span>
                                        </span>
                                    </a>
                                </li>
                            </ul>
                        </li>
                        <!-- End Pages -->


                        <li class="nav-item">
                            <small
                                class="nav-subtitle">{{trans('messages.product')}} {{trans('messages.section')}}</small>
                            <small class="tio-more-horizontal nav-subtitle-replacer"></small>
                        </li>

                        <!-- Pages -->
                        <li class="navbar-vertical-aside-has-menu {{Request::is('admin/banner*')?'active':''}}">
                            <a class="js-navbar-vertical-aside-menu-link nav-link nav-link-toggle" href="javascript:"
                            >
                                <i class="tio-image nav-icon"></i>
                                <span
                                    class="navbar-vertical-aside-mini-mode-hidden-elements text-truncate">{{trans('messages.banner')}}</span>
                            </a>
                            <ul class="js-navbar-vertical-aside-submenu nav nav-sub"
                                style="display: {{Request::is('admin/banner*')?'block':'none'}}">
                                <li class="nav-item {{Request::is('admin/banner/add-new')?'active':''}}">
                                    <a class="nav-link " href="{{route('admin.banner.add-new')}}">
                                        <span class="tio-circle nav-indicator-icon"></span>
                                        <span
                                            class="text-truncate">{{trans('messages.add')}} {{trans('messages.new')}}</span>
                                    </a>
                                </li>
                                <li class="nav-item {{Request::is('admin/banner/list')?'active':''}}">
                                    <a class="nav-link " href="{{route('admin.banner.list')}}">
                                        <span class="tio-circle nav-indicator-icon"></span>
                                        <span class="text-truncate">{{trans('messages.list')}}</span>
                                    </a>
                                </li>
                            </ul>
                        </li>
                        <!-- End Pages -->


                        <!-- Pages -->
                        <li class="navbar-vertical-aside-has-menu {{Request::is('admin/category*')?'active':''}}">
                            <a class="js-navbar-vertical-aside-menu-link nav-link nav-link-toggle" href="javascript:"
                            >
                                <i class="tio-category nav-icon"></i>
                                <span
                                    class="navbar-vertical-aside-mini-mode-hidden-elements text-truncate">{{trans('messages.category')}}</span>
                            </a>
                            <ul class="js-navbar-vertical-aside-submenu nav nav-sub"
                                style="display: {{Request::is('admin/category*')?'block':'none'}}">
                                <li class="nav-item {{Request::is('admin/category/add')?'active':''}}">
                                    <a class="nav-link " href="{{route('admin.category.add')}}"
                                       title="add new category">
                                        <span class="tio-circle nav-indicator-icon"></span>
                                        <span class="text-truncate">{{trans('messages.category')}}</span>
                                    </a>
                                </li>

                                <li class="nav-item {{Request::is('admin/category/add-sub-category')?'active':''}}">
                                    <a class="nav-link " href="{{route('admin.category.add-sub-category')}}"
                                       title="add new sub category">
                                        <span class="tio-circle nav-indicator-icon"></span>
                                        <span class="text-truncate">{{trans('messages.sub_category')}}</span>
                                    </a>
                                </li>

                                {{--<li class="nav-item {{Request::is('admin/category/add-sub-sub-category')?'active':''}}">
                                    <a class="nav-link " href="{{route('admin.category.add-sub-sub-category')}}"
                                       title="add new sub sub category">
                                        <span class="tio-circle nav-indicator-icon"></span>
                                        <span class="text-truncate">Sub-Sub-Category</span>
                                    </a>
                                </li>--}}
                            </ul>
                        </li>
                        <!-- End Pages -->


                        <!-- Pages -->
                        <li class="navbar-vertical-aside-has-menu {{Request::is('admin/attribute*')?'active':''}}">
                            <a class="js-navbar-vertical-aside-menu-link nav-link"
                               href="{{route('admin.attribute.add-new')}}"
                            >
                                <i class="tio-apps nav-icon"></i>
                                <span class="navbar-vertical-aside-mini-mode-hidden-elements text-truncate">
                                    {{trans('messages.attribute')}}
                                </span>
                            </a>
                        </li>
                        <!-- End Pages -->

                        <!-- Pages -->
                        <li class="navbar-vertical-aside-has-menu {{Request::is('admin/product*')?'active':''}}">
                            <a class="js-navbar-vertical-aside-menu-link nav-link nav-link-toggle" href="javascript:"
                            >
                                <i class="tio-premium-outlined nav-icon"></i>
                                <span
                                    class="navbar-vertical-aside-mini-mode-hidden-elements text-truncate">{{trans('messages.product')}}</span>
                            </a>
                            <ul class="js-navbar-vertical-aside-submenu nav nav-sub"
                                style="display: {{Request::is('admin/product*')?'block':'none'}}">
                                <li class="nav-item {{Request::is('admin/product/add-new')?'active':''}}">
                                    <a class="nav-link " href="{{route('admin.product.add-new')}}"
                                       title="add new product">
                                        <span class="tio-circle nav-indicator-icon"></span>
                                        <span
                                            class="text-truncate">{{trans('messages.add')}} {{trans('messages.new')}}</span>
                                    </a>
                                </li>
                                <li class="nav-item {{Request::is('admin/product/list')?'active':''}}">
                                    <a class="nav-link " href="{{route('admin.product.list')}}" title="product list">
                                        <span class="tio-circle nav-indicator-icon"></span>
                                        <span class="text-truncate">{{trans('messages.list')}}</span>
                                    </a>
                                </li>
                            </ul>
                        </li>
                        <!-- End Pages -->

                        <li class="nav-item">
                            <small class="nav-subtitle"
                                   title="Layouts">{{trans('messages.business')}} {{trans('messages.section')}}</small>
                            <small class="tio-more-horizontal nav-subtitle-replacer"></small>
                        </li>

                        <!-- Pages -->
                        <li class="navbar-vertical-aside-has-menu {{Request::is('admin/branch*')?'active':''}}">
                            <a class="js-navbar-vertical-aside-menu-link nav-link"
                               href="{{route('admin.branch.add-new')}}"
                            >
                                <i class="tio-shop nav-icon"></i>
                                <span class="navbar-vertical-aside-mini-mode-hidden-elements text-truncate">
                                    {{trans('messages.branch')}}
                                </span>
                            </a>
                        </li>
                        <!-- End Pages -->

                        <!-- Pages -->
                        <li class="navbar-vertical-aside-has-menu {{Request::is('admin/message*')?'active':''}}">
                            <a class="js-navbar-vertical-aside-menu-link nav-link"
                               href="{{route('admin.message.list')}}"
                            >
                                <i class="tio-messages nav-icon"></i>
                                <span class="navbar-vertical-aside-mini-mode-hidden-elements text-truncate">
                                    {{trans('messages.messages')}}
                                </span>
                            </a>
                        </li>
                        <!-- End Pages -->
                        <li class="navbar-vertical-aside-has-menu {{Request::is('admin/timeSlot*')?'active':''}}">
                            <a class="js-navbar-vertical-aside-menu-link nav-link" href="{{route('admin.timeSlot.add-new')}}"
                               title="Pages">
                                <i class="tio-clock nav-icon"></i>
                                <span
                                    class="navbar-vertical-aside-mini-mode-hidden-elements text-truncate">{{trans('messages.Set')}} {{trans('messages.Time Slot')}} </span>
                            </a>
                        </li>

                        <!-- Pages -->
                        <li class="navbar-vertical-aside-has-menu {{Request::is('admin/reviews*')?'active':''}}">
                            <a class="js-navbar-vertical-aside-menu-link nav-link"
                               href="{{route('admin.reviews.list')}}"
                            >
                                <i class="tio-star nav-icon"></i>
                                <span class="navbar-vertical-aside-mini-mode-hidden-elements text-truncate">
                                    {{trans('messages.product')}} {{trans('messages.reviews')}}
                                </span>
                            </a>
                        </li>
                        <!-- End Pages -->


                        <!-- Pages -->
                        <li class="navbar-vertical-aside-has-menu {{Request::is('admin/notification*')?'active':''}}">
                            <a class="js-navbar-vertical-aside-menu-link nav-link"
                               href="{{route('admin.notification.add-new')}}"
                            >
                                <i class="tio-notifications nav-icon"></i>
                                <span class="navbar-vertical-aside-mini-mode-hidden-elements text-truncate">
                                    {{trans('messages.send')}} {{trans('messages.notification')}}
                                </span>
                            </a>
                        </li>
                        <!-- End Pages -->

                        <!-- Pages -->
                        <li class="navbar-vertical-aside-has-menu {{Request::is('admin/coupon*')?'active':''}}">
                            <a class="js-navbar-vertical-aside-menu-link nav-link"
                               href="{{route('admin.coupon.add-new')}}"
                            >
                                <i class="tio-gift nav-icon"></i>
                                <span
                                    class="navbar-vertical-aside-mini-mode-hidden-elements text-truncate">{{trans('messages.coupon')}}</span>
                            </a>
                        </li>
                        <!-- End Pages -->

                        <!-- Pages -->
                        <li class="navbar-vertical-aside-has-menu {{Request::is('admin/business-settings*')?'active':''}}">
                            <a class="js-navbar-vertical-aside-menu-link nav-link nav-link-toggle" href="javascript:"
                            >
                                <i class="tio-settings nav-icon"></i>
                                <span
                                    class="navbar-vertical-aside-mini-mode-hidden-elements text-truncate">{{trans('messages.settings')}}</span>
                            </a>
                            <ul class="js-navbar-vertical-aside-submenu nav nav-sub"
                                style="display: {{Request::is('admin/business-settings*')?'block':'none'}}">
                                <li class="nav-item {{Request::is('admin/business-settings/ecom-setup')?'active':''}}">
                                    <a class="nav-link " href="{{route('admin.business-settings.ecom-setup')}}"
                                    >
                                        <span class="tio-circle nav-indicator-icon"></span>
                                        <span
                                            class="text-truncate">{{trans('messages.restaurant')}} {{trans('messages.setup')}}</span>
                                    </a>
                                </li>
                                <li class="nav-item {{Request::is('admin/business-settings/location-setup')?'active':''}}">
                                    <a class="nav-link " href="{{route('admin.business-settings.location-setup')}}"
                                    >
                                        <span class="tio-circle nav-indicator-icon"></span>
                                        <span
                                            class="text-truncate">{{trans('messages.location')}} {{trans('messages.setup')}}</span>
                                    </a>
                                </li>
                                <li class="nav-item {{Request::is('admin/business-settings/mail-config')?'active':''}}">
                                    <a class="nav-link " href="{{route('admin.business-settings.mail-config')}}"
                                    >
                                        <span class="tio-circle nav-indicator-icon"></span>
                                        <span
                                            class="text-truncate">{{trans('messages.mail')}} {{trans('messages.config')}}</span>
                                    </a>
                                </li>
                                {{--<li class="nav-item {{Request::is('admin/business-settings/currency-add')?'active':''}}">
                                    <a class="nav-link " href="{{route('admin.business-settings.currency-add')}}"
                                       >
                                        <span class="tio-circle nav-indicator-icon"></span>
                                        <span class="text-truncate">Add Currency</span>
                                    </a>
                                </li>--}}
                                <li class="nav-item {{Request::is('admin/business-settings/payment-method')?'active':''}}">
                                    <a class="nav-link " href="{{route('admin.business-settings.payment-method')}}"
                                    >
                                        <span class="tio-circle nav-indicator-icon"></span>
                                        <span
                                            class="text-truncate">{{trans('messages.payment')}} {{trans('messages.methods')}}</span>
                                    </a>
                                </li>

                                <li class="nav-item {{Request::is('admin/business-settings/fcm-index')?'active':''}}">
                                    <a class="nav-link " href="{{route('admin.business-settings.fcm-index')}}"
                                       title="">
                                        <span class="tio-circle nav-indicator-icon"></span>
                                        <span
                                            class="text-truncate">{{trans('messages.push')}} {{trans('messages.notification')}}</span>
                                    </a>
                                </li>

                                <li class="nav-item {{Request::is('admin/business-settings/terms-and-conditions')?'active':''}}">
                                    <a class="nav-link "
                                       href="{{route('admin.business-settings.terms-and-conditions')}}"
                                    >
                                        <span class="tio-circle nav-indicator-icon"></span>
                                        <span class="text-truncate">{{trans('messages.terms_and_condition')}}</span>
                                    </a>
                                </li>

                                <li class="nav-item {{Request::is('admin/business-settings/privacy-policy')?'active':''}}">
                                    <a class="nav-link "
                                       href="{{route('admin.business-settings.privacy-policy')}}">
                                        <span class="tio-circle nav-indicator-icon"></span>
                                        <span class="text-truncate">{{trans('messages.privacy_policy')}}</span>
                                    </a>
                                </li>

                                <li class="nav-item {{Request::is('admin/business-settings/about-us')?'active':''}}">
                                    <a class="nav-link "
                                       href="{{route('admin.business-settings.about-us')}}">
                                        <span class="tio-circle nav-indicator-icon"></span>
                                        <span class="text-truncate">{{trans('messages.about_us')}}</span>
                                    </a>
                                </li>
                            </ul>
                        </li>
                        <!-- End Pages -->

                        <li class="nav-item">
                            <small class="nav-subtitle"
                                   title="Layouts">{{trans('messages.deliveryman')}} {{trans('messages.section')}}</small>
                            <small class="tio-more-horizontal nav-subtitle-replacer"></small>
                        </li>

                        <!-- Pages -->
                        <li class="navbar-vertical-aside-has-menu {{Request::is('admin/delivery-man/add')?'active':''}}">
                            <a class="js-navbar-vertical-aside-menu-link nav-link"
                               href="{{route('admin.delivery-man.add')}}"
                            >
                                <i class="tio-running nav-icon"></i>
                                <span class="navbar-vertical-aside-mini-mode-hidden-elements text-truncate">
                                    {{trans('messages.register')}}
                                </span>
                            </a>
                        </li>
                        <!-- End Pages -->

                        <!-- Pages -->
                        <li class="navbar-vertical-aside-has-menu {{Request::is('admin/delivery-man/list')?'active':''}}">
                            <a class="js-navbar-vertical-aside-menu-link nav-link"
                               href="{{route('admin.delivery-man.list')}}"
                            >
                                <i class="tio-filter-list nav-icon"></i>
                                <span class="navbar-vertical-aside-mini-mode-hidden-elements text-truncate">
                                    {{trans('messages.list')}}
                                </span>
                            </a>
                        </li>

                        <li class="navbar-vertical-aside-has-menu {{Request::is('admin/delivery-man/reviews/list')?'active':''}}">
                            <a class="js-navbar-vertical-aside-menu-link nav-link"
                               href="{{route('admin.delivery-man.reviews.list')}}"
                            >
                                <i class="tio-star-outlined nav-icon"></i>
                                <span class="navbar-vertical-aside-mini-mode-hidden-elements text-truncate">
                                    {{trans('messages.reviews')}}
                                </span>
                            </a>
                        </li>
                        <!-- End Pages -->

                        <li class="nav-item">
                            <small class="nav-subtitle"
                                   title="Documentation">{{trans('messages.customer')}} {{trans('messages.section')}}</small>
                            <small class="tio-more-horizontal nav-subtitle-replacer"></small>
                        </li>

                        <!-- Pages -->
                        <li class="navbar-vertical-aside-has-menu {{Request::is('admin/customer*')?'active':''}}">
                            <a class="js-navbar-vertical-aside-menu-link nav-link"
                               href="{{route('admin.customer.list')}}"
                            >
                                <i class="tio-poi-user nav-icon"></i>
                                <span class="navbar-vertical-aside-mini-mode-hidden-elements text-truncate">
                                    {{trans('messages.customer')}} {{trans('messages.list')}}
                                </span>
                            </a>
                        </li>
                        <!-- End Pages -->

                        <li class="nav-item">
                            <div class="nav-divider"></div>
                        </li>

                        <li class="nav-item">
                            <small class="nav-subtitle"
                                   title="Documentation">{{trans('messages.report_and_analytics')}}</small>
                            <small class="tio-more-horizontal nav-subtitle-replacer"></small>
                        </li>

                        <!-- Pages -->
                        <li class="navbar-vertical-aside-has-menu {{Request::is('admin/report*')?'active':''}}">
                            <a class="js-navbar-vertical-aside-menu-link nav-link nav-link-toggle" href="javascript:"
                            >
                                <i class="tio-report-outlined nav-icon"></i>
                                <span
                                    class="navbar-vertical-aside-mini-mode-hidden-elements text-truncate">{{trans('messages.reports')}}</span>
                            </a>
                            <ul class="js-navbar-vertical-aside-submenu nav nav-sub"
                                style="display: {{Request::is('admin/report*')?'block':'none'}}">
                                <li class="nav-item {{Request::is('admin/report/earning')?'active':''}}">
                                    <a class="nav-link " href="{{route('admin.report.earning')}}"
                                    >
                                        <span class="tio-circle nav-indicator-icon"></span>
                                        <span
                                            class="text-truncate">{{trans('messages.earning')}} {{trans('messages.report')}}</span>
                                    </a>
                                </li>
                                <li class="nav-item {{Request::is('admin/report/order')?'active':''}}">
                                    <a class="nav-link " href="{{route('admin.report.order')}}"
                                    >
                                        <span class="tio-circle nav-indicator-icon"></span>
                                        <span
                                            class="text-truncate">{{trans('messages.order')}} {{trans('messages.report')}}</span>
                                    </a>
                                </li>
                            </ul>
                        </li>
                        <!-- End Pages -->

                        <li class="nav-item" style="padding-top: 100px">
                            <div class="nav-divider"></div>
                        </li>
                    </ul>
                </div>
                <!-- End Content -->
            </div>
        </div>
    </aside>
</div>
