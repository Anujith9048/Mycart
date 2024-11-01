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
    
    <cfinclude  template="navbar.cfm">
  <cfinclude  template="bottomNav.cfm">

    
<!-- Carousel -->
    <div id="carouselExampleCaptions" class="carousel slide" data-bs-ride="carousel">
      <div class="carousel-indicators">
        <button type="button" class="bg-dark" data-bs-target="##carouselExampleCaptions" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
        <button type="button" class="bg-dark" data-bs-target="##carouselExampleCaptions" data-bs-slide-to="1" aria-label="Slide 2"></button>
        <button type="button" class="bg-dark" data-bs-target="##carouselExampleCaptions" data-bs-slide-to="2" aria-label="Slide 3"></button>
      </div>
      <div class="carousel-inner image-show">
        <div class="carousel-item active">
          <div class="carousel-caption d-none d-md-block">
            <h5>First slide label</h5>
            <p>Some representative placeholder content for the first slide.</p>
          </div>
          <img src="../assets/images/carousel1.jpg" class="d-block w-100" alt="...">
        </div>
        <div class="carousel-item">
          <img src="../assets/images/carousel2.webp" class="d-block w-100" alt="...">
          <div class="carousel-caption d-none d-md-block">
            <h5>Second slide label</h5>
            <p>Some representative placeholder content for the second slide.</p>
          </div>
        </div>
        <div class="carousel-item">
          <img src="../assets/images/carousel3.jpg" class="d-block w-100" alt="...">
          <div class="carousel-caption d-none d-md-block">
            <h5>Third slide label</h5>
            <p>Some representative placeholder content for the third slide.</p>
          </div>
        </div>
      </div>
      <button class="carousel-control-prev" type="button" data-bs-target="##carouselExampleCaptions" data-bs-slide="prev">
        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
        <span class="visually-hidden">Previous</span>
      </button>
      <button class="carousel-control-next" type="button" data-bs-target="##carouselExampleCaptions" data-bs-slide="next">
        <span class="carousel-control-next-icon" aria-hidden="true"></span>
        <span class="visually-hidden">Next</span>
      </button>
    </div>

    <!-- Random Products -->
    <div class="random-product-list px-4 mt-3">
      <h4 class="fw-bold py-2">Random Products</h4>
      <div class="row ">
        <cfset local.randomlist = local.getlistObj.getRandomProducts()>
        <cfloop query="local.randomlist.products">
          <div class="col-md-3 col-12">
            <div class="card" style="width: 18rem; height: 24rem;">
              <img src="../assets/productImage/#FLDPRODUCTIMAGE#" class="card-img-top p-2" width="80" height="200" alt="...">
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






    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
<script src="../assets/script/jquery.js"></script>
</body>
</html>
</cfoutput>