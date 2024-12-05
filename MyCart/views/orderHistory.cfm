<cfoutput>
   <cfparam name="url.orderid" default="">
   <cfif session.isLog>
      <cfset local.orderHistory = application.getlistObj.getOrderHistory()>
      <!DOCTYPE html>
      <html lang="en">
         <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>MyCart | Order History</title>
            <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js"></script>
            <link rel="stylesheet" href="../assets/style/bootstrap.min.css">
            <link rel="stylesheet" href="../assets/style/style.css">
            <link rel="icon" type="image/x-icon" href="../assets/images/logo-img.png">
         </head>
         <body>
            <cfinclude template="navbar.cfm">
            <div class="row justify-content-center mt-4">
               <div class="col-7 p-0">
                  <div class="bg-success align-items-center d-flex justify-content-between mb-3 rounded-pill">
                     <a href="orderHistory.cfm"
                        class="text-light fw-bold mb-0 p-3 col-3 text-decor-none ms-4">ORDER HISTORY</a>
                     <div class="input-group me-4 w-50">
                        <input type="text" id="orderidInput" class="form-control rounded-pill" placeholder="Order Id" aria-label="Recipient's username" aria-describedby="button-addon2">
                        <button class="btn btn-outline-light rounded-pill" id="orderSearch" type="button">Search</button>
                     </div>
                  </div>
                  <cfloop collection="#local.orderHistory.result#" item="orderID">
                     <cfif len(trim(url.orderid)) eq 0 OR orderID eq url.orderid>
                        <div class="card mb-3 bg-light">
                           <div class="card-header  bg-success-subtle text-dark align-items-center d-flex">
                              <p class="m-0 col-6">Order id: #orderID#</p>
                              <div class="align-items-center col-6 d-flex">
                                 <a href="orderpdf.cfm?orderid=#orderID#" class="ms-auto"
                                    title="Download invoice" order-id="#orderID#"><img
                                       src="../assets/images/pdf.png" height="40" alt=""></a>
                                 <p class="float-end m-0">Ordered In:
                                    #dateFormat(local.orderHistory.result[orderID][1].orderDate, 'mmm dd, yyyy')#
                                    #timeFormat(local.orderHistory.result[orderID][1].orderDate, 'hh:mm tt')#</p>
                              </div>
                           </div>
                           <div class="card-body">
                              <cfloop array="#local.orderHistory.result[orderID]#" index="product">
                                 <div class="row mb-3">
                                    <div class="col-2 align-content-center">
                                       <img src="../assets/productImage/#product.productImage#"
                                          class="img-fluid" height="100" alt="#product.productName#">
                                    </div>
                                    <div class="col-5">
                                       <a href="userProduct.cfm?proid=#product.PRODUCTID#" class="text-decor-none text-success"><strong>#product.productName#</strong></a>
                                       <p class="form-text">Brand: #product.productBrand#</p>
                                       <p class="form-text">Quantity: #product.productQuantity#</p>
                                    </div>
                                    <div class="col-5">
                                       <p class="mb-0">Actual Price: <span class="form-text text-success">&##8377;#product.COST#</span></p>
                                       <p>Tax : #product.TAX#%</p>
                                       <p class="mb-0">Total Price: <strong class="form-text price-tag ">&##8377;#product.TOTALCOST#</strong></p>
                                    </div>
                                 </div>
                              </cfloop>
                           </div>
                           <div class="card-footer text-muted d-flex w-100">
                              <cfset local.totalcost=application.getlistObj.getorderTotalCost(orderID)>
                              <p class="align-content-center">Total Cost <strong class="price-tag">&##8377;#local.totalcost.result.totalcost#</strong></p>
                              <div class="ms-auto text-end">
                                 <p class="mb-0"><strong>Shipping Address:</strong></p>
                                 <p>#product.building# #product.area#, #product.city#, #product.state# #product.pincode#</p>
                                 <p><strong>Contact:</strong> #product.name# - #product.phone#</p>
                              </div>
                           </div>
                        </div>
                     </cfif>
                  </cfloop>
               </div>
            </div>
            <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
            <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
            <script src="../assets/script/jquery.js"></script>
         </body>
      </html>
      <cfinclude template="footer.cfm">
   <cfelse>
      <cflocation url="userloginPage.cfm" addtoken="no">
   </cfif>
</cfoutput>