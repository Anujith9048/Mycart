<cfoutput>
  <cfset local.getlistObj = createObject("component", "models.getlist")>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MyCart|Home</title>

    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>

    <link rel="stylesheet" href="../assets/style/bootstrap.min.css">
    <link rel="stylesheet" href="../assets/style/style.css">
</head>
<body>
    
  <nav class="navbar navbar-expand-lg px-4 py-3 justify-content-between position-sticky top-0 bg-light">
    <div class="container-fluid">
      <a class="navbar-brand fw-bold" href="##">MyCart</a>
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="##navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
    </div>
    <input type="text" name="" id="" class="form-control w-50" placeholder="Search product">
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
              <a class="nav-link" id="login" href="userloginPage.cfm" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                Login
              </a>
        </cfif>
        </li>
      </ul>
      </div>
</nav>

<!-- Category List -->
    <div class="row ">
      <div class="container-fluid bg-dark text-light px-5">
        <div class="collapse navbar-collapse d-flex" id="navbarNavDropdown">
          <ul class="navbar-nav w-100 d-flex flex-row justify-content-between">
            <cfset local.categorylist = local.getlistObj.getCategories()>
            <cfloop query="local.categorylist.categories">
              <li class="nav-item">
                <a class="nav-link dropdown-toggle" href="##" role="button" data-bs-toggle="dropdown" aria-expanded="false" cate-id="#FLDCATEGORY_ID#">
                  #FLDCATEGORY_NAME#
                </a>
                <ul class="dropdown-menu dropdown-menu-dark" aria-labelledby="navbarDarkDropdownMenuLink" cate-id="#FLDCATEGORY_ID#">
                  <cfset local.subcategorylist = local.getlistObj.getSubCategories(FLDCATEGORY_ID)>
                  <cfloop query="local.subcategorylist.subcategories">
                    <li class="subcategory-item" sub-id="#FLDSUBCATEGORY_ID#"><a class="dropdown-item " href="userProductList.cfm?subid=#FLDSUBCATEGORY_ID#">#FLDSUBCATEGORYNAME#</a></li>
                  </cfloop>
                </ul>
              </li>
            </cfloop>
          </ul>
        </div>
      </div>
    </div>
    
    <div class="container-fluid px-4 mt-4">
      <div class="row">
        <cfset local.subcategoryName =local.getlistObj.getSubcategoryName(#url.subid#)>
        <cfset local.subcategory = local.subcategoryName.category.FLDSUBCATEGORYNAME>
        <h4 class="fw-bold">#local.subcategory#</h4>
      </div>

      <div class="row">
            
            <cfset local.productslist = local.getlistObj.getProducts(url.subid)>
            <cfloop query="local.productslist.products">
              <div class="col-md-3">
                <div class="card" style="width: 18rem; height: 24rem;">
                  <img src="../assets/productImage/#FLDPRODUCTIMAGE#" class="card-img-top p-2 " width="70" height="200" alt="...">
                  <div class="card-body">
                    <h5 class="card-title productname">#FLDPRODUCTNAME#</h5>
                    <p class="card-text productname">#FLDPRODUCTDESCRIPTION#</p>
                    <p class="card-text fw-bold price-tag">&##8377;#FLDPRODUCTPRICE#</p>
                    <a href="userProduct.cfm?proid=#FLDPRODUCT_ID#" class="btn btn-primary" id="productCheck" proid="#FLDPRODUCT_ID#">Check</a>
                  </div>
                </div>
              </div>
            </cfloop>

        </div>
      </div>
    </div>





    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
<script src="../assets/script/jquery.js"></script>
</body>
</html>
</cfoutput>