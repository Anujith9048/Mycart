<cfoutput>
  <cfset local.getlistObj = createObject("component", "models.getlist")>
  <cfset local.orderHistory = local.getlistObj.getorderHistory()>
  

<cfif session.isLog>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MyCart|OrderHistory</title>

    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>

    <link rel="stylesheet" href="../assets/style/bootstrap.min.css">
    <link rel="stylesheet" href="../assets/style/style.css">
</head>
<body>
    
    <cfinclude  template="navbar.cfm">

    <div class="row justify-content-center mt-4">
      <div class="col-7 p-0">
          <div class="bg-primary align-items-center d-flex justify-content-between mb-3">
              <p class="text-light fw-bold mb-0 p-3 col-3">ORDER HISTORY</p>
          </div>
  
          <cfloop collection="#local.orderHistory.result#" item="orderID">
              <div class="card mb-3 bg-light">
                  <div class="card-header bg-success text-white align-items-center d-flex">
                      <p class="m-0 col-6">Order id:  #orderID#</p>
                      <div class="align-items-center col-6 d-flex">
                        <a href="orderpdf.cfm?orderid=#orderID#" class="ms-auto" title="Download invoice" order-id="#orderID#"><img src="../assets/images/pdf.png" height="40" alt=""></a>
                        <p class="float-end m-0">Order Date: #dateFormat(local.orderHistory.result[orderID][1].orderDate, 'mmm dd, yyyy')#</p>
                      </div>
                  </div>
                  <div class="card-body">
                      <cfloop array="#local.orderHistory.result[orderID]#" index="product">
                          <div class="row mb-3">
                              <div class="col-3">
                                  <img src="../assets/productImage/#product.productImage#" class="img-fluid" alt="#product.productName#">
                              </div>
                              <div class="col-9">
                                  <p><strong>#product.productName#</strong></p>
                                  <p><strong>Brand:</strong> #product.productBrand#</p>
                                  <p><strong>Quantity:</strong> #product.productQuantity#</p>
                                  <p class="mb-0"><strong>Shipping Address:</strong></p>
                                  <p>#product.building# #product.area#, #product.city#, #product.state# #product.pincode#</p>
                                  <p><strong>Contact:</strong> #product.name# - #product.phone#</p>
                                  <p>Price: <strong class="price-tag">&##8377;#product.cost#</strong></p>
                              </div>
                          </div>
                      </cfloop>
                  </div>
                  <div class="card-footer text-muted">
                    <cfset local.totalcost = local.getlistObj.getorderTotalCost(orderID)>
                    <p>Total Cost <strong class="price-tag">&##8377;#local.totalcost.result.totalcost#</strong></p>
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
  <cfelse>
   <cflocation  url="userloginPage.cfm">
</cfif>
</cfoutput>