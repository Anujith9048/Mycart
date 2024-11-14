$(document).ready(function() {
    // Login Admin
    $("#submitButton").off('click').on('click', function(event) {
        event.preventDefault();
        var isValid = validateForm();
        if (isValid) {
            var username = jQuery.trim($('#InputUname').val());
            var email = jQuery.trim($('#InputEmail').val());
            var password = jQuery.trim($('#InputPassword').val());

            $.ajax({
                url: '../controllers/loginUser.cfc?method=checkUser',
                method: 'post',
                data: { username, email, password },
                dataType: 'JSON',
                success: function(response) {
                    if (response.result === true) {
                        $("#InputEmail,#InputUname,#InputPassword,#roleOptions").removeClass("is-invalid");
                        $("#InputEmail,#InputUname,#InputPassword,#roleOptions").addClass("is-valid");
                        $("#passwordHelp").text('');
                        window.location.href="adminHome.cfm";
                    } else{
                        $("#InputEmail,#InputUname,#InputPassword,#roleOptions").addClass("is-invalid");
                        $("#InputEmail,#InputUname,#InputPassword,#roleOptions").removeClass("is-valid");
                        $("#passwordHelp").addClass("text-danger");
                        $("#passwordHelp").removeClass("text-success");
                        $("#passwordHelp").text("login faild");
                    }
                },
                error: function(status, error) {
                    console.log("AJAX error: " + status + ", " + error);
                }
            });
        }
    });

    // Logout
    $("#adminLogoutbtn").off('click').on('click', function() {
        $.ajax({
            url: '../models/loginUser.cfc?method=logout',
            method: 'post',
            dataType: 'JSON',
            success: function(response) {
                if (response) {
                    window.location.href="Adminlogin.cfm";
                }
            },
            error: function(status, error) {
                console.log("AJAX error: " + status + ", " + error);
            }
        });
    });



    //Load categories
    $.ajax({
        url: '../models/getList.cfc?method=getCategories',
        method: 'post',
        dataType: 'JSON',
        success: function(response) {
            var categories = response.categories.DATA;
            let listCategories ='';

            for(category of categories){
                let categoryId = category[1];
                let categoryName = category[0];
                listCategories += `<li class="px-3 list-group-item rounded-pill border broder-1 list-desi">${categoryName}
                <div class="float-end">
                    <a class="btn btn-outline-light py-0 px-2 editItem" data-id="${categoryId}"> 
                    <img src="../assets/images/edit.png" width="20"> 
                    </a>

                    <a href="" class="btn btn-outline-light p-1 py-0 deleteItem" data-id="${categoryId}"> 
                    <img src="../assets/images/delete.png" width="20"> 
                    </a>

                    <a href="subcategoryList.cfm?id=${categoryId}" class="list-content btn btn-outline-light p-0 px-3 text-decoration-none align-content-center" data-id="${categoryId}">
                    <img src="../assets/images/right.svg" width="15" class="text-light p-0" alt="">
                    </a>
                </div>
                </li>`;
            }

            
            $("#item-list").html(listCategories);
        },
        error: function(status, error) {
            console.log("AJAX error: " + status + ", " + error);
        }
    });

    // Add categories
    $("#addCategories").off('click').on('click', function(event) {
        event.preventDefault();
        $("#modalSubmit").attr("data-type", 'category');
        $("#modalSubmit").attr("data-id", '');
        $("#exampleModalLabel").text("Add Categories");
        $("#categoriesName").val('');
        $("#exampleModal").modal('show');
    });

    // Modal submit
    $("#modalSubmit").off('click').on('click', function(event) {
        var type=$(this).attr("data-type");
        event.preventDefault();
        var validated = validateModal(type);
        if(validated){
            // Submit Categories
            if(type ==='category' || type === 'editCategory'){
                var type=$(this).attr("data-type");
                var id=$(this).attr("data-id");
                var categoryName =$("#categoriesName").val();
                $.ajax({
                    url: '../controllers/savedetails.cfc?method=addCategory',
                    method: 'post',
                    data: {categoryName , type ,id},
                    dataType: 'JSON',
                    success: function(response) {
                        if (response.result) {
                            $("#errorCategory").text('');
                            $("#categoriesName").removeClass("is-invalid");
                            $("#categoriesName").addClass("is-valid");
                            $("#categoriesName").removeAttr("title");
                            window.location.href="adminHome.cfm";
                        }
                        else{
                            $("#categoriesName").attr("title",response.msg);
                            $("#categoriesName").addClass("is-invalid");
                            $("#categoriesName").removeClass("is-valid");
                            $("#errorCategory").text(response.msg);
                        }
                    },
                    error: function(status, error) {
                        console.log("AJAX error: " + status + ", " + error);
                    }
                });
            }

            // Submit subCategories
            else if(type ==='subcategory' || type === 'editSubcategory'){
                var type=$(this).attr("data-type");
                var id=$(this).attr("data-id");
                var categoryName =$("#categoriesName").val();
                var subCategoryName =$("#subCategoriesName").val();
                var CateId=$('#addSubCategories').attr("data-id");
                $.ajax({
                    url: '../controllers/savedetails.cfc?method=addSubCategory',
                    method: 'post',
                    data: {categoryName,subCategoryName,type,id},
                    dataType: 'JSON',
                    success: function(response) {
                        
                        if (response.result === true) {
                            $("#errorCategory").text('');
                            $("#categoriesName").removeClass("is-invalid");
                            $("#categoriesName").addClass("is-valid");
                            
                            $("#errorSubcategory").text('');
                            $("#subCategoriesName").removeClass("is-invalid");
                            $("#subCategoriesName").addClass("is-valid");
                            window.location.href=`subcategoryList.cfm?id=${CateId}`;
                        }
                        else if(response.result ==='NoCategory'){
                            $("#categoriesName").removeClass("is-valid");
                            $("#categoriesName").addClass("is-invalid");
                            $("#errorCategory").text(response.msg);
                        }
                        else{
                            $("#subCategoriesName").removeClass("is-valid");
                            $("#subCategoriesName").addClass("is-invalid");
                            $("#errorSubcategory").text(response.msg);
                        }
                    },
                    error: function(xhr, status, error) {
                        console.log("AJAX error: " + status + ", " + error);
                        console.log("Full response:", xhr.responseText);
                    }
                    
                });
            }

            // Submit Product
            else if(type ==='product' || type === 'editProduct'){
                var productImage = $("#productImage")[0].files[0];
                var subid = $(this).attr("sub-id");
                if(type === 'product') {
                    var formData = new FormData();
                    formData.append("categoryName", $("#categoriesName").val());
                    formData.append("subCategoryName", $("#subCategoriesName").val());
                    formData.append("subCategoryID", subid);
                    formData.append("productName", $("#productName").val());
                    formData.append("productDescription", $("#productDescription").val());
                    formData.append("productBrand", $("#productBrand").val());
                    formData.append("productPrice", $("#productPrice").val());
                    formData.append("productTax", $("#productTax").val());

                    var files = $("#productImage")[0].files;
                      
                    for (var i = 0; i < files.length; i++) {
                        formData.append("productImages", files[i]);
                    }

                    $.ajax({
                        url: '../models/savedetails.cfc?method=addProduct',
                        method: 'POST',
                        data: formData,
                        processData: false, 
                        contentType: false,
                        success: function(response) {
                            console.log(response);
                            if (response.result) {
                                window.location.href = `productList.cfm?subid=${subid}`;
                            }
                        },
                        error: function(xhr, status, error) {
                            console.log("AJAX error: " + status + ", " + error);
                        }
                    });

                }
                
                else{
                    if(productImage){
                        var condition ='withImage';
                        var subid=$('#addProduct').attr("sub-id");
                        var proId=$(this).attr("data-id");
                        var categoryName = jQuery.trim($("#categoriesName").val());
                        var subCategoryName = jQuery.trim($("#subCategoriesName").val());
                        var productName = jQuery.trim($("#productName").val());
                        var productBrand = jQuery.trim($("#productBrand").val());
                        var productDescription = jQuery.trim($("#productDescription").val());
                        var productPrice = jQuery.trim($("#productPrice").val());
                        var productTax = jQuery.trim($("#productTax").val());
                        let files = document.getElementById("productImage").files;

                        var formData = new FormData();
                        formData.append("categoryName", categoryName);
                        formData.append("subCategoryName", subCategoryName);
                        formData.append("productName",productName);
                        formData.append("productDescription", productDescription);
                        formData.append("productBrand", productBrand);
                        formData.append("productPrice", productPrice);
                        formData.append("condition", condition);
                        formData.append("proId", proId);
                        formData.append("productTax", productTax);
                        
                        for (let i = 0; i < files.length; i++) {
                            formData.append("ProductImage", files[i]);
                        }


                        $.ajax({
                            url: '../controllers/savedetails.cfc?method=editProduct',
                            method: 'post',
                            data: formData,
                            dataType: 'JSON',
                            processData: false, 
                            contentType: false,
                            success: function(response) {
                                console.log(response);
                                if(response.result === true){
                                    $("#subCategoriesName").removeClass('is-invalid');
                                    $("#errorSubcategory").text('');

                                    $("#categoriesName").removeClass('is-invalid');
                                    $("#errorCategory").text('');
                                    window.location.href=`productList.cfm?subid=${subid}`;
                                }
                                else if(response.result ==='NoSubCategory'){
                                    $("#subCategoriesName").addClass('is-invalid');
                                    $("#errorSubcategory").text(response.msg);
                                }
                                else if(response.result ==='NoCategory'){
                                    $("#categoriesName").addClass('is-invalid');
                                    $("#errorCategory").text(response.msg);
                                }
                            },
                            error: function(xhr, status, error) {
                                console.log("AJAX error: " + status + ", " + error);
                                console.log("Full response:", xhr.responseText);
                            }

                        });
                    }
                    else{
                        var condition ='withoutImage';
                        var subid=$('#addProduct').attr("sub-id");
                        var proId=$(this).attr("data-id");
                        var categoryName = jQuery.trim($("#categoriesName").val());
                        var subCategoryName = jQuery.trim($("#subCategoriesName").val());
                        var productName = jQuery.trim($("#productName").val());
                        var productBrand = jQuery.trim($("#productBrand").val());
                        var productDescription = jQuery.trim($("#productDescription").val());
                        var productPrice = jQuery.trim($("#productPrice").val());
                        var productTax = jQuery.trim($("#productTax").val());

                        var formData = new FormData();
                        formData.append("categoryName", categoryName);
                        formData.append("subCategoryName", subCategoryName);
                        formData.append("productName",productName);
                        formData.append("productDescription", productDescription);
                        formData.append("productBrand", productBrand);
                        formData.append("productPrice", productPrice);
                        formData.append("condition", condition);
                        formData.append("proId", proId);
                        formData.append("productTax", productTax);


                        $.ajax({
                            url: '../controllers/savedetails.cfc?method=editProduct',
                            method: 'post',
                            data: formData,
                            dataType: 'JSON',
                            processData: false, 
                            contentType: false,
                            success: function(response) {
                                console.log(response);
                                if(response.result === true){
                                    $("#subCategoriesName").removeClass('is-invalid');
                                    $("#errorSubcategory").text('');

                                    $("#categoriesName").removeClass('is-invalid');
                                    $("#errorCategory").text('');
                                    window.location.href=`productList.cfm?subid=${subid}`;
                                }
                                else if(response.result ==='NoSubCategory'){
                                    $("#subCategoriesName").addClass('is-invalid');
                                    $("#errorSubcategory").text(response.msg);
                                }
                                else if(response.result ==='NoCategory'){
                                    $("#categoriesName").addClass('is-invalid');
                                    $("#errorCategory").text(response.msg);
                                }
                            },
                            error: function(xhr, status, error) {
                                console.log("AJAX error: " + status + ", " + error);
                                console.log("Full response:", xhr.responseText);
                            }

                        });
                    }
                }
            }
            
        }
    });

    // Edit Categories
    $(document).on('click', '.editItem', function(event) {
        event.preventDefault();
        var id=$(this).attr("data-id");
        $.ajax({
            url: '../models/getList.cfc?method=selectCategoryName',
            method: 'post',
            data: {id},
            dataType: 'JSON',
            success: function(response) {
                var category = response.category.DATA[0];
                
                
                if (response) {
                    $("#modalSubmit").attr("data-type", 'editCategory');
                    $("#modalSubmit").attr("data-id", id);
                    $("#exampleModalLabel").text("Edit Categories");
                    $("#categoriesName").val(category);
                    $("#exampleModal").modal('show');
                }
            },
            error: function(status, error) {
                console.log("AJAX error: " + status + ", " + error);
            }
        });
        
    });
    
    // Delete Categories
    $(document).on('click', '.deleteItem', function(event) {
        event.preventDefault();
        var id = $(this).attr("data-id");
        $("#deleteItem").attr("data-id", id);
        $("#deleteModal").modal('show');
    });
    $("#confirmDelete").off('click').on('click', function(event) {
        event.preventDefault();
        var id = $("#deleteItem").attr("data-id");
        $.ajax({
            url: '../models/savedetails.cfc?method=deleteCategories',
            method: 'post',
            data: {id},
            dataType: 'JSON',
            success: function(response) {
                if (response.result) {
                    window.location.href = "adminHome.cfm";
                }
            },
            error: function(status, error) {
                console.log("AJAX error: " + status + ", " + error);
            }
        });
    });


    // Add Subcategories
    $("#addSubCategories").off('click').on('click', function(event) {
        event.preventDefault();
        var id = $(this).attr("data-id");
        $.ajax({
            url: '../models/getList.cfc?method=selectCategoryName',
            method: 'post',
            data: {id},
            dataType: 'JSON',
            success: function(response) {
                var category = response.category.DATA[0];
                if (response) {
                    $("#categoriesName").val(category);
                    $("#subCategoriesName").val('');
                    $("#modalSubmit").attr("data-id", id);
                    $("#exampleModalLabel").text("Add SubCategories");
                    $("#subCategoriesModal").modal('show');
                }
            },
            error: function(status, error) {
                console.log("AJAX error: " + status + ", " + error);
            }
        });
    });

    
    // Edit SubCategories
    $(document).on('click', '.editSubcategory', function(event) {
        event.preventDefault();
        var cateId=$('#addSubCategories').attr("data-id");
        var subId=$(this).attr("data-id");
        
        $.ajax({
            url: '../models/getList.cfc?method=selectSubCategory',
            method: 'post',
            data: {subId,cateId},
            dataType: 'JSON',
            success: function(response) {
                var category = response.category.DATA[0];
                var subcategory = response.subcategory.DATA[0];
                
                
                if (response) {
                    $("#modalSubmit").attr("data-type", 'editSubcategory');
                    $("#modalSubmit").attr("data-id", subId);
                    $("#exampleModalLabel").text("Edit SubCategories");
                    $("#categoriesName").val(category);
                    $("#subCategoriesName").val(subcategory);
                    $("#subCategoriesModal").modal('show');
                }
            },
            error: function(status, error) {
                console.log("AJAX error: " + status + ", " + error);
            }
        });
        
    });

    // Delete SubCategories
    $("#deleteSubcategory").off('click').on('click', function(event) {
        event.preventDefault();
        var id = $("#deleteItem").attr("data-id");
        var cateID =$("#addSubCategories").attr("data-id");
        $.ajax({
            url: '../models/savedetails.cfc?method=deleteSubCategories',
            method: 'post',
            data: {id},
            dataType: 'JSON',
            success: function(response) {
                if (response.result) {
                    window.location.href = `subcategoryList.cfm?id=${cateID}`;
                }
            },
            error: function(status, error) {
                console.log("AJAX error: " + status + ", " + error);
            }
        });
    });



    // Add Product
    $("#addProduct").off('click').on('click', function(event) {
        event.preventDefault();
        var subid = $(this).attr("sub-id");
        var cateid = $(this).attr("cate-id");
        $.ajax({
            url: '../models/getList.cfc?method=selectSubCategory',
            method: 'post',
            data: {cateid , subid},
            dataType: 'JSON',
            success: function(response) {
                var category = response.category.DATA[0];
                var subcategory = response.subcategory.DATA[0];
                
                if (response) {
                    $("#categoriesName").val(category);
                    $("#subCategoriesName").val(subcategory);
                    $("#modalSubmit").attr("sub-id", subid);
                    $("#modalSubmit").attr("cate-id", cateid);
                    $("#exampleModalLabel").text("Add Product");
                    $("#productModal").modal('show');
                }
            },
            error: function(status, error) {
                console.log("AJAX error: " + status + ", " + error);
            }
        });
    });

    // Edit Product
    $(document).on('click', '.editProduct', function(event) {
        event.preventDefault();
        var subId=$('#addProduct').attr("sub-id");
        var proId=$(this).attr("data-id");

        
        $.ajax({
            url: '../models/getList.cfc?method=selectProduct',
            method: 'post',
            data: {subId,proId},
            dataType: 'JSON',
            success: function(response) {
                var product = response.product.DATA[0];
                var categoryList = response.subcategory.DATA[0];
                var category = categoryList[0];
                var subcategory = categoryList[1];
                console.log(product);
                
                if (response) {
                    $("#modalSubmit").attr("data-type", 'editProduct');
                    $("#modalSubmit").attr("data-id", proId);
                    $("#exampleModalLabel").text("Edit Product");
                    $("#categoriesName").val(category);
                    $("#productName").val(product[0]);
                    $("#productBrand").val(product[4]);
                    $("#productDescription").val(product[1]);
                    $("#productPrice").val(product[3]);
                    $("#subCategoriesName").val(subcategory);
                    $("#productTax").val(product[6]);
                    $("#productModal").modal('show');
                }
            },
            error: function(status, error) {
                console.log("AJAX error: " + status + ", " + error);
            }
        });
        
    });

    // Delete Product
    $("#deleteProduct").off('click').on('click', function(event) {
        event.preventDefault();
        var id = $("#deleteItem").attr("data-id");
        var subId =$("#addProduct").attr("sub-id");
        $.ajax({
            url: '../models/savedetails.cfc?method=deleteProduct',
            method: 'post',
            data: {id,subId},
            dataType: 'JSON',
            success: function(response) {
                if (response.result) {
                    window.location.href = `productList.cfm?subid=${subId}`;
                }
            },
            error: function(status, error) {
                console.log("AJAX error: " + status + ", " + error);
            }
        });
    });

    $("#categoriesName").on("change", function() {
        const selectedValue = $(this).val(); 
        if (selectedValue) {
          $.ajax({
            url: "../controllers/savedetails.cfc?method=changeSubcategory",
            type: "GET",
            data: { 
              "categoryName": selectedValue
            },
            dataType: 'JSON',
            success: function(data) {
            var subcategories1 =data.subcategories.DATA;
            let tabContent = `<option value="" selected></option>`;
      
            if (subcategories1.length != 0) {
                for(item of subcategories1) {
                  tabContent += `<option value="${item[0]}">${item[0]}</option>\n`;
                };

                $("#subCategoriesName").html(tabContent);
              }
            else {
                $("#subCategoriesName").html(`<option value="" selected></option>`);
            }
            },
            error: function(xhr, status, error) {
              console.error("Error fetching subcategories:", error);
            }
          });
        } else {
          $("#subCategoriesName").html(`<option value="" selected></option>`);
        }
      });



      $("#closeProduct").off('click').on('click', function(event) {
        location.reload();
    });


    // -------------User View------------------------

    
    $("#addToCart").off('click').on('click', function(event) {
        event.preventDefault();
        var proid = $(this).attr("pro-id");
        $.ajax({
            url: '../models/savedetails.cfc?method=addCart',
            method: 'post',
            data: {proid},
            dataType: 'JSON',
            success: function(response) {
             
                if (response.result === true) {
                    window.location.href="cartPage.cfm";
                }
                else if(response.result === "login"){
                    window.location.href="userloginPage.cfm";
                }
                else{
                    window.location.href="cartPage.cfm";
                }
            },
            error: function(status, error) {
                console.log("AJAX error: " + status + ", " + error);
            }
        });
    });


    // Login User
    $("#submitLogin").off('click').on('click', function(event) {
        event.preventDefault();
        var isValid = validateForm();
        if (isValid) {
            var username = jQuery.trim($('#InputUname').val());
            var email = jQuery.trim($('#InputEmail').val());
            var password = jQuery.trim($('#InputPassword').val());

            $.ajax({
                url: '../controllers/loginUser.cfc?method=checkLogin',
                method: 'post',
                data: { username, email, password },
                dataType: 'JSON',
                success: function(response) {
                    if (response.result === true) {
                        $("#InputEmail,#InputUname,#InputPassword,#roleOptions").removeClass("is-invalid");
                        $("#InputEmail,#InputUname,#InputPassword,#roleOptions").addClass("is-valid");
                        $("#passwordHelp").text('');
                        window.location.href="homePage.cfm";
                    } else{
                        $("#InputEmail,#InputUname,#InputPassword,#roleOptions").addClass("is-invalid");
                        $("#InputEmail,#InputUname,#InputPassword,#roleOptions").removeClass("is-valid");
                        $("#passwordHelp").addClass("text-danger");
                        $("#passwordHelp").removeClass("text-success");
                        $("#passwordHelp").text("login faild");
                    }
                },
                error: function(status, error) {
                    console.log("AJAX error: " + status + ", " + error);
                }
            });
        }
    });

     // Logout
     $("#Userlogout").off('click').on('click', function() {
        $.ajax({
            url: '../models/loginUser.cfc?method=logout',
            method: 'post',
            dataType: 'JSON',
            success: function(response) {
                if (response) {
                    window.location.href="userloginPage.cfm";
                }
            },
            error: function(status, error) {
                console.log("AJAX error: " + status + ", " + error);
            }
        });
    });

    // Remove Cart
    $(".removeCart").off('click').on('click', function() {
        var proid = $(this).attr("pro-id");
        $.ajax({
            url: '../models/savedetails.cfc?method=removeCart',
            method: 'post',
            data:{proid},
            dataType: 'JSON',
            success: function(response) {
                if (response.result) {
                    window.location.href="cartPage.cfm";
                }
            },
            error: function(status, error) {
                console.log("AJAX error: " + status + ", " + error);
            }
        });
    });

// Search Item
    $("#searchItem").off('click').on('click', function(event) {
        event.preventDefault();
        var productName = $("#productName").val();
        window.location.href=`userProductList.cfm?search=${productName}`;
    });

 // Cart Quantity
 $(".quantityControl").off('click').on('click', function(event) {
    event.preventDefault();
    var id = $(this).attr("pro-id");
    var type =$(this).attr("data-type");
    
    $.ajax({
        url: '../models/savedetails.cfc?method=addQuantity',
        method: 'post',
        data: {id,type},
        dataType: 'JSON',
        success: function(response) {
            if (response.result) {
                window.location.href = "cartPage.cfm";
            }
        },
        error: function(status, error) {
            console.log("AJAX error: " + status + ", " + error);
        }
    });
});

// Sort Items
$(".sort").off('click').on('click', function(event) {
    event.preventDefault();
    var type =$(this).attr("type");
    var data =$(this).attr("data-id");
    var mode =$(this).attr("data-mode");
    if (mode==="search") {
        window.location.href = `userProductList.cfm?search=${data}&sort=${type}`;
    }
    else if(mode==="sub"){
        window.location.href = `userProductList.cfm?subid=${data}&sort=${type}`;
    }
});

// Submit Address
$("#submitAddress").off('click').on('click', function(event) {
    event.preventDefault();
    var validate = validateAddress();
    if(validate){
        var name = jQuery.trim($('#name').val());
        var phone = jQuery.trim($('#phone').val());
        var pincode = jQuery.trim($('#pincode').val());
        var state = jQuery.trim($('#state').val());
        var city = jQuery.trim($('#city').val());
        var building = jQuery.trim($('#building').val());
        var area = jQuery.trim($('#area').val());
        $.ajax({
            url: '../models/savedetails.cfc?method=addAddress',
            method: 'post',
            data: {name,phone,pincode,state,city,building,area},
            dataType: 'JSON',
            success: function(response) {
                if (response.result) {
                    window.location.href = "userProfile.cfm";
                }
            },
            error: function(status, error) {
                console.log("AJAX error: " + status + ", " + error);
            }
        });
    }
});

// selectAddress
$("#selectAddress").off('click').on('click', function(event) {
    
    event.preventDefault();
    var addressId = $('input[name="addressRadio"]:checked').val();
    var proid = $(this).attr('proid');
    if(proid === ""){
        window.location.href=`paymentPage.cfm?addressid=${addressId}&order=cart`
    }
    else{
        window.location.href=`paymentPage.cfm?addressid=${addressId}&proid=${proid}`
    }
});

$(".quantityControlPayment").off('click').on('click', function(event) {event.preventDefault();
    var type = $(this).attr('data-type');
    var quantity = parseInt($("#productQuantity").text(), 10); 
    
    if (type === 'increase') {
        quantity = quantity + 1;
    } else if (type === 'decrease') {
        quantity = quantity - 1;
    }
    if (quantity < 1) {
        quantity = 1;
    }
    
    $("#productQuantity").text(quantity);
    
});

// PAY
$("#pay").off('click').on('click', function(event) {
    var cardnumber =  jQuery.trim($('#cardnumber').val());
    var cvv =  jQuery.trim($('#cvv').val());
    var result = true;
    if(cardnumber != '11111111111'){
       $('#cardnumber').addClass("is-invalid");
       result = false;
    }
    else{
       $('#cardnumber').removeClass("is-invalid");
       $('#cardnumber').addClass("is-valid");
    }
    if(cvv != '123'){
       $('#cvv').addClass("is-invalid");
       result = false;
    }
    else{
       $('#cvv').removeClass("is-invalid");
       $('#cvv').addClass("is-valid");
    }
    if(result){
        var addressId =$(this).attr("address-id");
        var proid =$(this).attr("proid");
        var price =$("#productprice").attr("price");
        var quantity =$('#productQuantity').text();

        if(isNaN(proid)){
            $.ajax({
                url: '../models/savedetails.cfc?method=orderCartProduct',
                method: 'post',
                data: {addressId},
                dataType: 'JSON',
                success: function(response) {
                    window.location.href="paysuccess.cfm"
                },
                error: function(status, error) {
                    console.log("AJAX error: " + status + ", " + error);
                }
            });
        }
        else{
        $.ajax({
            url: '../models/savedetails.cfc?method=orderProduct',
            method: 'post',
            data: {cardnumber,cvv,addressId,proid,quantity,price},
            dataType: 'JSON',
            success: function(response) {
                if (response.result) {
                    window.location.href="paysuccess.cfm"
                }
            },
            error: function(status, error) {
                console.log("AJAX error: " + status + ", " + error);
            }
        });
    }
    }
});


$("#submitFilter").off('click').on('click', function(event) {
    event.preventDefault();
    var checkedValues = $(".form-check-input:checked").map(function() {
        return $(this).val();
    }).get();
    var subid=$(this).attr("sub-id");

    $.ajax({
        url: '../models/savedetails.cfc?method=filterSort',
        method: 'post',
        data: {checkedValues: JSON.stringify(checkedValues),subid},
        dataType: 'json',
        success: function(response) {
            
            var productsHtml = '';
            if(response.DATA.length === 0){
                productsHtml =`
                <h1 class="fw-bold">OOPS!!</h5>
                <p class="card-text productname fs-1">No Product found!</p>`
            }
            
            
            response.DATA.forEach(function(product) {
                productsHtml += `
                <a href="userProduct.cfm?proid=${product[0]}" class="col-md-3 mt-3 text-decor-none" proid="${product[0]}">
                    <div class="card" style="width: 18rem; height: 24rem;">
                        <img src="../assets/productImage/${product[4]}" class="card-img-top p-2" height="250" alt="...">
                        <div class="card-body">
                            <h5 class="card-title productname ">${product[1]}</h5>
                            <p class="card-text productname ">${product[2]}</p>
                            <p class="card-text fw-bold price-tag ">&#8377;${product[3]}</p>
                        </div>
                    </div>
                </a>`;
            });
            
            $('.item-row').empty().html(productsHtml);
        },
        
        error: function(xhr, status, error) {
            console.error("AJAX error: " + status + ", " + error);
        }
    });
});

$("#orderSearch").off('click').on('click', function(event) {
    event.preventDefault();
    var orderid = $("#orderidInput").val();
    window.location.href=`orderHistory.cfm?orderid=${orderid}`
});



$(document).on('click', '#imageThumbnail', function(event) {
    event.preventDefault();
    var proId=$(this).attr("data-id");

    
    $.ajax({
        url: '../models/getList.cfc?method=getProductImages',
        method: 'post',
        data: {proId},
        dataType: 'JSON',
        success: function(response) {

            var imageList = response;
            
            var content = `
                <div id="carouselExampleIndicators" class="carousel carousel-dark slide col-12" data-bs-ride="carousel">
                    <div class="carousel-indicators mb-0">
            `;
            for (var i = 0; i < response.length; i++) {
                content += `
                    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="${i}"
                        class="${i === 0 ? 'active' : ''} bg-dark" aria-label="Slide ${i + 1}"></button>
                `;
            }
            content += `
                    </div>
                    <div class="carousel-inner carousel-style">
            `;
            var i=0
            for (images of response) {
                i=i+1
                
                content += `
                    <div class="carousel-item ${i === 1 ? 'active' : ''}">
                        <button class="btn btn-outline-danger mb-2 deleteProductimage" style="margin-left:210px;" data-id="${images.FLDIMAGEID}">Delete</button>
                        <img src="../assets/productImage/${images.FLDIMAGENAME}" alt="" style="max-width:100%; height:auto; display:block; margin:auto;">

                    </div>
                `;
            }
            content += `
                    </div>
                    <button class="carousel-control-prev px-0" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
                        <span class="carousel-control-prev-icon bg-dark me-auto py-5 px-3 rounded-pill" aria-hidden="true"></span>
                        <span class="visually-hidden">Previous</span>
                    </button>
                    <button class="carousel-control-next px-0" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
                        <span class="carousel-control-next-icon bg-dark ms-auto py-5 px-3 rounded-pill" aria-hidden="true"></span>
                        <span class="visually-hidden">Next</span>
                    </button>
                </div>
            `;
            $("#imagemodalBody").html(content);
            $("#imageModal").modal('show');
        },
        
        
        error: function(status, error) {
            console.log("AJAX error: " + status + ", " + error);
        }
    });
    
});


$(document).on('click', '.deleteProductimage', function(event) {
    var imageid=$(this).attr("data-id");
    $.ajax({
        url: '../models/savedetails.cfc?method=deleteProductimage',
        method: 'post',
        data: {imageid},
        dataType: 'JSON',
        success: function(response) {
            if (response.result) {
                location.reload()
            }
        },
        error: function(status, error) {
            console.log("AJAX error: " + status + ", " + error);
        }
    });
});




//---------Validate---------- 
function validateForm(){ 
        var username = jQuery.trim($('#InputUname').val());
        var email = jQuery.trim($('#InputEmail').val());
        var password = jQuery.trim($('#InputPassword').val());
        var result = true;
        if(username.length){
            $("#InputUname").removeClass("is-invalid");
            $("#InputUname").addClass("is-valid");
            $("#errorUname").text("");
            
        }
        else{
            $("#InputUname").addClass("is-invalid");
            $("#InputUname").removeClass("is-valid");
            $("#errorUname").text("Enter Username");
            $("#errorUname").addClass("text-danger");
            result = false;
        }
        if(email.length){
            $("#InputEmail").removeClass("is-invalid");
            $("#InputEmail").addClass("is-valid");
            $("#emailHelp").text("");
            
        }
        else{
            $("#InputEmail").addClass("is-invalid");
            $("#InputEmail").removeClass("is-valid");
            $("#emailHelp").text("Enter an Email");
            $("#emailHelp").addClass("text-danger");
            result = false;
        }

        if(password.length){
            $("#InputPassword").removeClass("is-invalid");
            $("#InputPassword").addClass("is-valid");
            $("#passwordHelp").text("");
        }
        else{
            $("#InputPassword").addClass("is-invalid");
            $("#InputPassword").removeClass("is-valid");
            $("#passwordHelp").text("Enter a password");
            $("#passwordHelp").addClass("text-danger");
            $("#passwordHelp").removeClass("text-success");
            result = false;
        }
        return result;
    };
});

