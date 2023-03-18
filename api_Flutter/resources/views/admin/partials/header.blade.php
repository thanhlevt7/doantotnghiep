<header class="app-header">
    <a class=" app-header__logo" href="{{route('admin.dashboard')}}">Laravel 8</a>
    <!-- Sidebar toggle button--><a class=" app-sidebar__toggle fas fa-list" href="" data-toggle="sidebar"
        aria-label="Hide Sidebar"></a>
    <!-- Navbar Right Menu-->
    <ul class="app-nav">
        <li class="app-search">
            <input class="app-search__input" type="search" placeholder="Search" />
            <button class="app-search__button">
                <i class="fa fa-search"></i>
            </button>
        </li>
        <!--Notification Menu-->
        <li class="dropdown">
            <a class="app-nav__item" href="#" data-toggle="dropdown" aria-label="Open Profile Menu"><i
                    class="fa fa-user-circle" aria-hidden="true"></i></a>
            <ul class="dropdown-menu settings-menu dropdown-menu-right">
               
                <li>
                    <a class="dropdown-item" href="{{ route('admin.account.profile') }}"><i class="fa fa-user"
                            aria-hidden="true"></i> Profile</a>
                </li>
                <li>
                    <a class="dropdown-item" href="{{ route('admin.logout') }}"><i class="fa fa-sign-out"
                            aria-hidden="true"></i> Logout</a>
                </li>
            </ul>
        </li>
    </ul>
    <!-- User Menu-->
</header>
