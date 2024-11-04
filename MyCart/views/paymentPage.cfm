<cfoutput>
  <cfset local.getlistObj = createObject("component", "models.getlist")>
  <cfset local.selectedAddress = local.getlistObj.getselectedAddress(url.addressid)>

<cfif session.isLog>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MyCart|PaymentDeteils</title>

    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>

    <link rel="stylesheet" href="../assets/style/bootstrap.min.css">
    <link rel="stylesheet" href="../assets/style/style.css">
</head>
<body>
    
    <cfinclude  template="navbar.cfm">

    <div class="row justify-content-center">
      <div class="col-5">
        <div class="row bg-primary align-content-center">
          <p class="text-light fw-bold mb-0 p-3">ORDER SUMMARY</p>
        </div>

        <table class="w-100 mb-4 table">
            <tr>
              <td class="">
                <div class="form-check ps-0">
                  <p class="text-primary h6 form-text">Selected Addresses</p>
                  <label class="form-check-label" for="flexRadioDefault1">
                    <p class="form-text text-dark h6">#local.selectedAddress.result.fldfullname# <span class="ms-3">#local.selectedAddress.result.fldphone#</span></p>
                    <p class="form-text text-dark mb-0">#local.selectedAddress.result.fldbuildingname# , #local.selectedAddress.result.fldcity# , #local.selectedAddress.result.fldarea# , #local.selectedAddress.result.fldstate#</p>
                    <p class="form-text text-dark m-0 p-0 h6">#local.selectedAddress.result.fldpincode#</p>
                  </label>
                </div>
              </td>
            </tr>
            
            <cfif structKeyExists(url, "proid")>
              <cfset local.productslist = local.getlistObj.getSingleProduct(url.proid)>
              <cfset local.product = local.productslist.product>
              <tr>
                <td class="align-items-center">
                  <div class="col-12">
                  <p class="text-primary h6 form-text">Product</p>
                  <div class="d-flex col-12">
                    <div class="col-3 align-content-center">
                      <img src="../assets/productImage/#local.product.FLDPRODUCTIMAGE#" width="80" alt="">
                    </div>
                    <div class="col-6">
                      <p class="h6 p-0 m-0  productnameMin">#local.product.FLDPRODUCTNAME#</p>
                      <p class="form-text p-0 mb-1  productnameMin">#local.product.FLDBRANDNAME#</p>
                      <p class="h6 form-text price-tag fw-bold " id="productprice"  price="#local.product.FLDPRODUCTPRICE#">&##8377;#local.product.FLDPRODUCTPRICE#</p>
                    </div>
                    <div class="col-3 align-content-center">
                      <div class="d-flex gap-2">
                        <div class="btn rounded-circle btn-outline-dark py-0 fw-bold quantityControlPayment px-0" data-type="decrease" id="decrease">-</div>
                        <div class="cartQuantity border border-1 w-25 text-center rounded" id="productQuantity">1</div>
                        <div class="btn rounded-circle btn-outline-dark py-0 fw-bold quantityControlPayment px-0" data-type="increase" >+</div>
                      </div>
                    </div>
                  </div>
                  </div>
                </td>
              </tr>

              <cfelse>
               <cfif url.order EQ 'cart'>
                
               <cfset local.cartList = local.getlistObj.getCart(session.userId)>
                <div class="row d-flex pb-5">
                  <div class="cart-wrapper col-12 ">
                    <cfloop query="local.cartList.cartItems">
                      <div class="col-12 mt-5 px-2  d-flex justify-content-center">
                        <div class="col-4 d-flex justify-content-center ">
                          <img src="../assets/productImage/#FLDPRODUCTIMAGE#" height="100" alt="" class=" float-start">
                        </div>
                        <div class="col-5">
                          <h6  class="fw-bold  productname">#FLDPRODUCTNAME#</h4>
                          <p class="form-text p-0 productname">#FLDBRANDNAME#</p>
                          <p class="form-text p-0 productname">#FLDPRODUCTDESCRIPTION#</p>
                          <div class="btn-items d-flex gap-2">
                          </div>
                        </div>
                        <div class="col-3 ms-3">
                          <p class="price-tag fw-bolder fs-4 mb-0">&##8377;#FLDPRODUCTPRICE#</p>
                          <cfif FLDACTIVE EQ 0>
                            <p class="text-danger p-0 m-0">Out Of Stock</p>
                            <cfelse>
                              <p class="text-danger p-0 m-0"></p>
                          </cfif>
            
                            <p class="mb-1 mt-2 form-text">Quantity</p>
                            <div class="d-flex gap-2">
                            
                            <div class="cartQuantity border border-1 w-25 text-center rounded">#FLDQUANTITY#</div>
                          </div>
                        </div>
                      </div>
                    </cfloop>
                  </div>
                  
            
                  <div class="col-12 mt-5   border border-1 rounded px-4 py-4">
                      <h5 class="">Price Details</h5>
                      <div class="d-flex justify-content-between">
                        <p>Total Price</p>
                        <cfset local.totalPrice = local.getlistObj.getCartPrice(session.userId)>
                        <p class="fw-bold price-tag">&##8377;#local.totalPrice.price.SUM#</p>
                      </div>
                  </div>
                </div>
               </cfif>
      
            </cfif>

            <tr>
              <td class="align-items-center">
                <div class="col-12 ">
                 <button class="btn btn-outline-primary float-end me-4" data-bs-toggle="modal" data-bs-target="##cardModal">Place Order</button>
                </div>
              </td>
            </tr>
          </table>
      </div>
    </div>



    <!--- Modal --->
<div class=" shadow-lg modal fade" id="cardModal" data-bs-backdrop="static" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
    <div class="modal-content border-0 rounded">
      <div class="modal-header create-bg">
        <h5 class="modal-title color-address create-title w-100 text-center py-2 rounded-pill" id="exampleModalLabel">Select Address</h5>
      </div>
      <div class="modal-body justify-content-center d-flex">
        
      <div class="col-10 border border-1 rounded">
        <div class="col-12 m-0 border-bottom border-1 p-2 text-center fw-bold">Card Details</div>
        <div class="col-12 d-flex p-3 justify-content-between">
          <p class="form-text">Card Number</p>
          <input type="text" name="" id="cardnumber" class="form-control w-50" placeholder="000-000-000-00" maxlength="11">
        </div>
        <div class="col-12 d-flex p-3 justify-content-between">
          <p class="form-text">CVV</p>
          <input type="text" name="" id="cvv" class="form-control w-50" placeholder="000" maxlength="3">
        </div>
      </div>

      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        <cfif structKeyExists(url, "proid")>
          <button type="button" class="btn btn-primary px-5" id="pay" address-id="#url.addressid#" proid="#url.proid#">Pay</button>
          <cfelse>
            <button type="button" class="btn btn-primary px-5" id="pay" address-id="#url.addressid#" proid="cart">Pay</button>

        </cfif>
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
   <cflocation  url="userloginPage.cfm">
</cfif>
</cfoutput>