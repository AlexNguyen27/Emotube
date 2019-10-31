<header class="main-header">
  <!-- Logo -->
  <a href="user/home.htm" class="logo">
    <!-- mini logo for sidebar mini 50x50 pixels -->
    <span class="logo-mini">Emo</span>
    <!-- logo for regular state and mobile devices -->
    <span class="logo-lg"><b>EMOTUBE</b></span>
  </a>
  <!-- Header Navbar: style can be found in header.less -->
  <nav class="navbar navbar-static-top" style="height: 10px">
    <!-- Sidebar toggle button-->
    <a
      href="#"
      class="sidebar-toggle"
      data-toggle="push-menu"
      role="button"
      style="height: 50px;"
    >
      <span class="sr-only">Toggle navigation</span> <i class="fas fa-bars"></i>
    </a>

    <div class="navbar-custom-menu">
      <ul class="nav navbar-nav">
        <!-- User Account: style can be found in dropdown.less -->
        <li class="dropdown user user-menu">
          <a href="user/your-channel.htm" class="dropdown-toggle" data-toggle="dropdown">
            <img
              style="width: 25px!important"
            	src="./files/${param.profile_image}"
              class="user-image"
              alt="profile image"
            /><span class="hidden-xs">${param.fullname}</span>
          </a>
        </li>
        <!-- Control Sidebar Toggle Button -->
        <li class="active">
          <a href="log-out.htm">
            <i class="fas fa-sign-out-alt"> Log out</i>
          </a>
        </li>
      </ul>
    </div>
  </nav>
</header>
