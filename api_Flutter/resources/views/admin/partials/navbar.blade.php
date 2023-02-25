 <!-- Sidebar menu-->

 <div class="app-sidebar__overlay" data-toggle="sidebar"></div>
 <aside class="app-sidebar">

     <div class="app-sidebar__user">
         <div>
          <img class="app-sidebar__user-avatar" src="{{asset('backend/assets/img/avaters')}}/{{Session::get('emp')->avatar}}" width="40px" height="40px">
             <p class="app-sidebar__user-name">{{ Session::get('emp')->fullName }}</p>
             <p class="app-sidebar__user-designation">Vị trí: {{ Session::get('emp')->type }}</p>

         </div>
     </div>
     </div>
     <ul class="app-menu">
         <li>
             <a class="app-menu__item active" href="{{ route('admin.dashboard') }}">
                 <i class="fa fa-th-list" aria-hidden="true"></i></i>
                 <span class="app-menu__label">Dashboard</span>
             </a>
         </li>
         <li class="treeview">
             <a class="app-menu__item" href="#" data-toggle="treeview">
                 <i class="fa fa-users" aria-hidden="true"></i></i>
                 <span class="app-menu__label">Quản lí nhân sự</span>
                 <i class="fa fa-angle-right" aria-hidden="true"></i>
             </a>
        <ul class="treeview-menu">
            <li><a class="treeview-item" href="{{ route('admin.account') }}"><i
                             class="icon fa fa-circle-o"></i>Tài khoản người dùng</a>
            </li>
            <li>
                <a class="treeview-item" href="{{ route('admin.employee.index') }}">
                    <i class="icon fa fa-circle-o"></i>
                    Tài khoản nhân viên
                </a>
            </li>
        </ul>
         </li>
         <li>
            <a class="app-menu__item" href="{{ route('admin.product') }}">
                 <i class="app-menu__icon fa fa-pie-chart"></i>
                 <span class="app-menu__label">Sản phẩm</span>
            </a>
        </li>
        <li>
            <a class="app-menu__item" href="{{route('admin.vouchers.index')}}">
                 <i class="app-menu__icon fa fa-pie-chart"></i>
                 <span class="app-menu__label">Khuyến mãi</span>
            </a>
        </li>
        <li>
            <a class="app-menu__item" href="{{route('admin.reviews.index')}}">
                 <i class="app-menu__icon fa fa-pie-chart"></i>
                 <span class="app-menu__label">Xem Đánh giá</span>
            </a>
        </li>
        <li>
            <a class="app-menu__item" href="{{route('admin.notifications.index')}}">
                 <i class="app-menu__icon fa fa-pie-chart"></i>
                 <span class="app-menu__label">Thông báo</span>
            </a>
        </li>
        <li class="treeview">
             <a class="app-menu__item" href="#" data-toggle="treeview">
                <i class="app-menu__icon fa fa-laptop"></i>
                <span class="app-menu__label">Quản lí hóa đơn</span>
                <i class="treeview-indicator fa fa-angle-right"></i>
            </a>

             <ul class="treeview-menu">

                <li>
                     <a class="treeview-item" href=" {{ route('admin.invoice.orderTracking') }}">
                         <i class="icon fa fa-circle-o"></i>Theo dõi các đơn hàng
                    </a>
                </li>
                </li>
             </ul>
         </li>

     </ul>
 </aside>
