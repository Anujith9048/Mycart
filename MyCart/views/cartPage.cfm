<cfoutput>
  <cfset local.getlistObj = createObject("component", "models.getlist")>
  <cfset local.cartList = local.getlistObj.getCart(session.userId)>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MyCart|cart</title>

    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>

    <link rel="stylesheet" href="../assets/style/bootstrap.min.css">
    <link rel="stylesheet" href="../assets/style/style.css">
</head>
<body>
    
    <nav class="navbar navbar-expand-lg px-4 justify-content-between position-sticky top-0 bg-light">
        <div class="container-fluid">
          <a class="navbar-brand fw-bold" href="homePage.cfm">MyCart</a>
          <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="##navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
          </button>
        </div>
        <input type="text" name="" id="" class="form-control w-50" placeholder="Search product">
        <div class="collapse navbar-collapse d-flex me-4" id="navbarNavDropdown">
            <ul class="navbar-nav">
              <li class="nav-item dropdown">
                <a class="nav-link" href="cartPage.cfm">
                  Cart
                </a>
              </li>
              <li class="nav-item dropdown">
                <a class="nav-link" href="##" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                  Login
                </a>
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
    
    
    <div class="row d-flex pb-5">
      <div class="cart-wrapper col-8 ">
        <cfloop query="local.cartList.cartItems">
          <div class="col-12 mt-5 px-2  d-flex justify-content-center">
            <div class="col-2 ">
              <img src="../assets/productImage/#FLDPRODUCTIMAGE#" height="150" alt="" class=" float-start">
            </div>
            <div class="col-3 ms-5">
              <h4 class="fw-bold  productname">#FLDPRODUCTNAME#</h4>
              <p class="form-text p-0 productname">#FLDBRANDNAME#</p>
              <p class="form-text p-0 productname">#FLDPRODUCTDESCRIPTION#</p>
              <div class="btn-items d-flex gap-2">
                <a href="##" class="btn btn-outline btn-outline3 removeCart" id="removeCart" pro-id="#FLDPRODUCT_ID#">Remove</a>
                <a href="userProduct.cfm?proid=#FLDPRODUCT_ID#" class="btn btn-outline2" id="productCheck" proid="#FLDPRODUCT_ID#">View</a>
              </div>
            </div>
            <div class="col-3 ms-3">
              <p class="price-tag fw-bolder fs-4 ">&##8377;#FLDPRODUCTPRICE#</p>
            </div>
          </div>
        </cfloop>
      </div>
      

      <div class="col-4 mt-5">
        <div class="col-11  border border-1 rounded px-4 py-4">
          <h5 class="">Price Details</h5>
          <div class="d-flex justify-content-between">
            <p>Total Price</p>
            <cfset local.totalPrice = local.getlistObj.getCartPrice(session.userId)>
            <p class="fw-bold">&##8377;#local.totalPrice.price.SUM#</p>
          </div>
          <a href="" class="btn btn-outline btn-outline1">Bought Together</a>
        </div>
      </div>
    </div>
      





    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
<script src="../assets/script/jquery.js"></script>
</body>
</html>
</cfoutput>