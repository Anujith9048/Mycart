<cfcomponent>

    <!--- Check category --->
  <cffunction name="checkCategory" access="remote" returnformat="JSON">
    <cfargument name="categoryName" type="string" >
    <cfquery name="checkCategoryList" datasource="sqlDatabase" result="checkResult">
      SELECT 1 FROM tblcategories 
      WHERE fldCategory_name = <cfqueryparam value="#trim(arguments.categoryName)#"  cfsqltype="cf_sql_varchar">;
    </cfquery>
    <cfreturn {"result":checkResult}>
  </cffunction>

<!--- Add Category --->
  <cffunction name="addCategory" access="remote" returnformat="JSON">
    <cfargument name="categoryName" type="string" >
        <cfset local.currentDate = dateFormat(now(),"yyyy-mm-dd")>
        <cfquery name="addCategoryList" datasource="sqlDatabase" result="addResult">
            INSERT INTO tblcategories (fldCategory_name,fldCreatedBy,fldCreatedDate)
            VALUES(
                <cfqueryparam value="#arguments.categoryName#"  cfsqltype="cf_sql_varchar">,
                <cfqueryparam value="#session.userID#"  cfsqltype="cf_sql_varchar">,
                <cfqueryparam value="#local.currentDate#"  cfsqltype="cf_sql_varchar">
            );
          </cfquery>
      <cfreturn {"result":true}>
  </cffunction>

  <!--- Edit Category --->
  <cffunction name="editCategory" access="remote" returnformat="JSON">
    <cfargument name="categoryName" type="string" >
    <cfargument name="id" type="string" >
        <cfset local.currentDate = dateFormat(now(),"yyyy-mm-dd")>
        <cfquery name="editCategoryList" datasource="sqlDatabase" result="editResult">
            UPDATE tblcategories
            SET fldCategory_name =  <cfqueryparam value="#arguments.categoryName#"  cfsqltype="cf_sql_varchar">,
                fldEditedBy =  <cfqueryparam value="#session.userId#"  cfsqltype="cf_sql_varchar">,
                fldEditedDate =  <cfqueryparam value="#local.currentDate#"  cfsqltype="cf_sql_varchar">
            WHERE fldCategory_ID =  <cfqueryparam value="#arguments.id#"  cfsqltype="cf_sql_varchar">;
          </cfquery>
      <cfreturn {"result":true}>
  </cffunction>

  <!--- Delete Categories --->
  <cffunction name="deleteCategories" access="remote" returnformat="JSON">
    <cfargument name="id" type="string" >
        <cfset local.currentDate = dateFormat(now(),"yyyy-mm-dd")>
        <cfquery name="editCategoryList" datasource="sqlDatabase" result="editResult">
            UPDATE tblcategories
            SET
                fldDeactivatedBy =  <cfqueryparam value="#session.userId#"  cfsqltype="cf_sql_varchar">,
                fldDeactivatedDate =  <cfqueryparam value="#local.currentDate#"  cfsqltype="cf_sql_varchar">,
                fldActive = <cfqueryparam value="0"  cfsqltype="cf_sql_varchar">
            WHERE fldCategory_ID =  <cfqueryparam value="#arguments.id#"  cfsqltype="cf_sql_varchar">;
        </cfquery>

        <cfquery name="editCategoryList" datasource="sqlDatabase" result="editResult">
          UPDATE tblsubcategories
          SET
              fldDeactivatedBy = <cfqueryparam value="#session.userId#" cfsqltype="cf_sql_varchar">,
              fldDeactivatedDate = <cfqueryparam value="#local.currentDate#" cfsqltype="cf_sql_varchar">,
              fldActive = <cfqueryparam value="0" cfsqltype="cf_sql_varchar">
          WHERE fldCategoryID = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_varchar">
        </cfquery>

        <cfquery name="updateProductList" datasource="sqlDatabase">
          UPDATE tblproducts
          SET fldActive = <cfqueryparam value="0" cfsqltype="cf_sql_varchar">
          WHERE fldSubcategoryID IN (
              SELECT fldSubcategory_ID
              FROM tblsubcategories
              WHERE fldCategoryID = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_varchar">
          )
        </cfquery>

      <cfreturn {"result":true}>
  </cffunction>

  <!---  getCategoryID --->
  <cffunction name="getCategoryID" access="remote" returnformat="JSON">
    <cfargument name="categoryName" type="string" >
    <cfquery name="checkCategoryList" datasource="sqlDatabase" result="id">
      SELECT fldCategory_ID FROM tblcategories 
      WHERE fldCategory_name = <cfqueryparam value="#arguments.categoryName#"  cfsqltype="cf_sql_varchar">;
    </cfquery>
    <cfreturn {"result":checkCategoryList}>
  </cffunction>

  <!--- Check SubCategory --->
  <cffunction name="checkSubCategory" access="remote" returnformat="JSON">
    <cfargument name="subCategoryName" type="string" >
    <cfargument name="id" type="string" >
    <cfquery name="checkCategoryList" datasource="sqlDatabase" result="checkResult">
      SELECT 1 FROM tblsubcategories
      WHERE fldSubcategoryName = <cfqueryparam value="#trim(arguments.subCategoryName)#"  cfsqltype="cf_sql_varchar">
      AND fldActive = <cfqueryparam value="1"  cfsqltype="cf_sql_varchar">
      AND fldCategoryID = <cfqueryparam value="#arguments.id#"  cfsqltype="cf_sql_varchar">;
    </cfquery>
    <cfreturn {"result":checkResult.recordCount}>
  </cffunction>

  <!--- Add SubCategory --->
  <cffunction name="addSubcategory" access="remote" returnformat="JSON">
    <cfargument name="subCategoryName" type="string" >
    <cfargument name="categoryID" type="string" >
        <cfset local.currentDate = dateFormat(now(),"yyyy-mm-dd")>
        <cfquery name="addCategoryList" datasource="sqlDatabase" result="addResult">
            INSERT INTO tblsubcategories (fldSubcategoryName,fldCreatedBy,fldCategoryID,fldCreatedDate)
            VALUES(
                <cfqueryparam value="#arguments.subCategoryName#"  cfsqltype="cf_sql_varchar">,
                <cfqueryparam value="#session.userID#"  cfsqltype="cf_sql_varchar">,
                <cfqueryparam value="#arguments.categoryID#"  cfsqltype="cf_sql_varchar">,
                <cfqueryparam value="#local.currentDate#"  cfsqltype="cf_sql_varchar">
            );
          </cfquery>
      <cfreturn {"result":true}>
  </cffunction>

  <!--- Edit SubCategory --->
  <cffunction name="editSubcategory" access="remote" returnformat="JSON">
    <cfargument name="subCategoryName" type="string" >
    <cfargument name="categoryID" type="any" >
    <cfargument name="id" type="any" >
        <cfset local.currentDate = dateFormat(now(),"yyyy-mm-dd")>
        <cfquery name="addCategoryList" datasource="sqlDatabase" result="addResult">
            UPDATE tblsubcategories
            SET fldSubcategoryName =  <cfqueryparam value="#arguments.subCategoryName#"  cfsqltype="cf_sql_varchar">,
                fldEditedBy =  <cfqueryparam value="#session.userId#"  cfsqltype="cf_sql_varchar">,
                fldEditedDate =  <cfqueryparam value="#local.currentDate#"  cfsqltype="cf_sql_varchar">,
                fldCategoryID = <cfqueryparam value="#arguments.categoryID#"  cfsqltype="cf_sql_varchar">
            WHERE fldSubcategory_ID =  <cfqueryparam value="#arguments.id#"  cfsqltype="cf_sql_varchar">;
          </cfquery>
      <cfreturn {"result":true}>
  </cffunction>

    <!--- Delete SubCategories --->
    <cffunction name="deleteSubCategories" access="remote" returnformat="JSON">
      <cfargument name="id" type="any" >
          <cfset local.currentDate = dateFormat(now(),"yyyy-mm-dd")>
          <cfquery name="deleteSubCategoryList" datasource="sqlDatabase" result="editResult">
            UPDATE tblsubcategories
            SET
              fldDeactivatedBy =  <cfqueryparam value="#session.userId#"  cfsqltype="cf_sql_varchar">,
              fldDeactivatedDate =  <cfqueryparam value="#local.currentDate#"  cfsqltype="cf_sql_varchar">,
              fldActive = <cfqueryparam value="0"  cfsqltype="cf_sql_varchar">
            WHERE fldSubcategory_ID =  <cfqueryparam value="#arguments.id#"  cfsqltype="cf_sql_varchar">;
          </cfquery>

          <cfquery name="deleteSubCategoryProduct" datasource="sqlDatabase" result="editResult">
            UPDATE tblproducts
            SET
              fldDeactivatedBy =  <cfqueryparam value="#session.userId#"  cfsqltype="cf_sql_varchar">,
              fldDeactivatedDate =  <cfqueryparam value="#local.currentDate#"  cfsqltype="cf_sql_varchar">,
              fldActive = <cfqueryparam value="0"  cfsqltype="cf_sql_varchar">
            WHERE fldSubcategory_ID =  <cfqueryparam value="#arguments.id#"  cfsqltype="cf_sql_varchar">;
          </cfquery>
        <cfreturn {"result":true}>
    </cffunction>

    <!--- Check getSubCategoryID --->
  <cffunction name="getSubCategoryID" access="remote" returnformat="JSON">
    <cfargument name="subCategoryName" type="string" >
    <cfquery name="checkSubCategoryList" datasource="sqlDatabase" result="id">
      SELECT fldSubcategory_ID FROM tblsubcategories 
      WHERE fldSubcategoryName = <cfqueryparam value="#arguments.subCategoryName#"  cfsqltype="cf_sql_varchar">
      AND fldActive = <cfqueryparam value="1"  cfsqltype="cf_sql_varchar">;
    </cfquery>
    <cfreturn {"result":checkSubCategoryList}>
  </cffunction>

   <!--- Valid subcategory --->
   <cffunction name="validSubcategory" access="remote" returnformat="JSON">
    <cfargument name="categoryId" type="string" >
    <cfargument name="subid" type="string" >
    <cfquery name="checkSubCategoryList" datasource="sqlDatabase" result="id">
      SELECT fldSubcategoryName FROM tblsubcategories 
      WHERE fldCategoryID = <cfqueryparam value="#arguments.categoryId#"  cfsqltype="cf_sql_varchar">
      AND fldSubcategoryName = <cfqueryparam value="#trim(arguments.subid)#"  cfsqltype="cf_sql_varchar">;
    </cfquery>
    <cfreturn {"result":id}>
  </cffunction>

    <!--- Check Product --->
  <cffunction name="checkProduct" access="remote" returnformat="JSON">
    <cfargument name="productName" type="string" >
    <cfargument name="productBrand" type="string" >
    <cfargument name="subid" type="any" >
    <cfquery name="checkCategoryList" datasource="sqlDatabase" result="checkResult">
      SELECT 1 FROM tblproducts
      WHERE fldProductName = <cfqueryparam value="#arguments.productName#"  cfsqltype="cf_sql_varchar">
      AND fldActive = <cfqueryparam value="1"  cfsqltype="cf_sql_varchar">
      AND fldBrandName = <cfqueryparam value="#productBrand#"  cfsqltype="cf_sql_varchar">
      AND fldSubcategoryID = <cfqueryparam value="#arguments.subid#"  cfsqltype="cf_sql_varchar">;
    </cfquery>
    <cfreturn {"result":checkResult.recordCount}>
  </cffunction>

   <!--- Add Product --->
  <cffunction name="addProduct" access="remote" returnformat="JSON">
    <cfargument name="ProductName" type="string" >
    <cfargument name="subcategoryID" type="string" >
    <cfargument name="ProductDescription" type="string" >
    <cfargument name="ProductBrand" type="string" >
    <cfargument name="ProductPrice" type="string" >
    <cfargument name="ProductImage" type="string" >

    <cffile action="upload"
            filefield="ProductImage"
            destination="#expandPath('../assets/productImage/')#"
            accept="image/*"
            nameconflict="makeUnique">
    <cfset local.uploadedFile = cffile.serverFile>

        <cfset local.currentDate = dateFormat(now(),"yyyy-mm-dd")>
        <cfquery name="addCategoryList" datasource="sqlDatabase" result="addResult">
            INSERT INTO tblproducts (fldSubcategoryID,fldProductName,fldProductDescription,fldProductPrice,fldCreatedBy,fldCreatedDate,fldBrandName,fldProductImage)
            VALUES(
                <cfqueryparam value="#arguments.subcategoryID#"  cfsqltype="cf_sql_varchar">,
                <cfqueryparam value="#arguments.ProductName#"  cfsqltype="cf_sql_varchar">,
                <cfqueryparam value="#arguments.ProductDescription#"  cfsqltype="cf_sql_varchar">,
                <cfqueryparam value="#arguments.ProductPrice#"  cfsqltype="cf_sql_varchar">,
                <cfqueryparam value="#session.userID#"  cfsqltype="cf_sql_varchar">,
                <cfqueryparam value="#local.currentDate#"  cfsqltype="cf_sql_varchar">,
                <cfqueryparam value="#arguments.ProductBrand#"  cfsqltype="cf_sql_varchar">,
                <cfqueryparam value="#local.uploadedFile#"  cfsqltype="cf_sql_varchar">
            );
          </cfquery>
      <cfreturn {"result":true}>
  </cffunction>

  <!--- Edit Product --->
  <cffunction name="editProduct" access="remote" returnformat="JSON">
    <cfargument name="ProductName" type="string" >
    <cfargument name="subcategoryID" type="string" >
    <cfargument name="ProductDescription" type="string" >
    <cfargument name="ProductBrand" type="string" >
    <cfargument name="ProductPrice" type="string" >
    <cfargument name="ProductImage" type="string" >
    <cfargument name="proId" type="any" >

    <cffile action="upload"
            filefield="ProductImage"
            destination="#expandPath('../assets/productImage/')#"
            accept="image/*"
            nameconflict="makeUnique">
    <cfset local.uploadedFile = cffile.serverFile>

        <cfset local.currentDate = dateFormat(now(),"yyyy-mm-dd")>
        <cfquery name="editCategoryList" datasource="sqlDatabase" result="addResult">
            UPDATE tblproducts
            SET fldProductName =  <cfqueryparam value="#arguments.ProductName#"  cfsqltype="cf_sql_varchar">,
                fldEditedBy =  <cfqueryparam value="#session.userId#"  cfsqltype="cf_sql_varchar">,
                fldEditedDate =  <cfqueryparam value="#local.currentDate#"  cfsqltype="cf_sql_varchar">,
                fldProductDescription = <cfqueryparam value="#arguments.ProductDescription#"  cfsqltype="cf_sql_varchar">,
                fldProductPrice = <cfqueryparam value="#arguments.ProductPrice#"  cfsqltype="cf_sql_varchar">,
                fldBrandName = <cfqueryparam value="#arguments.ProductBrand#"  cfsqltype="cf_sql_varchar">,
                fldProductImage = <cfqueryparam value="#local.uploadedFile#"  cfsqltype="cf_sql_varchar">,
                fldSubcategoryID = <cfqueryparam value="#arguments.subcategoryID#"  cfsqltype="cf_sql_varchar">
            WHERE fldProduct_ID =  <cfqueryparam value="#arguments.proId#"  cfsqltype="cf_sql_varchar">;
          </cfquery>
      <cfreturn {"result":true}>
  </cffunction>


  <!--- Edit Product --->
  <cffunction name="editProductWithOutImage" access="remote" returnformat="JSON">
    <cfargument name="ProductName" type="string" >
    <cfargument name="subcategoryID" type="string" >
    <cfargument name="ProductDescription" type="string" >
    <cfargument name="ProductBrand" type="string" >
    <cfargument name="ProductPrice" type="string" >
    <cfargument name="proId" type="any" >

        <cfset local.currentDate = dateFormat(now(),"yyyy-mm-dd")>
        <cfquery name="editCategoryList" datasource="sqlDatabase" result="addResult">
            UPDATE tblproducts
            SET fldProductName =  <cfqueryparam value="#arguments.ProductName#"  cfsqltype="cf_sql_varchar">,
                fldEditedBy =  <cfqueryparam value="#session.userId#"  cfsqltype="cf_sql_varchar">,
                fldEditedDate =  <cfqueryparam value="#local.currentDate#"  cfsqltype="cf_sql_varchar">,
                fldProductDescription = <cfqueryparam value="#arguments.ProductDescription#"  cfsqltype="cf_sql_varchar">,
                fldProductPrice = <cfqueryparam value="#arguments.ProductPrice#"  cfsqltype="cf_sql_varchar">,
                fldBrandName = <cfqueryparam value="#arguments.ProductBrand#"  cfsqltype="cf_sql_varchar">,
                fldSubcategoryID = <cfqueryparam value="#arguments.subcategoryID#"  cfsqltype="cf_sql_varchar">
            WHERE fldProduct_ID =  <cfqueryparam value="#arguments.proId#"  cfsqltype="cf_sql_varchar">;
          </cfquery>
      <cfreturn {"result":true}>
  </cffunction>

   <!--- Delete Product --->
   <cffunction name="deleteProduct" access="remote" returnformat="JSON">
    <cfargument name="id" type="any" >
    <cfargument name="subId" type="any" >
        <cfset local.currentDate = dateFormat(now(),"yyyy-mm-dd")>
        <cfquery name="deleteSubCategoryList" datasource="sqlDatabase" result="editResult">
          UPDATE tblproducts
          SET
            fldDeactivatedBy =  <cfqueryparam value="#session.userId#"  cfsqltype="cf_sql_varchar">,
            fldDeactivatedDate =  <cfqueryparam value="#local.currentDate#"  cfsqltype="cf_sql_varchar">,
            fldActive = <cfqueryparam value="0"  cfsqltype="cf_sql_varchar">
          WHERE fldProduct_ID =  <cfqueryparam value="#arguments.id#"  cfsqltype="cf_sql_varchar">
          AND fldSubcategoryID = <cfqueryparam value="#arguments.subId#"  cfsqltype="cf_sql_varchar">;
        </cfquery>
      <cfreturn {"result":true}>
  </cffunction>

  <!--- Add Cart --->
  <cffunction name="addCart" access="remote" returnformat="JSON">
    <cfargument name="proid" type="any" >
    <cfset local.currentDate = dateFormat(now(),"yyyy-mm-dd")>

    <cfquery name="checkCart" datasource="sqlDatabase" result="checkResult">
      SELECT 1 FROM tblcart
      WHERE fldProductID = <cfqueryparam value="#arguments.proid#"  cfsqltype="cf_sql_varchar">
      AND fldActive = <cfqueryparam value="1"  cfsqltype="cf_sql_varchar">;
    </cfquery>
    
      <cfif checkResult.recordCount>
        <cfreturn {"result":false}>
        <cfelse>
          <cfif session.isLog>
            <cfquery name="addCart" datasource="sqlDatabase" result="addResult">
              INSERT INTO tblcart (fldUserID,fldCartDate,fldProductID)
              VALUES(
                  <cfqueryparam value="#session.userId#"  cfsqltype="cf_sql_varchar">,
                  <cfqueryparam value="#local.currentDate#"  cfsqltype="cf_sql_varchar">,
                  <cfqueryparam value="#arguments.proid#"  cfsqltype="cf_sql_varchar">
              );
            </cfquery>
            <cfreturn {"result":true}>

            <cfelse>
              <cfreturn {"result":"login"}>
          </cfif>
      </cfif>
  </cffunction>

  <!--- Remove Cart --->
  <cffunction name="removeCart" access="remote" returnformat="JSON">
    <cfargument name="proid" type="any" >
        <cfset local.currentDate = dateFormat(now(),"yyyy-mm-dd")>
        <cfquery name="deleteSubCategoryList" datasource="sqlDatabase" result="editResult">
          UPDATE tblcart
          SET
            fldRemoveDate =  <cfqueryparam value="#local.currentDate#"  cfsqltype="cf_sql_varchar">,
            fldActive = <cfqueryparam value="0"  cfsqltype="cf_sql_varchar">
          WHERE fldProductID =  <cfqueryparam value="#arguments.proid#"  cfsqltype="cf_sql_varchar">;
        </cfquery>
      <cfreturn {"result":true}>
  </cffunction>

