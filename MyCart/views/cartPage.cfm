<cfoutput>
  <cfif session.isLog>
     <cfset local.cartList = application.getlistObj.getCart(session.userId)>
     <!DOCTYPE html>
     <html lang="en">
        <head>
           <meta charset="UTF-8">
           <meta name="viewport" content="width=device-width, initial-scale=1.0">
           <title>MyCart | cart</title>
           <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
           <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
           <link rel="stylesheet" href="../assets/style/bootstrap.min.css">
           <link rel="stylesheet" href="../assets/style/style.css">
           <link rel="icon" type="image/x-icon" href="../assets/images/logo-img.png">
        </head>
        <body class="body-cart">
           <cfinclude  template="navbar.cfm">
           <cfinclude  template="bottomNav.cfm">
           <cfif local.cartList.cartitems.recordCount>
            <div class="row d-flex row-cart">
               <div class="cart-wrapper col-8 overflow-scroll overflow-x-hidden" style="max-height: 90vh;">
                  <cfloop query="local.cartList.cartItems">
                     <div class="col-12 mt-5 px-2  d-flex justify-content-center">
                        <div class="col-4 d-flex justify-content-center ">
                           <img src="../assets/productImage/#fldProductThumbnail#" height="150" class=" float-start" alt="#FLDPRODUCTNAME#">
                        </div>
                        <div class="col-3">
                           <h4 class="fw-bold  productname">#FLDPRODUCTNAME#</h4>
                           <p class="form-text p-0 productname">#FLDBRANDNAME#</p>
                           <p class="form-text p-0 productname">#FLDPRODUCTDESCRIPTION#</p>
                           <div class="btn-items d-flex gap-2">
                              <a href="##" class="btn btn-outline btn-outline3 removeCart" id="removeCart" pro-id="#FLDPRODUCT_ID#">Remove</a>
                              <a href="userProduct.cfm?proid=#FLDPRODUCT_ID#" class="btn btn-outline2" id="productCheck" proid="#FLDPRODUCT_ID#">View</a>
                           </div>
                        </div>
                        <div class="col-3 ms-3 text-end">
                           <p class="price-tag fw-bolder fs-4 mb-0">&##8377;#TOTALCOST#</p>
                           <p class="text-success fs-6 mb-0"><span class="fw-normal text-secondary">Actual price</span> &##8377;#FLDPRODUCTPRICE#</p>
                           <p class="text-danger fs-6 mb-0"><span class="fw-normal text-secondary">Tax</span> #FLDPRODUCTTAX#%</p>
                           <cfif FLDACTIVE EQ 0>
                              <p class="text-danger p-0 m-0">Out Of Stock</p>
                              <cfelse>
                              <p class="text-danger p-0 m-0"></p>
                           </cfif>
                           <p class="mb-1 mt-2 form-text">Quantity</p>
                           <div class="d-flex gap-2 justify-content-end">
                              <cfif FLDQUANTITY GT 1>
                                 <div class="btn rounded-circle btn-outline-dark py-0 fw-bold quantityControl px-0" data-type="decrease" pro-id="#FLDPRODUCT_ID#">-</div>
                                 <cfelse>
                                 <div class="btn rounded-circle btn-outline-secondary py-0 fw-bold quantityControl px-0 disabled" data-type="decrease" pro-id="#FLDPRODUCT_ID#">-</div>
                              </cfif>
                              <div class="cartQuantity border border-1 w-25 text-center rounded">#FLDQUANTITY#</div>
                              <div class="btn rounded-circle btn-outline-dark py-0 fw-bold quantityControl px-0" data-type="increase" pro-id="#FLDPRODUCT_ID#">+</div>
                           </div>
                        </div>
                     </div>
                  </cfloop>
               </div>
               <div class="col-4 mt-5 sticky-price-details">
                  <div class="col-11 border border-1 rounded px-4 pt-4">
                     <h5 class="">Price Details</h5>
                     <cfloop query="local.cartList.cartItems">
                        <div class="d-flex justify-content-between">
                           <p class="productnameMax">#FLDPRODUCTNAME#</p>
                           <p class="text-success">&##8377;#TOTALCOST#</p>
                        </div>
                     </cfloop>
                     <div class="d-flex justify-content-between">
                        <p>Total Price</p>
                        <cfset local.totalPrice = application.getlistObj.getCartPrice(session.userId)>
                        <p class="fw-bold price-tag">&##8377;#local.totalPrice.price.SUM#</p>
                     </div>
                  </div>
                  <a href="" class="btn btn-outline btn-outline1 col-11 mt-2" data-bs-toggle="modal" data-bs-target="##addressModal">Bought Together</a>
               </div>
            </div>
            
              <cfelse>
              <div class="row justify-content-center">
                 <div class="alert alert-danger w-50 mt-5" role="alert">
                    <h2>OOPS!!</h2>
                    <p>Your cart is empty. Please add items to proceed.</p>
                 </div>
              </div>
           </cfif>
           <!--- Modal --->
           <div class=" shadow-lg modal fade" id="addressModal" data-bs-backdrop="static" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
              <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
                 <div class="modal-content border-0 rounded">
                    <div class="modal-header create-bg">
                       <h5 class="modal-title color-address create-title w-100 text-center py-2 rounded-pill" id="exampleModalLabel">Select Address</h5>
                    </div>
                    <div class="modal-body">
                       <cfset local.userAddress = application.getlistObj.getUserAddress()>
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
                       <button type="button" class="btn btn-primary" id="selectAddress" proid="">Payment Details</button>
                    </div>
                 </div>
              </div>
           </div>
           <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
           <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
           <script src="../assets/script/jquery.js"></script>
        </body>
     </html>
     <cfelse>
     <cflocation  url="userloginPage.cfm" addtoken="no">
  </cfif>
</cfoutput>