<cfoutput>
<cfif session.isLog>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MyCart|PaymentSuccess</title>

    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>

    <link rel="stylesheet" href="../assets/style/bootstrap.min.css">
    <link rel="stylesheet" href="../assets/style/style.css">
    <link rel="icon" type="image/x-icon" href="../assets/images/logo-img.png">
</head>
<body>
  <cfinclude  template="navbar.cfm">
  <div  class="paybody w-100 align-items-center  justify-content-center d-flex">
    <div class="image text-center">
      <img src="../assets/images/success.png" width="200px" height="200px" alt="">
      <h5 class="text-success fw-bold">Payment Successfull</h5>
      <a href="homePage.cfm" class="btn btn-outline btn-outline1 w-100 mb-3">Continue Shopping</a>
      <a href="orderHistory.cfm" class="btn btn-outline2 w-100">Order Details</a>
    </div>
  </div>
</body>
</html>
  <cfelse>
   <cflocation  url="userloginPage.cfm">
</cfif>
</cfoutput>