<cfif session.isLog>
    <!DOCTYPE html>
    <html lang="en">
       <head>
          <meta charset="UTF-8">
          <meta name="viewport" content="width=device-width, initial-scale=1.0">
          <title>MyCart|Home</title>
          <link rel="stylesheet" href="../assets/style/bootstrap.min.css">
          <link rel="stylesheet" href="../assets/style/style.css">
          <link rel="icon" type="image/x-icon" href="../assets/images/logo-img.png">
       </head>
       <body>
          <nav class="navbar navbar-expand-lg px-4 row admin-nav">
             <div class="col-6 d-flex align-items-center">
                <a class="navbar-brand fs-2 fw-bold" href="#"><span class="main-color">My</span>Cart
                <img src="../assets/images/logo-img.png" width="30" alt=""></a>
                <p class="fw-bold text-dark m-0">ADMIN</p>
             </div>
             <cfif session.isLog>
                <div class="col-6 justify-content-end d-flex me-lg-4" id="navbarNavDropdown">
                   <button class="nav-link p-0" role="button" id="adminLogoutbtn">
                   Logout <img src="../assets/images/logout.png" width="18" class="login-img" alt="">
                   </button>
                </div>
                <cfelse>
                <div class="col-6 justify-content-end d-flex me-lg-4" id="navbarNavDropdown">
                   <a class="nav-link p-0" href="#" role="button" id="adminLogin">
                   Login <img src="../assets/images/login.png" width="18" class="login-img" alt="">
                   </a>
                </div>
             </cfif>
          </nav>
          <div class="contents body-adminhomepage d-flex ">
             <div class="col-4 mx-auto rounded-3 border border-1  px-3 list-items shadow-lg ">
                <div class="col-12 d-flex align-items-center position-sticky top-0 content-heading-wrapper bg-white pt-3 pb-2">
                   <p class="fw-bold m-0 p-0 fs-5 " id="mainHeader">Categories</p>
                   <a href="#" id="addCategories" data-type="categories" class="fw-bold text-decoration-none ms-2 btn btn-outline btn-outline1">
                   Add+
                   </a>
                </div>
                <ul class="list-group d-grid gap-3 mt-3 pb-0" id="item-list">
                   <!--- List items --->
                </ul>
                <div class="col-12 d-flex align-items-center position-sticky bottom-0 bg-white pt-3 pb-2 bottom-space">
                </div>
             </div>
          </div>
          <!-- Modal -->
          <div class="modal fade" id="exampleModal" data-bs-backdrop="static" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
             <div class="modal-dialog d-flex gap-0">
                <div class="modal-content border-0 rounded-0 rounded-start">
                   <div class="modal-header create-bg">
                      <h5 class="modal-title color-address create-title w-100 text-center py-2 rounded-pill" id="exampleModalLabel"></h5>
                   </div>
                   <div class="modal-body">
                      <form action="homePage.cfm" method="post" enctype="multipart/form-data">
                         <table class="table">
                            <tbody>
                               <tr id="categories">
                                  <td>
                                     <label for="" class="form-text fw-bold color-address">Categories Name*</label>
                                     <input type="text" class="form-control" placeholder="Categories Name" id="categoriesName">
                                     <p id="errorCategory" class="text-danger"></p>
                                  </td>
                               </tr>
                            </tbody>
                         </table>
                      </form>
                   </div>
                   <div class="modal-footer">
                      <button type="button" id="closeModalAdd" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                      <button type="button" id="modalSubmit" class="btn btn-primary" data-id="">Submit</button>
                   </div>
                </div>
             </div>
          </div>
          <!--DELETE-CONFIRM-MODAL-->
          <div id="deleteModal" class="modal fade">
             <div class="modal-dialog modal-confirm">
                <div class="modal-content">
                   <div class="modal-header d-flex flex-column">
                      <div class="icon-box">
                         <i class="material-icons mt-0">
                         <img src="../assets/images/deleteAddress.png" class="img-fluid mb-1" alt="">
                         </i>
                      </div>
                      <h4 class="modal-title">Are you sure?</h4>
                   </div>
                   <div class="modal-body w-75 mx-auto text-center">
                      <p id="confmTextDlt" class="text-secondary">Do you really want to delete the address? This process cannot be undone.</p>
                   </div>
                   <div class="modal-footer w-100">
                      <button type="button" id="" class="btn btn-primary"
                         data-bs-dismiss="modal">Close</button>
                      <div id="deleteItem"></div>
                      <button type="button" id="confirmDelete" class="btn btn-danger">Delete</button>
                   </div>
                </div>
             </div>
          </div>
          <!-- Place these at the bottom of the body -->
          <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
          <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
          <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js"></script>
          <script src="../assets/script/jquery.js"></script>
       </body>
    </html>
    <cfelse>
    <cflocation url="Adminlogin.cfm">
 </cfif>