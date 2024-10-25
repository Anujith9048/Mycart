component{
    remote any function addCategory(categoryName , type , id) returnFormat="JSON"{
        local.objSave = createObject("component", "models.savedetails");
        if(trim(len(categoryName)) EQ 0){
            local.error='Please fill the field';
            return {"result":false ,"msg":local.error};
        }
        else{
            if (type EQ 'category'){
                local.checkCategory=local.objSave.checkCategory(categoryName=categoryName);
                if(local.checkCategory.result.recordCount EQ 0){
                    local.addCategory=local.objSave.addCategory(categoryName=categoryName);
                    return {"result":true,"msg":"Added Category #categoryName#"};
                }
                else{
                    return {"result":false};
                }
            }
            else if(type EQ 'editCategory'){
                local.editCategory=local.objSave.editCategory(categoryName=categoryName , id=id);
                return {"result":true,"msg":"Editted Category #categoryName#"};
            }
            
        }

    }



    remote any function addSubCategory(categoryName,subCategoryName,type,id) returnFormat="JSON"{
        local.objSave = createObject("component", "models.savedetails");
        if(trim(len(categoryName)) EQ 0 OR trim(len(subCategoryName)) EQ 0){
            local.error='Please fill all the fields';
            return {"result":false ,"msg":local.error};
        }
        else{
            if (type EQ 'subcategory'){ 
                local.checkCategory=local.objSave.checkCategory(categoryName=categoryName);
                if(local.checkCategory.result.recordCount EQ 0){
                    local.addCategory=local.objSave.addCategory(categoryName=categoryName);
                    serializeJSON({"result":true,"msg":"Added Category #categoryName#"});
                }
                else{
                    local.getcategoryID=local.objSave.getCategoryID(categoryName=categoryName);
                    local.categoryID = local.getcategoryID.result.FLDCATEGORY_ID
                    if(local.categoryID){
                        local.addSubcategory=local.objSave.addSubcategory(subCategoryName=subCategoryName , categoryID=local.categoryID);

                        if(local.addSubcategory.result){
                            return{"result":true}
                        }
                    }
                    serializeJSON({"result":false});
                }
            }
            else if(type EQ 'editCategory'){
                local.editCategory=local.objSave.editCategory(categoryName=categoryName , id=id);
                return {"result":true,"msg":"Editted Category #categoryName#"};
            }
            
        }

    }
}