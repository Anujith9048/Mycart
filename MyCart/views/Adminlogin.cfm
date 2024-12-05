<!DOCTYPE html>
<html lang="en">
   <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <title>MyCartAdmin | Login</title>
      <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
      <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
      <link rel="stylesheet" href="../assets/style/bootstrap.min.css">
      <link rel="stylesheet" href="../assets/style/style.css">
      <link rel="icon" type="image/x-icon" href="../assets/images/logo-img.png">
      <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
      <script src="../assets/script/jquery.js"></script>
   </head>
   <body class="" >
      <nav class="navbar navbar-expand-lg px-4 row bg-light position-sticky top-0 w-100">
         <div class="col-6 ">
            <a class="navbar-brand fs-2 fw-bold text-dark" href="#"><span class="main-color">My</span>Cart 
            <img src="../assets/images/logo-img.png" width="30" alt=""></a>
         </div>
         <div class="col-6 justify-content-end d-flex me-lg-4" id="navbarNavDropdown">
            <a class="nav-link p-0" href="" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            Login <img src="../assets/images/login.png" width="18" class="login-img" alt="">
            </a>
         </div>
      </nav>
      <div class="d-flex justify-content-center align-items-center log-content">
         <form class="col-lg-4 col-md-6 col-sm-8 col-11 p-3 pt-0 px-0 rounded-3 login-form">
            <div class="text-center log-bg rounded-top-3 py-2">
               <a class="navbar-brand fs-2 fw-bold" href="#"> Login To <span class="main-color">My</span>Cart</a>
            </div>
            <div class="form-contents px-3 pb-3 pt-4">
               <div class="mb-3">
                  <label for="exampleInputEmail1" class="form-label">Username</label>
                  <input type="text" class="form-control" id="InputUname" aria-describedby="usernameHelp" placeholder="Username">
                  <div id="errorUname" class="form-text"></div>
               </div>
               <div class="mb-3">
                  <label for="exampleInputEmail1" class="form-label">Email address</label>
                  <input type="email" class="form-control" id="InputEmail" aria-describedby="emailHelp" placeholder="Email">
                  <div id="emailHelp" class="form-text"></div>
                  <div class="error form-text text-danger" id="error"></div>
               </div>
               <div class="mb-3">
                  <label for="exampleInputPassword1" class="form-label">Password</label>
                  <input type="password" class="form-control" id="InputPassword" placeholder="Password">
                  <div id="passwordHelp" class="form-text"></div>
               </div>
               <button class="btn btn-outline btn-outline1 w-100 button-abt " id="submitButton">Submit</button>
            </div>
         </form>
      </div>
      <script src="../assets/script/jquery.js"></script>
      <script src="../assets/script/validate.js"></script>
      <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
   </body>
</html>