<!---  addQuantity  --->
  <cffunction name="addQuantity" access="remote" returnformat="JSON">
    <cfargument name="id" type="any" >
    <cfargument name="type" type="string" >
        <cfset local.currentDate = dateFormat(now(),"yyyy-mm-dd")>
        <cfif arguments.type EQ 'increase'>
          <cfquery name="addQuantity" datasource="sqlDatabase" result="editResult">
            UPDATE tblcart
            SET
              fldQuantity =  fldQuantity + 1
              WHERE fldProductID =  <cfqueryparam value="#arguments.id#"  cfsqltype="cf_sql_varchar">;
          </cfquery>

          <cfelse>
          <cfquery name="addQuantity" datasource="sqlDatabase" result="editResult">
            UPDATE tblcart
            SET
              fldQuantity =  fldQuantity - 1
              WHERE fldProductID =  <cfqueryparam value="#arguments.id#"  cfsqltype="cf_sql_varchar">;
          </cfquery>
        </cfif>
      <cfreturn {"result":true}>
  </cffunction>

  <!---  addAddress  --->
  <cffunction name="addAddress" access="remote" returnformat="JSON">
    <cfargument name="name" type="string" >
    <cfargument name="phone" type="string" >
    <cfargument name="pincode" type="string" >
    <cfargument name="state" type="string" >
    <cfargument name="city" type="string" >
    <cfargument name="building" type="string" >
    <cfargument name="area" type="string" >
    <cfset local.currentDate = dateFormat(now(),"yyyy-mm-dd")>
    
    <cfquery name="addAddress" datasource="sqlDatabase" result="addressResult">
      INSERT INTO tblsavedaddress (fldAddressUserID,fldFullname,fldPhone,fldPincode,fldState,fldCity,fldBuildingName,fldArea,fldAddedDate)
      VALUES(
          <cfqueryparam value="#session.userId#"  cfsqltype="cf_sql_varchar">,
          <cfqueryparam value="#arguments.name#"  cfsqltype="cf_sql_varchar">,
          <cfqueryparam value="#arguments.phone#"  cfsqltype="cf_sql_varchar">,
          <cfqueryparam value="#arguments.pincode#"  cfsqltype="cf_sql_varchar">,
          <cfqueryparam value="#arguments.state#"  cfsqltype="cf_sql_varchar">,
          <cfqueryparam value="#arguments.city#"  cfsqltype="cf_sql_varchar">,
          <cfqueryparam value="#arguments.building#"  cfsqltype="cf_sql_varchar">,
          <cfqueryparam value="#arguments.area#"  cfsqltype="cf_sql_varchar">,
          <cfqueryparam value="#local.currentDate#"  cfsqltype="cf_sql_varchar">
      );
    </cfquery>
    <cfset local.id = addressResult.generatedKey>
    <cfreturn {"result":true,"id":local.id}>
  </cffunction>

    <!---  Order Product  --->
    <cffunction name="orderProduct" access="remote" returnformat="JSON">
      <cfargument name="cardnumber" type="any" >
      <cfargument name="cvv" type="any" >
      <cfargument name="addressId" type="any" >
      <cfargument name="proid" type="any" >
      <cfargument name="quantity" type="any" >
      <cfargument name="price" type="any" >
      <cfset local.currentDate = dateFormat(now(),"yyyy-mm-dd")>
      
      <cfquery name="addAddress" datasource="sqlDatabase" result="orderId">
        INSERT INTO tblorder (fldUserID,fldOrderDate,fldShippingAddress)
        VALUES(
            <cfqueryparam value="#session.userId#"  cfsqltype="cf_sql_varchar">,
            <cfqueryparam value="#local.currentDate#"  cfsqltype="cf_sql_varchar">,
            <cfqueryparam value="#arguments.addressId#"  cfsqltype="cf_sql_varchar">
        );
      </cfquery>
      <cfset local.id = orderId.generatedKey>

      <cfquery name="addAddress" datasource="sqlDatabase" result="orderResult">
        INSERT INTO tblorderproducts (fldOrderID,fldProduct,fldProductQuantity,fldOrderDate,fldProductPrice)
        VALUES(
            <cfqueryparam value="#local.id#"  cfsqltype="cf_sql_varchar">,
            <cfqueryparam value="#arguments.proid#"  cfsqltype="cf_sql_varchar">,
            <cfqueryparam value="#arguments.quantity#"  cfsqltype="cf_sql_varchar">,
            <cfqueryparam value="#local.currentDate#"  cfsqltype="cf_sql_varchar">,
            <cfqueryparam value="#arguments.price#"  cfsqltype="cf_sql_varchar">
        );
      </cfquery>
      <cfreturn {"result":true,"orderid":local.id}>
    </cffunction>

     <!---  Order Cart Product  --->
     <cffunction name="orderCartProduct" access="remote" returnformat="JSON">
      <cfargument name="addressId" type="any" >
      <cfset local.currentDate = dateFormat(now(),"yyyy-mm-dd")>
      
      <cfquery name="addAddress" datasource="sqlDatabase" result="orderId">
        INSERT INTO tblorder (fldUserID,fldOrderDate,fldShippingAddress)
        VALUES(
            <cfqueryparam value="#session.userId#"  cfsqltype="cf_sql_varchar">,
            <cfqueryparam value="#local.currentDate#"  cfsqltype="cf_sql_varchar">,
            <cfqueryparam value="#arguments.addressId#"  cfsqltype="cf_sql_varchar">
        );
      </cfquery>
      <cfset local.id = orderId.generatedKey>

      
      <cfset local.getlistObj = createObject("component", "models.getlist")>
      <cfset local.cartList = local.getlistObj.getCart(session.userId)>
      <cfloop query="local.cartList.cartItems">
      <cfquery name="addAddress" datasource="sqlDatabase" result="orderResult">
        INSERT INTO tblorderproducts (fldOrderID,fldProduct,fldProductQuantity,fldOrderDate,fldProductPrice)
        VALUES(
            <cfqueryparam value="#local.id#"  cfsqltype="cf_sql_varchar">,
            <cfqueryparam value="#FLDPRODUCT_ID#"  cfsqltype="cf_sql_varchar">,
            <cfqueryparam value="#FLDQUANTITY#"  cfsqltype="cf_sql_varchar">,
            <cfqueryparam value="#local.currentDate#"  cfsqltype="cf_sql_varchar">,
            <cfqueryparam value="#FLDPRODUCTPRICE#"  cfsqltype="cf_sql_varchar">
        );
      </cfquery>
      </cfloop>
      <cfreturn {"result":true,"orderid":local.id}>
    </cffunction>
</cfcomponent>
