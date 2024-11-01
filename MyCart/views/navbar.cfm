<cfset local.getlistObj = createObject("component", "models.getlist")>
<cfoutput>
<nav class="navbar navbar-expand-lg px-4 py-3 justify-content-between position-sticky top-0 bg-light">
  <div class="container-fluid">
    <a class="navbar-brand fw-bold" href="homePage.cfm"><span class="main-color">My</span>Cart
      <img src="../assets/images/logo-img.png" width="30" alt=""></a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="##navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
  </div>
  <div class="input-group">
    <input type="text" class="form-control" placeholder="Search Product" id="productName">
    <button class="btn btn-outline-secondary" type="button" id="searchItem">Search</button>
  </div>
  <div class="collapse navbar-collapse d-flex me-4" id="navbarNavDropdown">
    <ul class="navbar-nav">
      <li class="nav-item dropdown mx-2">
        <cfset local.count = local.getlistObj.getCartCount()>
        <a href="cartPage.cfm" type="button" class="nav-link btn btn-light position-relative">
          Cart
          <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
            #local.count.count.count#
            <span class="visually-hidden">unread messages</span>
          </span>
        </a>
      </li>
      <li class="nav-item dropdown">
        <cfif session.isLog>
          <a class="nav-link" id="Userlogout" href="##" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            Logout
          </a>
          <cfelse>
            <a class="nav-link" id="" href="userloginPage.cfm" role="button" data-bs-toggle="dropdown" aria-expanded="false">
              Login
            </a>
      </cfif>
      </li>
    </ul>
    </div>
</nav>
</cfoutput>