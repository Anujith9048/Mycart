<cfoutput>
  <cfset local.getlistObj = createObject("component", "models.getlist")>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MyCart|Address</title>

    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>

    <link rel="stylesheet" href="../assets/style/bootstrap.min.css">
    <link rel="stylesheet" href="../assets/style/style.css">
</head>
<body>
    
    <nav class="navbar navbar-expand-lg px-4 justify-content-between position-sticky top-0 bg-light">
        <div class="container-fluid">
          <a class="navbar-brand fw-bold" href="homePage.cfm"><span class="main-color">My</span>Cart
            <img src="../assets/images/logo-img.png" width="30" alt=""></a>
          <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="##navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
          </button>
        </div>
        <div class="input-group">
          <input type="text" class="form-control" placeholder="Search Product" id="productName">
          <button class="btn btn-outline-secondary" type="button" id="searchItem">Search</button>
        </div>
        <div class="collapse navbar-collapse d-flex me-4" id="navbarNavDropdown">
            <ul class="navbar-nav">
              <li class="nav-item dropdown mx-2">
                <cfset local.count = local.getlistObj.getCartCount()>
                <a href="cartPage.cfm" type="button" class="nav-link btn btn-light position-relative">
                  Cart
                  <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
                    #local.count.count.count#
                    <span class="visually-hidden">unread messages</span>
                  </span>
                </a>
              </li>
              <li class="nav-item dropdown">
                <a class="nav-link" href="userloginPage.cfm" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                  Login
                </a>
              </li>
            </ul>
          </div>
    </nav>

    <div class="mt-4" id="" >
      <div class="modal-dialog modal-lg d-flex gap-0">
        <div class="modal-content border-0 rounded-0 rounded-start">
          <div class="modal-header create-bg">
            <h5 class="modal-title color-address create-title w-100 text-center py-2 rounded-pill" id="exampleModalLabel">Add Address</h5>
          </div>
          <div class="modal-body">
            <form action="homePage.cfm" method="post" enctype="multipart/form-data">
                <table class="table">
                    <tbody>
                      <tr>
                          <td>
                              <label for="" class="form-text fw-bold color-address">Full Name*</label>
                              <input type="text" class="form-control " placeholder="Full Name"
                                  id="address">
                              <p id="errorAddress" class="text-danger"></p>
                          </td>
                          <td>
                              <label for="" class="form-text fw-bold color-address">Phone*</label>
                              <input type="text" class="form-control" placeholder="Phone" id="phone">
                              <p id="errorPhone" class="text-danger"></p>
                          </td>
                      </tr>
                        <tr>
                          <td>
                              <label for="" class="form-text fw-bold color-address">Pin
                                  Code*</label>
                              <input type="text" class="form-control" placeholder="PinCode"
                                  id="pincode" maxlength="6">
                              <p id="errorPincode" class="text-danger"></p>
                          </td>
                            <td>
                                <label for="" class="form-text fw-bold color-address">State*</label>
                                <input type="text" class="form-control " placeholder="State"
                                    id="address">
                                <p id="errorAddress" class="text-danger"></p>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label for="" class="form-text fw-bold color-address">City*</label>
                                <input type="text" class="form-control" placeholder="City" id="email">
                                <p id="errorEmail" class="text-danger"></p>
                            </td>
                          <td>
                              <label for="" class="form-text fw-bold color-address">Building*</label>
                              <input type="text" class="form-control" placeholder="Street"
                                  id="street">
                              <p id="errorStreet" class="text-danger"></p>
                          </td>
                        </tr>
                        <tr>
                          <td>
                              <label for="" class="form-text fw-bold color-address">Area*</label>
                              <input type="text" class="form-control" placeholder="Area"
                                  id="street">
                              <p id="errorStreet" class="text-danger"></p>
                          </td>
                        </tr>
                    </tbody>
                </table>
                <p id="resultAddress" class="text-center text-success form-text"></p>
            </form>
          </div>
          <div class="footer gap-2">
            <button type="button" id="addAddress" class="btn btn-primary" >Add Contact</button>
          </div>
        <div class="col-3 create-bg d-flex align-items-center justify-content-center rounded-end modal-image-box">
          <div class="image_container p-4 py-auto" id="modalSideBox">
              <img class="img-fluid" id="modalSideImage" width="100" src="../images/phone-book.png" alt="">
          </div>
        </div>
      </div>
            </div>




    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
    <script src="../assets/script/jquery.js"></script>
</body>
</html>
</cfoutput>