component {

    remote any function addCategory(categoryName, type, id) returnFormat="JSON" {
        local.objSave = createObject("component", "models.savedetails");

        if (trim(len(categoryName)) EQ 0) {
            local.error = 'Please fill the field';
            return {"result": false, "msg": local.error};
        } else {
            if (type EQ 'category') {
                local.checkCategory = local.objSave.checkCategory(categoryName = categoryName);
                if (local.checkCategory.result.recordCount EQ 0) {
                    local.addCategory = local.objSave.addCategory(categoryName = categoryName);
                    return {"result": true, "msg": "Added Category #categoryName#"};
                } else {
                    return {"result": false, "msg": "Category #categoryName# already exists!"};
                }
            } else if (type EQ 'editCategory') {
                local.editCategory = local.objSave.editCategory(categoryName = categoryName, id = id);
                return {"result": true, "msg": "Edited Category #categoryName#"};
            }
        }
    }

    remote any function addSubCategory(categoryName, subCategoryName, type, id) returnFormat="JSON" {
        local.objSave = createObject("component", "models.savedetails");

        if (trim(len(categoryName)) EQ 0 OR trim(len(subCategoryName)) EQ 0) {
            local.error = 'Please fill all the fields';
            return {"result": false, "msg": local.error};
        } else {
            if (type EQ 'subcategory') {
                local.checkSubCategory = local.objSave.checkSubCategory(subCategoryName = subCategoryName, id = id);
                if (local.checkSubCategory.result EQ 0) {
                    local.getCategoryID = local.objSave.getCategoryID(categoryName = categoryName);
                    local.categoryID = local.getCategoryID.result.FLDCATEGORY_ID;

                    if (len(local.categoryID) NEQ 0) {
                        local.addSubcategory = local.objSave.addSubcategory(subCategoryName = subCategoryName, categoryID = local.categoryID);
                        if (local.addSubcategory.result) {
                            return {"result": true, "msg": "Added SubCategory #subCategoryName#"};
                        }
                    } else {
                        return serializeJSON({"result": "NoCategory", "msg": "Category #categoryName# doesn't exist"});
                    }
                } else {
                    return serializeJSON({"result": false, "msg": "#subCategoryName# already exists"});
                }
            } else if (type EQ 'editSubcategory') {
                local.checkSubCategory = local.objSave.checkSubCategory(subCategoryName = subCategoryName, id = id);
                if (local.checkSubCategory.result EQ 0) {
                    local.getCategoryID = local.objSave.getCategoryID(categoryName = categoryName);
                    local.categoryID = local.getCategoryID.result.FLDCATEGORY_ID;

                    if (len(local.categoryID) NEQ 0) {
                        local.editSubcategory = local.objSave.editSubcategory(subCategoryName = subCategoryName, categoryID = local.categoryID, id = id);
                        if (local.editSubcategory.result) {
                            return {"result": true, "msg": "Edited SubCategory #subCategoryName#"};
                        }
                    } else {
                        return serializeJSON({"result": "NoCategory", "msg": "Category #categoryName# doesn't exist"});
                    }
                } else {
                    return serializeJSON({"result": false, "msg": "#subCategoryName# already exists"});
                }
            }
        }
    }

    remote any function addProduct(categoryName, subCategoryName, productName, productDescription, productBrand, productPrice, productImage,productTax) returnFormat="JSON" {
        local.objSave = createObject("component", "models.savedetails");

        if (trim(len(categoryName)) EQ 0 OR trim(len(subCategoryName)) EQ 0 OR trim(len(productName)) EQ 0 OR trim(len(productDescription)) EQ 0 OR trim(len(productPrice)) EQ 0 OR trim(len(productImage)) EQ 0 OR trim(len(productTax)) EQ 0) {
            local.error = 'Please fill all the fields';
            return {"result": false, "msg": local.error};
        } else {
            local.getSubCategoryID = local.objSave.getSubCategoryID(subCategoryName = subCategoryName);
            local.subCategoryID = local.getSubCategoryID.result.FLDSUBCATEGORY_ID;

            local.getCategoryID = local.objSave.getCategoryID(categoryName = categoryName);
            local.categoryID = local.getCategoryID.result.FLDCATEGORY_ID;

            local.validSubcategory = local.objSave.validSubcategory(categoryId = local.categoryID, subid = local.subCategoryID);
            if (len(local.categoryID) NEQ 0) {
                if (len(local.subCategoryID) NEQ 0) {
                    local.addProduct = local.objSave.addProduct(productName = productName, subcategoryID = local.subCategoryID, productDescription = productDescription, productBrand = productBrand, productPrice = productPrice, productImage = productImage, productTax = productTax);
                    if (local.addProduct.result) {
                        return {"result": true, "msg": "Added Product #productName#"};
                    }
                } else {
                    return serializeJSON({"result": "NoSubCategory", "msg": "SubCategory #subCategoryName# doesn't exist"});
                }
            } else {
                return serializeJSON({"result": "NoCategory", "msg": "Category #categoryName# doesn't exist"});
            }
        }
    }

    remote any function editProduct(categoryName, subCategoryName, productName, productDescription, productBrand, productPrice, productImage, condition, proId,productTax) returnFormat="JSON" {
        local.objSave = createObject("component", "models.savedetails");

        if (condition EQ 'withImage') {
            if (trim(len(categoryName)) EQ 0 OR trim(len(subCategoryName)) EQ 0 OR trim(len(productName)) EQ 0 OR trim(len(productDescription)) EQ 0 OR trim(len(productPrice)) EQ 0 OR trim(len(productImage)) EQ 0) {
                local.error = 'Please fill all the fields';
                return {"result": false, "msg": local.error};
            } else {
                local.getSubCategoryID = local.objSave.getSubCategoryID(subCategoryName = subCategoryName);
                local.subCategoryID = local.getSubCategoryID.result.FLDSUBCATEGORY_ID;

                local.getCategoryID = local.objSave.getCategoryID(categoryName = categoryName);
                local.categoryID = local.getCategoryID.result.FLDCATEGORY_ID;

                if (len(local.categoryID) NEQ 0) {
                    if (len(local.subCategoryID) NEQ 0) {
                        local.editProduct = local.objSave.editProduct(productName = productName, subcategoryID = local.subCategoryID, productDescription = productDescription, productBrand = productBrand, productPrice = productPrice, productImage = productImage, proId = proId);
                        if (local.editProduct.result) {
                            return {"result": true, "msg": "Edited Product #productName#"};
                        }
                    } else {
                        return serializeJSON({"result": "NoSubCategory", "msg": "SubCategory #subCategoryName# doesn't exist"});
                    }
                } else {
                    return serializeJSON({"result": "NoCategory", "msg": "Category #categoryName# doesn't exist"});
                }
            }
        } else {
            if (trim(len(categoryName)) EQ 0 OR trim(len(subCategoryName)) EQ 0 OR trim(len(productName)) EQ 0 OR trim(len(productDescription)) EQ 0 OR trim(len(productTax)) EQ 0) {
                local.error = 'Please fill all the fields';
                return {"result": false, "msg": local.error};
            } else {
                local.getSubCategoryID = local.objSave.getSubCategoryID(subCategoryName = subCategoryName);
                local.subCategoryID = local.getSubCategoryID.result.FLDSUBCATEGORY_ID;

                local.getCategoryID = local.objSave.getCategoryID(categoryName = categoryName);
                local.categoryID = local.getCategoryID.result.FLDCATEGORY_ID;

                if (len(local.categoryID) NEQ 0) {
                    if (len(local.subCategoryID) NEQ 0) {
                        local.editProduct = local.objSave.editProductWithOutImage(productName = productName, subcategoryID = local.subCategoryID, productDescription = productDescription, productBrand = productBrand, productPrice = productPrice, proId = proId ,productTax=productTax);
                        if (local.editProduct.result) {
                            return {"result": true, "msg": "Edited Product #productName#"};
                        }
                    } else {
                        return serializeJSON({"result": "NoSubCategory", "msg": "SubCategory #subCategoryName# doesn't exist"});
                    }
                } else {
                    return serializeJSON({"result": "NoCategory", "msg": "Category #categoryName# doesn't exist"});
                }
            }
        }
    }

    remote any function changeSubcategory(categoryName) returnFormat="JSON" {
        local.objSave = createObject("component", "models.savedetails");
        local.objGet = createObject("component", "models.getList");

        local.getCategoryID = local.objSave.getCategoryID(categoryName = categoryName);
        local.getSubcategory = local.objGet.getSubCategories(local.getCategoryID.result.FLDCATEGORY_ID);

        return local.getSubcategory;
    }

}
