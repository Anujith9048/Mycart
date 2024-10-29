$(document).ready(function() {
    // Login User
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
                if(type ==='product'){
                    var subid=$(this).attr("sub-id");
                    var categoryName = jQuery.trim($("#categoriesName").val());
                    var subCategoryName = jQuery.trim($("#subCategoriesName").val());
                    var productName = jQuery.trim($("#productName").val());
                    var productBrand = jQuery.trim($("#productBrand").val());
                    var productDescription = jQuery.trim($("#productDescription").val());
                    var productPrice = jQuery.trim($("#productPrice").val());
                    

                    var formData = new FormData();
                    formData.append("categoryName", categoryName);
                    formData.append("subCategoryName", subCategoryName);
                    formData.append("productName",productName);
                    formData.append("productDescription", productDescription);
                    formData.append("productBrand", productBrand);
                    formData.append("productPrice", productPrice);
                    formData.append("productImage", $("#productImage")[0].files[0]);


                    $.ajax({
                        url: '../controllers/savedetails.cfc?method=addProduct',
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

                        var formData = new FormData();
                        formData.append("categoryName", categoryName);
                        formData.append("subCategoryName", subCategoryName);
                        formData.append("productName",productName);
                        formData.append("productDescription", productDescription);
                        formData.append("productBrand", productBrand);
                        formData.append("productPrice", productPrice);
                        formData.append("productImage", $("#productImage")[0].files[0]);
                        formData.append("condition", condition);
                        formData.append("proId", proId);


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

                        var formData = new FormData();
                        formData.append("categoryName", categoryName);
                        formData.append("subCategoryName", subCategoryName);
                        formData.append("productName",productName);
                        formData.append("productDescription", productDescription);
                        formData.append("productBrand", productBrand);
                        formData.append("productPrice", productPrice);
                        formData.append("condition", condition);
                        formData.append("proId", proId);


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
                
                if (response) {
                    $("#modalSubmit").attr("data-type", 'editProduct');
                    $("#modalSubmit").attr("data-id", proId);
                    $("#exampleModalLabel").text("Edit Product");
                    $("#categoriesName").val(category);
                    $("#productName").val(product[0]);
                    $("#productBrand").val(product[3]);
                    $("#productDescription").val(product[1]);
                    $("#productPrice").val(product[2]);
                    $("#subCategoriesName").val(subcategory);
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
        // var productImage = jQuery.trim($("#productImage").val());
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
        
        // if(productImage.length){
        //     $("#productImage").removeClass("is-invalid");
        //     $("#productImage").addClass("is-valid");
        //     $("#errorProductImage").text("");
        // }
        // else{
        //     $("#productImage").addClass("is-invalid");
        //     $("#productImage").removeClass("is-valid");
        //     $("#errorProductImage").text("Select Product Image");
        //     result = false;
        // }
        return result;
    }
}