<cfoutput>
    <cfhtmltopdf destination="#ExpandPath('../assets/pdf/order-invoice.pdf')#" overwrite="true">
        <cfset local.getlistObj = createObject("component", "models.getlist")>
        <cfset local.orderHistory = local.getlistObj.getItemsInOrderID(url.orderid)>
        <!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MyCart|DownloadOrderHistory</title>

    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>

    <link rel="stylesheet" href="../assets/style/bootstrap.min.css">
    <link rel="stylesheet" href="../assets/style/style.css">
</head>
<body>
  <div class="card mb-3">
    <div class="card-header bg-success text-white align-items-center d-flex">
        <p class="m-0 col-6">Order id:  #orderID#</p>
    </div>
    <div class="card-body d-flex justify-content-center">
        <cfloop query="#local.orderHistory.result#">
            <div class="row mb-3">
                <div class="col-3">
                    <img src="../assets/productImage/#FLDPRODUCTIMAGE#" class="img-fluid" alt="#FLDPRODUCTIMAGE#">
                </div>
                <div class="col-9">
                    <p><strong>#FLDPRODUCTNAME#</strong></p>
                    <p><strong>Brand:</strong> #FLDBRANDNAME#</p>
                    <p><strong>Quantity:</strong> #FLDPRODUCTQUANTITY#</p>
                    <p class="mb-0"><strong>Shipping Address:</strong></p>
                    <p>#FLDBUILDINGNAME# #FLDAREA#, #FLDCITY#, #FLDSTATE# #FLDPINCODE#</p>
                    <p><strong>Contact:</strong> #FLDFULLNAME# - #FLDPHONE#</p>
                    <p>Price: <strong class="price-tag">&##8377;#totalOrderCost#</strong></p>
                </div>
            </div>
        </cfloop>
    </div>
    <div class="card-footer text-muted">
      <cfset local.totalcost = local.getlistObj.getorderTotalCost(orderID)>
      <p>Total Cost <strong class="price-tag">&##8377;#local.totalcost.result.totalcost#</strong></p>
    </div>
</div>

    

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
    <script src="../assets/script/jquery.js"></script>
</body>
</html>
    </cfhtmltopdf>

    <cfheader name="Content-Disposition" value="attachment; filename=#session.username#_order:#orderID#_invoice.pdf">
    <cfcontent file="#ExpandPath('../assets/pdf/order-invoice.pdf')#" type="application/pdf">
</cfoutput>
