$(document).ready(function() {
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

                    <a href="subcategoryList.cfm?id=${categoryId}" class="list-content" data-id="${categoryId}">subcategories</a>
                </div>
                </li>`;
            }

            
            $("#item-list").html(listCategories);
        },
        error: function(status, error) {
            console.log("AJAX error: " + status + ", " + error);
        }
    });
    
    //Load subcategories
     $(document).on('click', '.list-content', function(event) {
         event.preventDefault();
         var id = $(this).attr("data-id");
         $.ajax({
             url: '../models/getList.cfc?method=getSubCategories',
             method: 'post',
             data: {id},
             dataType: 'JSON',
             success: function(response) {
                 if (response.subcategories) {
                     window.location.href = `subcategoryList.cfm?id=${id}`;
                 }
             },
             error: function(status, error) {
                 console.log("AJAX error: " + status + ", " + error);
             }
         });
     });


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
        event.preventDefault();
        var type=$(this).attr("data-type");
        var id=$(this).attr("data-id");
        var validated = validateModal(type);
        if(validated){
            if(type ==='category' || type === 'editCategory'){
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
                            window.location.href="adminHome.cfm";
                        }
                        else{
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
            else if(type ==='subcategory' || type === 'editsubcategory'){
                var categoryName =$("#categoriesName").val();
                var subCategoryName =$("#subCategoriesName").val();
                $.ajax({
                    url: '../controllers/savedetails.cfc?method=addSubCategory',
                    method: 'post',
                    data: {categoryName,subCategoryName,type,id},
                    dataType: 'JSON',
                    success: function(response) {
                        if (response.result) {

                            $("#errorCategory").text('');
                            $("#categoriesName").removeClass("is-invalid");
                            $("#categoriesName").addClass("is-valid");
                            window.location.href=`subcategoryList.cfm?id=${id}`;
                        }
                        else{
                            $("#categoriesName").addClass("is-invalid");
                            $("#categoriesName").removeClass("is-valid");
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
                    $("#subcategories").addClass("d-none");
                    $(".product-rows").addClass("d-none");
                    $("#modalSubmit").attr("data-type", 'editCategory');
                    $("#modalSubmit").attr("data-id", id);
                    $("#exampleModalLabel").text("Add Categories");
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
                    $("#modalSubmit").attr("data-id", id);
                    $("#subCategoriesModal").modal('show');
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
    else if(type ==='subcategory' || type ==='subcategory'){
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
}