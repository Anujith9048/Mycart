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

    <div class="row justify-content-center">
      <div class="col-7">
        <div class="row bg-primary align-items-center d-flex justify-content-between">
          <p class="text-light fw-bold mb-0 p-3 col-3">ORDER HISTORY</p>
          <a href="orderpdf.cfm" class="col-1" title="Download invoice"><img src="../assets/images/pdf.png" height="40" alt=""></a>
        </div>
        <table class="w-100 mb-4 table">
          <cfloop query="local.orderHistory.result">
            <tr>
              <td>
                <div class="col-12 d-flex">
                  <div class="col-2">
                    <img src="../assets/productImage/#FLDPRODUCTIMAGE#" width="100" alt="">
                  </div>
                  <div class="col-4">
                    <h5 class="form-text text-dark mb-0 productnameMin">#FLDPRODUCTNAME# 
                      <cfif FLDPRODUCTQUANTITY GT 1>
                        <span class="text-secondary">(#FLDPRODUCTQUANTITY#)</span>
                      </cfif>
                    </h5>
                    <p class="form-text productnameMin">#FLDBRANDNAME#</p>
                    <p class="form-text price-tag fw-bold">&##8377;#TOTALORDERCOST#</p>
                  </div>
                  <div class="col-4 ps-2">
                    <p class="m-0 p-0 form-text text-dark">#FLDFULLNAME# <span class="ms-3">#FLDPHONE#</span></p>
                    <p class="m-0 p-0 form-text productname">#FLDBUILDINGNAME#,#FLDSTATE#,#FLDCITY#,#FLDAREA#<br> <span class="text-dark">#FLDPINCODE#</span> </p>
                    <p class="text-primary form-text">Order Id :#FLDORDER_ID#</p>
                  </div>
                  <div class="col-2 justify-content-center d-flex">
                    <p class="form-text">Ordered in : <br><span class="text-dark"> #FLDORDERDATE#</span></p>
                  </div>
                </div>
              </td>
            </tr>
          </cfloop>
        </table>
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