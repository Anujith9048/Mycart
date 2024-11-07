<cfset local.getlistObj = createObject("component", "models.getlist")>
<cfoutput>
   <nav class="navbar navbar-expand-lg px-4 py-3 justify-content-between position-sticky top-0 bg-light shadow">
      <div class="container-fluid">
         <a class="navbar-brand fw-bold" href="homePage.cfm"><span class="main-color">My</span>Cart
         <img src="../assets/images/logo-img.png" width="30" alt=""></a>
      </div>
      <div class="input-group">
         <input type="text" class="form-control" placeholder="Search Product" id="productName">
         <button class="btn btn-outline-secondary" type="button" id="searchItem">Search</button>
      </div>
      <div class="collapse navbar-collapse d-flex me-4" id="navbarNavDropdown">
         <ul class="navbar-nav">
            <a href="userProfile.cfm" class="text-decoration-none ms-2">
               <li class="nav-item dropdown align-items-center d-flex mx-2 " style="cursor: pointer;" >
                  <img src="../assets/images/default_user22.png" width="20" height="20" alt="" title="Profile" >
                  <p class="mb-0 nav-link ">profile</p>
               </li>
            </a>
            <li class="nav-item dropdown mx-2">
               <cfif session.islog>
                  <cfset local.count = local.getlistObj.getCartCount()>
                  <a href="cartPage.cfm" type="button" class="nav-link btn btn-light position-relative">
                  Cart
                  <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
                  #local.count.count.count#
                  <span class="visually-hidden">Items in cart</span>
                  </span>
                  </a>
                  <cfelse>
                  <a href="cartPage.cfm" type="button" class="nav-link btn btn-light position-relative">
                  Cart
                  </a>
               </cfif>
            </li>
            <li class="nav-item dropdown mx-2">
               <cfif session.isLog>
                  <a class="nav-link btn btn-light" id="Userlogout" href="##">
                  Logout
                  </a>
                  <cfelse>
                  <a class="nav-link btn btn-light" href="../views/userloginPage.cfm">
                  Login
                  </a>
               </cfif>
            </li>
         </ul>
      </div>
   </nav>
</cfoutput>