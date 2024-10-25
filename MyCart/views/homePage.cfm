<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MyCart|Home</title>

    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>

    <link rel="stylesheet" href="../assets/style/bootstrap.min.css">
    <link rel="stylesheet" href="../assets/style/style.css">
</head>
<body>
    
    <nav class="navbar navbar-expand-lg px-4">
        <div class="container-fluid">
          <a class="navbar-brand fw-bold" href="#">MyCart</a>
          <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
          </button>
        </div>
        <div class="collapse navbar-collapse d-flex me-4" id="navbarNavDropdown">
            <ul class="navbar-nav">
              <li class="nav-item dropdown">
                <a class="nav-link" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                  Home
                </a>
              </li>
              <li class="nav-item dropdown">
                <a class="nav-link" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                  about
                </a>
              </li>
              <li class="nav-item dropdown">
                <a class="nav-link" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                  contact
                </a>
              </li>
            </ul>
          </div>
    </nav>

      <div class="row ">
        <div class="container-fluid bg-dark text-light ps-5">
            <div class="collapse navbar-collapse d-flex" id="navbarNavDropdown">
                <ul class="navbar-nav">
                  
                  <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                      Catergories
                    </a>
                    <ul class="dropdown-menu">
                      <li><a class="dropdown-item" href="#">Electronics</a></li>
                      <li><a class="dropdown-item" href="#">Another action</a></li>
                      <li><a class="dropdown-item" href="#">Something else here</a></li>
                    </ul>
                  </li>
                </ul>
              </div>
        </div>
      </div>


      <div class="shadow-lg modal fade" id="addproduct" tabindex="-1" aria-labelledby="exampleModalLabel"
      aria-hidden="true">
      <div class="modal-dialog modal-lg d-flex gap-0">
          <div class="modal-content border-0 rounded-start">
              <div class="modal-header create-bg">
                  <h5 class="modal-title color-address create-title w-100 text-center py-2 rounded-pill"
                      id="exampleModalLabel">Add Product</h5>
              </div>
              <div class="modal-body">
                  <div class="address-view" id="address-view">
                      <table class="table">
                          <tbody>
                              <tr>
                                  <td>
                                      <label for="" class="form-text fw-bold color-address">Product Name*</label>
                                      <input type="text" class="form-control " placeholder="Name"
                                          id="productName">
                                      <p id="errorAddress" class="text-danger"></p>
                                  </td>
                                  <td>
                                      <label for="" class="form-text fw-bold color-address">Product Description*</label>
                                      <input type="text" class="form-control" placeholder="Description"
                                          id="description">
                                      <p id="errorDescription" class="text-danger"></p>
                                  </td>
                              </tr>
                              <tr>
                                  <td>
                                      <label for="" class="form-text fw-bold color-address">Product Price*</label>
                                      <input type="text" class="form-control" placeholder="Price" id="price">
                                      <p id="errorPrice" class="text-danger"></p>
                                  </td>
                                  <td>
                                      <label for="" class="form-text fw-bold color-address">Product Image*</label>
                                      <input type="file" class="form-control" placeholder="Image" id="image">
                                      <p id="errorImage" class="text-danger"></p>
                                  </td>
                              </tr>
                              <tr>
                                  <td>
                                      <label for="" class="form-text fw-bold color-address">Product Category*</label>
                                      <input type="text" class="form-control" placeholder="Category" id="category">
                                      <p id="errorCategory" class="text-danger"></p>
                                  </td>
                                  
                                  <td>
                                      <label for="" class="form-text fw-bold color-address">Product Sub Category*</label>
                                      <input type="text" class="form-control" placeholder="Sub Category" id="subCategory">
                                      <p id="errorSubCategory" class="text-danger"></p>
                                  </td>
                              </tr>
                          </tbody>
                      </table>
                  </div>
              </div>
              <div class="modal-footer">
                  <button type="button" id="closeModal" class="btn btn-secondary"
                      data-bs-dismiss="modal">Close</button>
              </div>
          </div>
          <div
              class="col-3 create-bg d-flex align-items-center justify-content-center rounded-end modal-image-box">
              <div class="image_view p-4 py-auto" id="image_view">
              </div>
          </div>
      </div>
  </div>
</body>
</html>