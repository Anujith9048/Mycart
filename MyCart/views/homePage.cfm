<!DOCTYPE html>
<html lang="en">
   <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <title>MyCart | Home</title>
      <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
      <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
      <link rel="stylesheet" href="../assets/style/bootstrap.min.css">
      <link rel="stylesheet" href="../assets/style/style.css">
      <link rel="icon" type="image/x-icon" href="../assets/images/logo-img.png">
   </head>
   <body>
      <cfinclude  template="navbar.cfm">
      <cfinclude  template="bottomNav.cfm">
      <div id="carouselExampleCaptions" class="carousel slide" data-bs-ride="carousel">
         <div class="carousel-indicators">
         </div>
         <div class="carousel-inner">
            <div class="carousel-item active">
               <img src="../assets/images/carousel1.jpg" class="d-block w-100" alt="...">
               <div class="carousel-caption d-none d-md-block">
                  <h5 class="shadow text-dark fw-bolder border border-1 col-5 bg-light mx-auto py-2 rounded-pill">Welcome To <a class="navbar-brand fw-bold"><span class="main-color">My</span>Cart
                     <img src="../assets/images/logo-img.png" width="30" alt=""></a>
                  </h5>
               </div>
            </div>
         </div>
      </div>
      <cfoutput>
         <!-- Random Products -->
         <div class="random-product-list px-4 mt-3">
            <h4 class="fw-bold py-2">Random Products</h4>
            <div class="row d-flex">
                <cfset local.randomlist = application.getlistObj.getRandomProducts()>
        
                <cfloop query="local.randomlist.products">
                    <cfset local.image = FLDPRODUCTTHUMBNAIL>
                    <a href="userProduct.cfm?proid=#FLDPRODUCT_ID#" class="col-md-3 mt-3 text-decor-none" proid="#FLDPRODUCT_ID#">
                        <div class="card">
                            <img src="../assets/productImage/#local.image#" class="card-img-top p-2" alt="Product Image">
                            <div class="card-body">
                                <h5 class="card-title productname">#FLDPRODUCTNAME#</h5>
                                <p class="card-text productname">#FLDPRODUCTDESCRIPTION#</p>
                                <p class="card-text fw-bold price-tag">&##8377;#FLDPRODUCTPRICE#</p>
                            </div>
                        </div>
                    </a>
                </cfloop>
            </div>
        </div>
        

         <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
         <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
         <script src="../assets/script/jquery.js"></script>
      </cfoutput>
   </body>
   <cfinclude  template="footer.cfm">
</html>