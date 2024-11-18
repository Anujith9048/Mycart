<cfoutput>
  <cfset local.userDetails = application.getlistObj.getUserDetails()>
  <cfset local.userAddress = application.getlistObj.getUserAddress()>
  <cfif session.isLog>
     <!DOCTYPE html>
     <html lang="en">
        <head>
           <meta charset="UTF-8">
           <meta name="viewport" content="width=device-width, initial-scale=1.0">
           <title>MyCart|Profile</title>
           <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
           <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
           <link rel="stylesheet" href="../assets/style/bootstrap.min.css">
           <link rel="stylesheet" href="../assets/style/style.css">
           <link rel="icon" type="image/x-icon" href="../assets/images/logo-img.png">
        </head>
        <body>
           <cfinclude  template="navbar.cfm">
           <div class="row justify-content-center mt-4">
              <div class="col-4 justify-content-center">
                 <div class=" col-12 image d-flex align-items-center p-3 shadow">
                    <img src="../assets/images/default_user22.png" width="60" height="60" alt="">
                    <div class="username ms-3">
                       <p class="m-0 p-0">Hello,</p>
                       <h4 class="m-0 p-0">#local.userDetails.data.fldusername#</h4>
                       <p class="m-0 p-0 form-text">email: #local.userDetails.data.fldemail#</p>
                    </div>
                 </div>
                 <div class="col-12 p-3 mt-2 shadow">
                    <p class="text-success h6 form-text">Profile Informations</p>
                    <table class="w-100 mb-4 table table-hover">
                       <cfloop query="local.userAddress.data">
                          <tr class="border border-1 w-100 ">
                             <td class="p-3">
                                <p class="h6">#fldfullname# <span class="ms-3">#fldphone#</span></p>
                                <p class="form-text text-dark mb-0">#fldbuildingname# , #fldcity# , #fldarea# , #fldstate#</p>
                                <p class="form-text text-dark m-0 p-0 h6">#fldpincode#</p>
                             </td>
                          </tr>
                       </cfloop>
                    </table>
                    <button class="btn btn-outline2" data-bs-toggle="modal" data-bs-target="##exampleModal">Add New Address</button>
                    <a href="orderHistory.cfm" class="btn btn-outline1 btn-outline">Order Details</a>
                 </div>
              </div>
           </div>
           <!-- Modal -->
           <div class=" shadow-lg modal fade" id="exampleModal" data-bs-backdrop="static" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
              <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
                 <div class="modal-content border-0 rounded-0 rounded-start">
                    <div class="modal-header create-bg">
                       <h5 class="modal-title color-address create-title w-100 text-center py-2 rounded-pill" id="exampleModalLabel">Add Address</h5>
                    </div>
                    <div class="modal-body">
                       <form action="" method="post" enctype="multipart/form-data">
                          <table class="table">
                             <tbody>
                                <tr>
                                   <td>
                                      <label for="" class="form-text fw-bold color-address">Full Name*</label>
                                      <input type="text" class="form-control " placeholder="Full Name" id="name">
                                      <p id="errorName" class="text-danger"></p>
                                   </td>
                                   <td>
                                      <label for="" class="form-text fw-bold color-address">Phone*</label>
                                      <input type="text" class="form-control" placeholder="Phone" id="phone">
                                      <p id="errorPhone" class="text-danger"></p>
                                   </td>
                                </tr>
                                <tr>
                                   <td>
                                      <label for="" class="form-text fw-bold color-address">Pinb Code*</label>
                                      <input type="text" class="form-control" placeholder="PinCode" id="pincode" maxlength="6">
                                      <p id="errorPincode" class="text-danger"></p>
                                   </td>
                                   <td>
                                      <label for="" class="form-text fw-bold color-address">State*</label>
                                      <input type="text" class="form-control " placeholder="State" id="state">
                                      <p id="errorState" class="text-danger"></p>
                                   </td>
                                </tr>
                                <tr>
                                   <td>
                                      <label for="" class="form-text fw-bold color-address">City*</label>
                                      <input type="text" class="form-control" placeholder="City" id="city">
                                      <p id="errorCity" class="text-danger"></p>
                                   </td>
                                   <td>
                                      <label for="" class="form-text fw-bold color-address">Building*</label>
                                      <input type="text" class="form-control" placeholder="Building"  id="building">
                                      <p id="errorBuilding" class="text-danger"></p>
                                   </td>
                                </tr>
                                <tr>
                                   <td>
                                      <label for="" class="form-text fw-bold color-address">Area*</label>
                                      <input type="text" class="form-control" placeholder="Area"  id="area">
                                      <p id="errorArea" class="text-danger"></p>
                                   </td>
                                </tr>
                             </tbody>
                          </table>
                          <p id="resultAddress" class="text-center text-success form-text"></p>
                       </form>
                    </div>
                    <div class="modal-footer">
                       <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                       <button type="button" class="btn btn-primary" id="submitAddress">Save changes</button>
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