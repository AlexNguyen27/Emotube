<aside class="main-sidebar">
  <!-- sidebar: style can be found in sidebar.less -->
  <section class="sidebar">
    <!-- Sidebar user panel -->
    <div class="user-panel">
      <div class="pull-left image">
        <img
          src="./files/${param.profile_image}"
          class="img-circle"
          alt="User Image"
        />
      </div>
      <div class="pull-left info">
        <p>${param.fullname}</p>
        <span style="font-size: 11px"><i class="fa fa-circle text-success"></i>  Online</span>
      </div>
    </div>
    <!-- search form -->
    <!--   <form action="#" method="get" class="sidebar-form">
          <div class="input-group">
            <input type="text" name="q" class="form-control" placeholder="Search...">
            <span class="input-group-btn">
              <button type="submit" name="search" id="search-btn" class="btn btn-flat"><i class="fa fa-search"></i>
              </button>
            </span>
          </div>
        </form> -->
    <!-- /.search form -->
    <!-- sidebar menu: : style can be found in sidebar.less -->
    <ul class="sidebar-menu" data-widget="tree">
      <li class="header">MAIN SECTION</li>
       <li class="menu">
        <a href="admin/admin-info.htm">
          <i class="fa fa-user"></i> <span>Your Info</span>
        </a>
      </li>
      <li class="menu">
        <a href="admin/user-list.htm">
          <i class="fa fa-list-ol" aria-hidden="true"></i> <span>Users</span>
        </a>
      </li>

      <li class="menu">
        <a href="admin/category-list.htm">
          <i class="fa fa-folder"></i> <span>Categories</span>
        </a>
      </li>
      <!--  <li class="menu">
            <a href="admin/videos.htm">
              <i class="fa fa-bell"></i> <span>Awaiting approval</span>
            </a>
          </li> -->
      <li class="menu">
        <a href="log-out.htm">
          <i class="fas fa-sign-out-alt"></i> <span>Log out</span>
        </a>
      </li>

      <li class="header">MORE</li>
      <li>
        <a ><i class="fa fa-question"></i> <span>Help</span></a>
      </li>
      <li>
        <a
          ><i class="fa fa-comments"></i> <span>Send feedback</span></a
        >
      </li>
      <li>
        <a><i class="fa fa-cogs"></i> <span>Settings</span></a>
      </li>
    </ul>
  </section>
  <!-- /.sidebar -->
</aside>