function validateModal(type){
    if(type === 'category' || type === 'editCategory'){
        var categoryName = jQuery.trim($("#categoriesName").val());
        if(categoryName.length){
            $("#categoriesName").removeClass("is-invalid");
            $("#categoriesName").addClass("is-valid");
            $("#errorCategory").text("");
            return true;
        }
        else{
            $("#categoriesName").addClass("is-invalid");
            $("#categoriesName").removeClass("is-valid");
            $("#errorCategory").text("Enter Category name");
            return false;
        }
    }
    else if(type ==='subcategory' || type ==='editSubcategory'){
        var categoryName = jQuery.trim($("#categoriesName").val());
        var subCategoryName = jQuery.trim($("#subCategoriesName").val());
        var result = true;
        if(categoryName.length){
            $("#categoriesName").removeClass("is-invalid");
            $("#categoriesName").addClass("is-valid");
            $("#errorCategory").text("");
        }
        else{
            $("#categoriesName").addClass("is-invalid");
            $("#categoriesName").removeClass("is-valid");
            $("#errorCategory").text("Enter Category name");
            result = false;
        }
        
        if(subCategoryName.length){
            $("#subCategoriesName").removeClass("is-invalid");
            $("#subCategoriesName").addClass("is-valid");
            $("#errorSubcategory").text("");
        }
        else{
            $("#subCategoriesName").addClass("is-invalid");
            $("#subCategoriesName").removeClass("is-valid");
            $("#errorSubcategory").text("Enter SubCategory name");
            result = false;
        }
        return result;
        
    }
    else if(type ==='product'|| type ==='editProduct'){
        var categoryName = jQuery.trim($("#categoriesName").val());
        var subCategoryName = jQuery.trim($("#subCategoriesName").val());

        var productName = jQuery.trim($("#productName").val());
        var productDescription = jQuery.trim($("#productDescription").val());
        var productPrice = jQuery.trim($("#productPrice").val());
        var productTax = jQuery.trim($("#productTax").val());
        var productBrand = jQuery.trim($("#productBrand").val());
        var result = true;
        if(categoryName.length){
            $("#categoriesName").removeClass("is-invalid");
            $("#categoriesName").addClass("is-valid");
            $("#errorCategory").text("");
        }
        else{
            $("#categoriesName").addClass("is-invalid");
            $("#categoriesName").removeClass("is-valid");
            $("#errorCategory").text("Enter Category name");
            result = false;
        }
        
        if(subCategoryName.length){
            $("#subCategoriesName").removeClass("is-invalid");
            $("#subCategoriesName").addClass("is-valid");
            $("#errorSubcategory").text("");
        }
        else{
            $("#subCategoriesName").addClass("is-invalid");
            $("#subCategoriesName").removeClass("is-valid");
            $("#errorSubcategory").text("Enter SubCategory name");
            result = false;
        }
        
        if(productName.length){
            $("#productName").removeClass("is-invalid");
            $("#productName").addClass("is-valid");
            $("#errorProductName").text("");
        }
        else{
            $("#productName").addClass("is-invalid");
            $("#productName").removeClass("is-valid");
            $("#errorProductName").text("Enter Product name");
            result = false;
        }
        
        if(productBrand.length){
            $("#productBrand").removeClass("is-invalid");
            $("#productBrand").addClass("is-valid");
            $("#errorProductBrand").text("");
        }
        else{
            $("#productBrand").addClass("is-invalid");
            $("#productBrand").removeClass("is-valid");
            $("#errorProductBrand").text("Enter Brand name");
            result = false;
        }
        
        if(productDescription.length){
            $("#productDescription").removeClass("is-invalid");
            $("#productDescription").addClass("is-valid");
            $("#errorProductDesc").text("");
        }
        else{
            $("#productDescription").addClass("is-invalid");
            $("#productDescription").removeClass("is-valid");
            $("#errorProductDesc").text("Enter Product Description");
            result = false;
        }
        
        if(productPrice.length){
            $("#productPrice").removeClass("is-invalid");
            $("#productPrice").addClass("is-valid");
            $("#errorProductPrice").text("");
        }
        else{
            $("#productPrice").addClass("is-invalid");
            $("#productPrice").removeClass("is-valid");
            $("#errorProductPrice").text("Enter Product Price");
            result = false;
        }
        
        if(productTax.length){
            $("#productTax").removeClass("is-invalid");
            $("#productTax").addClass("is-valid");
            $("#errorProductTax").text("");
        }
        else{
            $("#productTax").addClass("is-invalid");
            $("#productTax").removeClass("is-valid");
            $("#errorProductTax").text("Enter Tax Percentage");
            result = false;
        }
        return result;
    }
}

