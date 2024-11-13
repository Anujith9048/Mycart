<cfoutput>
  <cfinclude  template="listcondition.cfm">
  <!DOCTYPE html>
  <html lang="en">
     <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>MyCart|#local.subcategory#</title>
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
                 <cfif structKeyExists(url, "subid")>
                     <a href=""class="btn btn-light ms-auto float-end border border-1" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">
                     <img src="../assets/images/filter.png" class="mb-1 me-2" width="20" alt="">Filter
                     </a>
                     <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
                        <li>
                           <a class="dropdown-item" href="##">
                              <div class="form-check">
                                 <input class="form-check-input" type="checkbox" value="0to1000" id="flexCheckDefault">
                                 <label class="form-check-label" for="flexCheckDefault">
                                 0 to 1000
                                 </label>
                              </div>
                           </a>
                        </li>
                        <li>
                           <a class="dropdown-item" href="##">
                              <div class="form-check">
                                 <input class="form-check-input" type="checkbox" value="1000to10000" id="flexCheckDefault">
                                 <label class="form-check-label" for="flexCheckDefault">
                                 1000 to 10,000
                                 </label>
                              </div>
                           </a>
                        </li>
                        <li>
                           <a class="dropdown-item" href="##">
                              <div class="form-check">
                                 <input class="form-check-input" type="checkbox" value="10000to15000" id="flexCheckDefault">
                                 <label class="form-check-label" for="flexCheckDefault">
                                 10,000 to 15,000
                                 </label>
                              </div>
                           </a>
                        </li>
                        <li>
                           <a class="dropdown-item" href="##">
                              <div class="form-check">
                                 <input class="form-check-input" type="checkbox" value="15000to25000" id="flexCheckDefault">
                                 <label class="form-check-label" for="flexCheckDefault">
                                 15,000 to 25,000
                                 </label>
                              </div>
                           </a>
                        </li>
                        <li>
                           <a class="dropdown-item" href="##">
                              <div class="form-check">
                                 <input class="form-check-input" type="checkbox" value="25000above" id="flexCheckDefault">
                                 <label class="form-check-label" for="flexCheckDefault">
                                 25,000 and above
                                 </label>
                              </div>
                           </a>
                        </li>
                        <li>
                           <a class="w-100 btn btn-light border border-1" id="submitFilter" sub-id="#url.subid#" href="##">
                           Submit
                           </a>
                        </li>
                     </ul>
                 </cfif>
              </div>
           </div>

           <div class="row item-row">
              <cfloop query="local.productslist.products">
               <cfset local.image = listToArray(FLDIMAGENAMES)[1]>
                 <a href="userProduct.cfm?proid=#FLDPRODUCT_ID#" class="col-md-3 mt-3 text-decor-none" proid="#FLDPRODUCT_ID#">
                    <div class="card" style="width: 18rem; height: 24rem;">
                       <img src="../assets/productImage/#local.image#" class="card-img-top p-2 " height="250" alt="...">
                       <div class="card-body">
                          <h5 class="card-title productname ">#FLDPRODUCTNAME#</h5>
                          <p class="card-text productname ">#FLDPRODUCTDESCRIPTION#</p>
                          <p class="card-text fw-bold price-tag ">&##8377;#FLDPRODUCTPRICE#</p>
                       </div>
                    </div>
                 </a>
              </cfloop>
           </div>

         </div>
        </div>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
        <script src="../assets/script/jquery.js"></script>
     </body>
     <cfinclude  template="footer.cfm">
  </html>
</cfoutput>