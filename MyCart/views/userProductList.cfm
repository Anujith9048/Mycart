
<cfoutput>
  <cfinclude  template="listcondition.cfm">
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
    
  <cfinclude  template="navbar.cfm">

  <cfinclude  template="bottomNav.cfm">
    
    <div class="container-fluid px-4 mt-4">
      <div class="row d-flex">
        <h4 class="fw-bold">#local.subcategory#</h4>
        <div class="d-flex gap-4 mb-2">
          <a href="" class="text-decoration-none sort" type="asc"  data-mode="#variable.mode#" data-id="#variable.data#">Price: Low to High</a>
          <a href="" class="text-decoration-none sort" type="desc" data-mode="#variable.mode#" data-id="#variable.data#">Price: High to Low</a>
        </div>
      </div>

      <div class="row">
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