function validateAddress(){ 
    var name = jQuery.trim($('#name').val());
    var phone = jQuery.trim($('#phone').val());
    var pincode = jQuery.trim($('#pincode').val());
    var state = jQuery.trim($('#state').val());
    var city = jQuery.trim($('#city').val());
    var building = jQuery.trim($('#building').val());
    var area = jQuery.trim($('#area').val());
    var result = true;
    if(name.length){
        $("#name").removeClass("is-invalid");
        $("#name").addClass("is-valid");
        $("#errorName").text("");
        
    }
    else{
        $("#name").addClass("is-invalid");
        $("#name").removeClass("is-valid");
        $("#errorName").text("Enter Full Name");
        $("#errorName").addClass("text-danger");
        result = false;
    }

    let phonePattern = /^(?:\+91)?[0-9]{10}$/; 
    if(phone.length && phonePattern.test(phone)){
        $("#phone").removeClass("is-invalid");
        $("#phone").addClass("is-valid");
        $("#errorPhone").text("");
    } else {
        $("#phone").addClass("is-invalid");
        $("#phone").removeClass("is-valid");
        $("#errorPhone").text("Enter a valid Phone Number");
        $("#errorPhone").addClass("text-danger");
        result = false;
    }

    if(pincode.length){
        $("#pincode").removeClass("is-invalid");
        $("#pincode").addClass("is-valid");
        $("#errorPincode").text("");
    }
    else{
        $("#pincode").addClass("is-invalid");
        $("#pincode").removeClass("is-valid");
        $("#errorPincode").text("Enter Pincode");
        $("#errorPincode").addClass("text-danger");
        $("#errorPincode").removeClass("text-success");
        result = false;
    }

    if(state.length){
        $("#state").removeClass("is-invalid");
        $("#state").addClass("is-valid");
        $("#errorState").text("");
    }
    else{
        $("#state").addClass("is-invalid");
        $("#state").removeClass("is-valid");
        $("#errorState").text("Enter State");
        $("#errorState").addClass("text-danger");
        $("#errorState").removeClass("text-success");
        result = false;
    }

    if(city.length){
        $("#city").removeClass("is-invalid");
        $("#city").addClass("is-valid");
        $("#errorCity").text("");
    }
    else{
        $("#city").addClass("is-invalid");
        $("#city").removeClass("is-valid");
        $("#errorCity").text("Enter City");
        $("#errorCity").addClass("text-danger");
        $("#errorCity").removeClass("text-success");
        result = false;
    }

    if(building.length){
        $("#building").removeClass("is-invalid");
        $("#building").addClass("is-valid");
        $("#errorBuilding").text("");
    }
    else{
        $("#building").addClass("is-invalid");
        $("#building").removeClass("is-valid");
        $("#errorBuilding").text("Enter Building");
        $("#errorBuilding").addClass("text-danger");
        $("#errorBuilding").removeClass("text-success");
        result = false;
    }

    if(area.length){
        $("#area").removeClass("is-invalid");
        $("#area").addClass("is-valid");
        $("#errorArea").text("");
    }
    else{
        $("#area").addClass("is-invalid");
        $("#area").removeClass("is-valid");
        $("#errorArea").text("Enter Area");
        $("#errorArea").addClass("text-danger");
        $("#errorArea").removeClass("text-success");
        result = false;
    }
    return result;
};
