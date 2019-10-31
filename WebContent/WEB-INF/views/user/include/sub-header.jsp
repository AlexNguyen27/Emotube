 <header>
      <nav
        class="navbar navbar-expand-lg navbar-dark bg-dark pt-1 pb-1"
        style="background-color:#374850!important;"
      >
        <a class="navbar-brand" style="  color: #ff9999 !important;"  href="${param.userRole=='admin' ? 'admin/user-list.htm' : 'user/home.htm'}"
          ><b>${param.userRole=='admin' ? 'AdminEMOTUBE' : "EMOTUBE"}</b></a
        >
        <button
          class="navbar-toggler"
          type="button"
          data-toggle="collapse"
          data-target="#navbarSupportedContent"
          aria-controls="navbarSupportedContent"
          aria-expanded="false"
          aria-label="Toggle navigation"
        >
          <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarSupportedContent">
          <ul class="navbar-nav mr-auto">
            <li class="nav-item active">
              <a class="nav-link" href="${param.userRole=='admin' ? 'admin/admin-info.htm' : 'user/your-channel.htm'}"
                >Your Channel<span class="sr-only">(current)</span></a
              >
            </li>
          </ul>
          <form class="form-inline my-2 my-lg-0">
            <ul class="navbar-nav mr-auto">
              <%-- <li class="nav-item active">
               <a href="#" class="nav-link pr-4">
                  <img
                    style="width: 38px; padding-right: 10px"
                    src="./files/${user.profile_image}"
                    class="user-image"
                    alt="profile image"
                  /><span class="hidden-xs">${user.first_name} ${user.last_name}</span>
                </a>
              </li>  --%>
              <li class="nav-item active">
                <a href="log-out.htm" class="nav-link">
                  <i class="fas fa-sign-out-alt"></i>
                  <span class="hidden-xs">Log out </span>
                </a>
              </li>
            </ul>
          </form>
        </div>
      </nav>
    </header>