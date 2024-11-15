  <cfset local.productslist = application.getlistObj.getSingleProduct(url.proid)>
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
         <cfset local.imageArray = listToArray(local.productslist.product.FLDIMAGENAMES)>

         <div id="carouselExampleIndicators" class="carousel carousel-dark slide col-5" data-bs-ride="carousel">
             <div class="carousel-indicators mb-0">
                 <cfoutput>
                     <cfloop from="1" to="#arrayLen(local.imageArray)#" index="i">
                         <button type="button" data-bs-target="##carouselExampleIndicators" data-bs-slide-to="#i - 1#" 
                                 class="#i EQ 1 ? 'active' : ''# bg-dark" aria-label="Slide #i#"></button>
                     </cfloop>
                 </cfoutput>
             </div>
         
             <cfoutput>
                 <div class="carousel-inner carousel-style">
                     <cfloop from="1" to="#arrayLen(local.imageArray)#" index="image">
                         <div class="carousel-item #image EQ 1 ? 'active' : ''#">
                             <img class="d-block mx-auto" src="../assets/productImage/#local.imageArray[image]#" alt="">
                         </div>
                     </cfloop>
                 </div>
             </cfoutput>
         
             <button class="carousel-control-prev px-0" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
                 <span class="carousel-control-prev-icon bg-dark me-auto py-5 px-3 rounded-pill" aria-hidden="true"></span>
                 <span class="visually-hidden">Previous</span>
             </button>
             <button class="carousel-control-next px-0" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
                 <span class="carousel-control-next-icon bg-dark ms-auto py-5 px-3 rounded-pill" aria-hidden="true"></span>
                 <span class="visually-hidden">Next</span>
             </button>
         </div>
         
        

          <cfoutput>
           <div class="col-md-6 col-12 pe-4 ps-5">
              <div class="path d-flex align-items-center col-6 pathname">
                 <cfset local.path = application.getlistObj.getpath(url.proid)>
                 <a href="categoryProduct.cfm?cateid=#local.path.path.FLDCATEGORYID#" class="link-secondary" id="FLDCATEGORYID"> #local.path.path.FLDCATEGORY_NAME# </a> 
                 <img src="../assets/images/right.png" width="20" height="20" alt="">
                 <a href="userProductList.cfm?subid=#local.path.path.FLDSUBCATEGORYID#" class="link-secondary" id="FLDSUBCATEGORYID"> #local.path.path.FLDSUBCATEGORYNAME#  </a>
                 <img src="../assets/images/right.png" width="20" height="20" alt=""> 
                 <a class="text-secondary"> #local.product.FLDPRODUCTNAME#</a>
              </div>
              <h4 class="fw-bold pt-2 text-success mb-0">#local.product.FLDPRODUCTNAME#</h4>
              <p class="form-text p-0">#local.product.FLDBRANDNAME#</p>
              <p class="fs-5"><span class="fw-bold form-text"> <u>Description:</u> </span>#local.product.FLDPRODUCTDESCRIPTION#</p>
              <p class="price-tag fw-bolder fs-4 m-0">&##8377;#local.product.FLDPRODUCTPRICEWITHTAX#</p>
              <p class="form-text">Tax: #local.product.FLDPRODUCTTAX#%</p>
              <div class="btn-items d-flex gap-2">
                 <a href="##" class="btn btn-outline btn-outline1" id="buyNow" pro-id="#url.proid#"  data-bs-toggle="modal" data-bs-target="##addressModal">Buy Now</a>
                 <a href="##" class="btn btn-outline2" id="addToCart" pro-id="#url.proid#">Add to Cart</a>
              </div>
           </div>
        </div>
        <!-- Modal -->
        <div class=" shadow-lg modal fade" id="addressModal" data-bs-backdrop="static" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
           <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
              <div class="modal-content border-0 rounded">
                 <div class="modal-header create-bg">
                    <h5 class="modal-title color-address create-title w-100 text-center py-2 rounded-pill" id="exampleModalLabel">Select Address</h5>
                 </div>
                 <div class="modal-body">
                    <cfset local.userAddress = application.getlistObj.getUserAddress()>
                    <p class="text-success h6 form-text">Saved Addresses</p>
                    <table class="w-100 mb-4 table table-hover">
                       <cfloop query="local.userAddress.data">
                          <tr class="border border-1 w-100 ">
                             <td class="p-3">
                                <div class="form-check">
                                   <input class="form-check-input" type="radio" name="addressRadio" id="addressRadio" value="#fldaddress_id#" checked>
                                   <label class="form-check-label" for="flexRadioDefault1">
                                      <p class="h6">#fldfullname# <span class="ms-3">#fldphone#</span></p>
                                      <p class="form-text text-dark mb-0">#fldbuildingname# , #fldcity# , #fldarea# , #fldstate#</p>
                                      <p class="form-text text-dark m-0 p-0 h6">#fldpincode#</p>
                                   </label>
                                </div>
                             </td>
                          </tr>
                       </cfloop>
                    </table>
                 </div>
                 <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <a href="userProfile.cfm" class="float-start  btn btn-primary">Add Address</a>
                    <button type="button" class="btn btn-success" id="selectAddress" proid="#url.proid#">Payment Details</button>
                 </div>
              </div>
           </div>
        </div>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
        <script src="../assets/script/jquery.js"></script>
     </body>
         </cfoutput>
     <cfinclude  template="footer.cfm">
  </html>
