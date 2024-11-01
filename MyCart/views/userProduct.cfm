<cfoutput>
  <cfset local.getlistObj = createObject("component", "models.getlist")>
  <cfset local.productslist = local.getlistObj.getSingleProduct(url.proid)>
  <cfset local.product = local.productslist.product>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MyCart|#local.product.FLDPRODUCTNAME#</title>

    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>

    <link rel="stylesheet" href="../assets/style/bootstrap.min.css">
    <link rel="stylesheet" href="../assets/style/style.css">
</head>
<body>
    
  <cfinclude  template="navbar.cfm">

  <cfinclude  template="bottomNav.cfm">
    
    
      <div class="row mt-5 px-4 justify-content-center">
        <div class="col-md-6 col-12 justify-content-center d-flex ">
          <img src="../assets/productImage/#local.product.FLDPRODUCTIMAGE#" height="400" alt="" class="float-end">
        </div>
        <div class="col-md-6 col-12 pe-4">
          <h4 class="fw-bold pt-4">#local.product.FLDPRODUCTNAME#</h4>
          <p class="form-text p-0">#local.product.FLDBRANDNAME#</p>
          <p class="fs-5"><span class="fw-bold form-text"> <u>Description:</u> </span>#local.product.FLDPRODUCTDESCRIPTION#</p>
          <p class="price-tag fw-bolder fs-4">&##8377;#local.product.FLDPRODUCTPRICE#</p>
          <div class="btn-items d-flex gap-2">
            <a href="##" class="btn btn-outline btn-outline1" id="buyNow" pro-id="#url.proid#">Buy Now</a>
            <a href="##" class="btn btn-outline2" id="addToCart" pro-id="#url.proid#">Add to Cart</a>
          </div>
        </div>
      </div>





    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
<script src="../assets/script/jquery.js"></script>
</body>
</html>
</cfoutput>