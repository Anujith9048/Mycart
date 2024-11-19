<cfoutput>
    <cfif session.isLog>
       <cfset local.category = application.getlistObj.getCategoryId(url.subid)>
       <cfset local.subName = application.getlistObj.getSubcategoryName(url.subid)>
       <!DOCTYPE html>
       <html lang="en">
          <head>
             <meta charset="UTF-8">
             <meta name="viewport" content="width=device-width, initial-scale=1.0">
             <title>MyCartAdmin | Product</title>
             <link rel="stylesheet" href="../assets/style/bootstrap.min.css">
             <link rel="stylesheet" href="../assets/style/style.css">
             <link rel="icon" type="image/x-icon" href="../assets/images/logo-img.png">
          </head>
          <body>
             <nav class="navbar navbar-expand-lg px-4 row admin-nav">
                <div class="col-6 d-flex align-items-center">
                   <a class="navbar-brand fs-2 fw-bold" href="##"><span class="main-color">My</span>Cart
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
                      <a class="nav-link p-0" href="##" role="button" id="adminLogin">
                      Login <img src="../assets/images/login.png" width="18" class="login-img" alt="">
                      </a>
                   </div>
                </cfif>
             </nav>
             <div class="contents body-adminhomepage d-flex">
                <div class="col-9 mx-auto rounded-3 border border-1 py-4 px-3 list-items shadow-lg">
                   <div class="col-12 d-flex align-items-center position-sticky top-0 content-heading-wrapper bg-white">
                      <p class="fw-bold m-0 p-0 fs-5 ps-2" id="mainHeader">#local.subName.category.FLDSUBCATEGORYNAME#</p>
                      <a href="##" id="addProduct" sub-id="#url.subid#" cate-id="#local.category.categoryId#" class="fw-bold text-decoration-none ms-2 btn btn-outline btn-outline1">
                      Add+
                      </a>
                   </div>
                   <ul class="list-group d-grid gap-3 mt-3" id="subcategory-list">
                      <div class="row">
                         <cfset local.productList = application.getlistObj.getProducts(subid=url.subid)>
                         <cfloop query="#local.productList.products#" >
                         <cfset local.image = FLDPRODUCTTHUMBNAIL>
                            <div class="col-6 mb-2">
                               <li class="px-5 list-group-item rounded-pill border broder-1 list-desi p-0 d-flex justify-content-between" title="#FLDPRODUCTDESCRIPTION#">
                                  <div class="col-5 overflow-hidden">
                                     <div class="fw-bold productname">#FLDPRODUCTNAME#</div>
                                     <div class="form-text p-0 m-0">#FLDBRANDNAME#</div>
                                     <div class="fw-bold price-tag fs-4">&##8377;#FLDPRODUCTPRICE#</div>
                                  </div>
                                  <div class="col-3 align-content-center">
                                     <img src="../assets/productImage/#local.image#" class="rounded-circle adminProductimage" width="60" height="60" alt="" id="imageThumbnail" style="cursor:pointer" data-id="#FLDPRODUCT_ID#">
                                  </div>
                                  <div class="col-3 align-content-center">
                                     <div class="float-end">
                                        <a class="btn btn-outline-light py-0 px-2 editProduct" data-id="#FLDPRODUCT_ID#"> 
                                        <img src="../assets/images/edit.png" width="20"> 
                                        </a>
                                        <a href="" class="btn btn-outline-light p-1 py-0 deleteItem" data-id="#FLDPRODUCT_ID#"> 
                                        <img src="../assets/images/delete.png" width="20"> 
                                        </a>
                                     </div>
                                  </div>
                               </li>
                            </div>
                         </cfloop>
                      </div>
                   </ul>
                </div>
             </div>
             <!-- Modal -->
             <div class="modal fade" id="productModal" data-bs-backdrop="static" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog d-flex gap-0">
                   <div class="modal-content border-0 rounded-0 rounded-start">
                      <div class="modal-header create-bg">
                         <h5 class="modal-title color-address create-title w-100 text-center py-2 rounded-pill" id="exampleModalLabel"></h5>
                      </div>
                      <div class="modal-body">
                         <form action="homePage.cfm" method="post" id="productForm" enctype="multipart/form-data">
                            <table class="table">
                               <tbody>
                                  <tr id="categories">
                                     <td>
                                        <cfset categoryList = application.getlistObj.getCategories()>
                                        <label for="" class="form-text fw-bold color-address">Categories Name*</label>
                                        <select name="" class="form-control" id="categoriesName" class="productCategory">
                                           <cfloop query="categoryList.categories">
                                              <option value="#FLDCATEGORY_NAME#">#FLDCATEGORY_NAME#</option>
                                           </cfloop>
                                        </select>
                                        <p id="errorCategory" class="text-danger"></p>
                                     </td>
                                  </tr>
                                  <tr id="subcategories">
                                     <td>
                                        <cfset subcategoryList = application.getlistObj.getSubCategories(local.category.categoryId)>
                                        <label for="" class="form-text fw-bold color-address">SubCategories Name*</label>
                                        <select name="" class="form-control" id="subCategoriesName">
                                           <cfloop query="subcategoryList.subcategories">
                                              <option value="#subcategoryList.subcategories.FLDSUBCATEGORYNAME#">#subcategoryList.subcategories.FLDSUBCATEGORYNAME#</option>
                                           </cfloop>
                                        </select>
                                        <p id="errorSubcategory" class="text-danger"></p>
                                     </td>
                                  </tr>
                                  <tr class="product-rows">
                                     <td>
                                        <label for="" class="form-text fw-bold color-address">Product Name*</label>
                                        <input type="text" class="form-control" placeholder="Product Name" id="productName">
                                        <p id="errorProductName" class="text-danger"></p>
                                     </td>
                                  </tr>
                                  <tr class="product-rows">
                                     <td>
                                        <label for="" class="form-text fw-bold color-address">Product Brand*</label>
                                        <input type="text" class="form-control" placeholder="Product Brand" id="productBrand">
                                        <p id="errorProductBrand" class="text-danger"></p>
                                     </td>
                                  </tr>
                                  <tr class="product-rows">
                                     <td>
                                        <label for="" class="form-text fw-bold color-address">Product Description*</label>
                                        <input type="text" class="form-control" placeholder="Product Description" id="productDescription">
                                        <p id="errorProductDesc" class="text-danger"></p>
                                     </td>
                                  </tr>
                                  <tr class="product-rows">
                                     <td>
                                        <label for="" class="form-text fw-bold color-address">Product Price*</label>
                                        <input type="text" class="form-control" placeholder="Product Price" id="productPrice">
                                        <p id="errorProductPrice" class="text-danger"></p>
                                     </td>
                                  </tr>
                                  <tr class="product-rows">
                                     <td>
                                        <label for="" class="form-text fw-bold color-address">Product Image*</label>
                                        <input type="file" name="images" class="form-control" id="productImage" multiple>
                                        <p id="errorProductImage" class="text-danger"></p>
                                     </td>
                                  </tr>
                                  <tr class="product-rows">
                                     <td>
                                        <label for="" class="form-text fw-bold color-address">Product Tax*</label>
                                        <input type="text" class="form-control" id="productTax" placeholder="Product Tax">
                                        <p id="errorProductTax" class="text-danger"></p>
                                     </td>
                                  </tr>
                               </tbody>
                            </table>
                         </form>
                      </div>
                      <div class="modal-footer">
                         <button type="button" id="closeProduct" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                         <button type="button" id="modalSubmit" class="btn btn-primary" data-id="" data-type="product">Submit</button>
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
                         <button type="button" id="deleteProduct" class="btn btn-danger">Delete</button>
                      </div>
                   </div>
                </div>
             </div>

             <!--- Image Modal --->
             <div class="modal fade" id="imageModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
               <div class="modal-dialog modal-dialog-centered">    
                 <div class="modal-content">
                   <div class="modal-body" id="imagemodalBody">
                     
                   </div>
                   <div class="modal-footer">
                     <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                   </div>
                 </div>
               </div>
             </div>
             <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
             <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
             <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js"></script>
             <script src="../assets/script/jquery.js"></script>
          </body>
          <cfinclude  template="footer.cfm">
       </html>
       <cfelse>
       <cflocation url="Adminlogin.cfm">
    </cfif>
 </cfoutput>