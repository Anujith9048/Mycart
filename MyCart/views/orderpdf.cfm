<cfhtmltopdf destination="#ExpandPath('../assets/pdf/order-invoice.pdf')#" overwrite="true">
    <cfset local.orderHistory = application.getlistObj.getItemsInOrderID(url.orderid)>
    <!DOCTYPE html>
    <html lang="en">
        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>MyCart|DownloadOrderHistory</title>
            <link rel="stylesheet" href="../assets/style/bootstrap.min.css">
            <link rel="stylesheet" href="../assets/style/style.css">
            <style>
                body { font-family: Arial, sans-serif; }
                .card { border: 1px solid #ddd; padding: 20px; }
                .card-header { background-color: #28a745; color: #fff; padding: 10px; border-radius:20px;}
                .card-footer { background-color: #f8f9fa; padding: 10px; }
                table { width: 100%; border-collapse: collapse; }
                th, td { padding: 8px; border: 1px solid #ddd; text-align: left; }
                th { background-color: #f1f1f1; }
                .price-tag { font-weight: bold; color: #333; }
            </style>
        </head>
        <cfoutput>
            <body>
                <div class="card mb-3">
                    <div class="text-center">
                        <p>ORDER INVOICE</p>
                        <p class="float-end m-0">Ordered In:
                        #dateFormat(local.orderHistory.result.FLDORDERDATE, 'mmm dd, yyyy')#
                        #timeFormat(local.orderHistory.result.FLDORDERDATE, 'hh:mm tt')#</p>
                    </div>
                    <div class="card-header bg-success text-white align-items-center d-flex rounded-pill">
                        <p class="m-0 col-12">Order ID: #orderID#</p>
                    </div>
                    <div class="card-body">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>Product Name</th>
                                    <th>Brand</th>
                                    <th>Quantity</th>
                                    <th>Price</th>
                                    <th>Tax</th>
                                    <th>Total Cost</th>
                                </tr>
                            </thead>
                            <tbody>
                                <cfloop query="#local.orderHistory.result#">
                                    <tr>
                                        <td>#FLDPRODUCTNAME#</td>
                                        <td>#FLDBRANDNAME#</td>
                                        <td>#FLDPRODUCTQUANTITY#</td>
                                        <td>&##8377;#FLDPRODUCTPRICE#</td>
                                        <td>#FLDPRODUCTTAX#%</td>
                                        <td>&##8377;#totalOrderCost#</td>
                                    </tr>
                                </cfloop>
                            </tbody>
                        </table>
                    </div>
                    <div class="card-footer text-muted">
                        <cfset local.totalcost = application.getlistObj.getorderTotalCost(orderID)>
                        <p><strong>Total Cost:</strong> &##8377;#local.totalcost.result.totalcost#</p>
                        <div class="mt-4">
                            <h5 class="m-0">Shipping Address</h5>
                            <p>#local.orderHistory.result.FLDBUILDINGNAME# #local.orderHistory.result.FLDAREA#, 
                               #local.orderHistory.result.FLDCITY#, #local.orderHistory.result.FLDSTATE# #local.orderHistory.result.FLDPINCODE#</p>
                            <p><strong>Contact:</strong> #local.orderHistory.result.FLDFULLNAME# - #local.orderHistory.result.FLDPHONE#</p>
                        </div>
                    </div>
                </div>
            </body>
        </cfoutput>
    </html>
</cfhtmltopdf>
<cfoutput>
    <cfheader name="Content-Disposition" value="attachment; filename=#session.username#_order:#orderID#_invoice.pdf">
    <cfcontent file="#ExpandPath('../assets/pdf/order-invoice.pdf')#" type="application/pdf">
</cfoutput>