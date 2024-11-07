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
           <div class="col-md-6 col-12 justify-content-center d-flex">
              <img src="../assets/productImage/#local.product.FLDPRODUCTIMAGE#" height="400" alt="" class="float-end">
           </div>
           <div class="col-md-6 col-12 pe-4">
              <div class="path d-flex align-items-center">
                 <cfset local.path = local.getlistObj.getpath(url.proid)>
                 <a href="categoryProduct.cfm?cateid=#local.path.path.FLDCATEGORYID#" class="link-secondary" id="FLDCATEGORYID"> #local.path.path.FLDCATEGORY_NAME# </a> 
                 <img src="../assets/images/right.png" width="20" height="20" alt="">
                 <a href="userProductList.cfm?subid=#local.path.path.FLDSUBCATEGORYID#" class="link-secondary" id="FLDSUBCATEGORYID"> #local.path.path.FLDSUBCATEGORYNAME#  </a>
                 <img src="../assets/images/right.png" width="20" height="20" alt=""> 
                 <a class="text-secondary"> #local.product.FLDPRODUCTNAME#</a>
              </div>
              <h4 class="fw-bold pt-4">#local.product.FLDPRODUCTNAME#</h4>
              <p class="form-text p-0">#local.product.FLDBRANDNAME#</p>
              <p class="fs-5"><span class="fw-bold form-text"> <u>Description:</u> </span>#local.product.FLDPRODUCTDESCRIPTION#</p>
              <p class="price-tag fw-bolder fs-4">&##8377;#local.product.FLDPRODUCTPRICE#</p>
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
                    <cfset local.userAddress = local.getlistObj.getUserAddress()>
                    <p class="text-primary h6 form-text">Saved Addresses</p>
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
                    <a href="userProfile.cfm" class="float-start  ">Add Address</a>
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary" id="selectAddress" proid="#url.proid#">Payment Details</button>
                 </div>
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