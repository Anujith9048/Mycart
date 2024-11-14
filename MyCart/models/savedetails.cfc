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
    <cfargument name="ProductName" type="string">
    <cfargument name="subcategoryID" type="string">
    <cfargument name="ProductDescription" type="string">
    <cfargument name="ProductBrand" type="string">
    <cfargument name="ProductPrice" type="string">
    <cfargument name="ProductImages" type="any"> 
    <cfargument name="productTax" type="any" default=1>
    <cfset local.currentDate = dateFormat(now(), "yyyy-mm-dd")>
    
    <cfquery name="addCategoryList" datasource="sqlDatabase" result="addResult">
        INSERT INTO tblproducts (fldSubcategoryID, fldProductName, fldProductDescription, fldProductPrice, fldCreatedBy, fldCreatedDate, fldBrandName, fldProductTax)
        VALUES (
            <cfqueryparam value="#arguments.subcategoryID#" cfsqltype="cf_sql_varchar">,
            <cfqueryparam value="#arguments.ProductName#" cfsqltype="cf_sql_varchar">,
            <cfqueryparam value="#arguments.ProductDescription#" cfsqltype="cf_sql_varchar">,
            <cfqueryparam value="#arguments.ProductPrice#" cfsqltype="cf_sql_varchar">,
            <cfqueryparam value="#session.userID#" cfsqltype="cf_sql_varchar">,
            <cfqueryparam value="#local.currentDate#" cfsqltype="cf_sql_varchar">,
            <cfqueryparam value="#arguments.ProductBrand#" cfsqltype="cf_sql_varchar">,
            <cfqueryparam value="#arguments.productTax#" cfsqltype="cf_sql_varchar">
        );
    </cfquery>
    <cfset local.productID = addResult.generatedKey>

        <cffile action="uploadall"
                filefield="ProductImages"
                destination="#expandPath('../assets/productImage/')#"
                accept="image/*"
                nameconflict="makeUnique">
        <cfset local.uploadedFiles = cffile.UPLOADALLRESULTS>

        <cfloop array="#local.uploadedFiles#" index="files">
          <cfquery name="insertImages" datasource="sqlDatabase">
              INSERT INTO tblproductimages (fldproduct_id, fldimagename)
              VALUES (
                  <cfqueryparam value="#local.productID#" cfsqltype="cf_sql_integer">,
                  <cfqueryparam value="#files.SERVERFILE#" cfsqltype="cf_sql_varchar">
              )
          </cfquery>
        </cfloop>
        

    <cfreturn {"result": true}>
</cffunction>



  <!--- Edit Product With image --->
  <cffunction name="editProduct" access="remote" returnformat="JSON">
    <cfargument name="ProductName" type="string">
    <cfargument name="subcategoryID" type="string">
    <cfargument name="ProductDescription" type="string">
    <cfargument name="ProductBrand" type="string">
    <cfargument name="ProductPrice" type="string">
    <cfargument name="ProductImage" type="array">
    <cfargument name="proId" type="any">
    <cfargument name="productTax" type="any" default=1>

    <cfset local.currentDate = dateFormat(now(), "yyyy-mm-dd")>
    <cfquery name="editCategoryList" datasource="sqlDatabase">
        UPDATE tblproducts
        SET 
            fldProductName = <cfqueryparam value="#arguments.ProductName#" cfsqltype="cf_sql_varchar">,
            fldEditedBy = <cfqueryparam value="#session.userId#" cfsqltype="cf_sql_varchar">,
            fldEditedDate = <cfqueryparam value="#local.currentDate#" cfsqltype="cf_sql_varchar">,
            fldProductDescription = <cfqueryparam value="#arguments.ProductDescription#" cfsqltype="cf_sql_varchar">,
            fldProductPrice = <cfqueryparam value="#arguments.ProductPrice#" cfsqltype="cf_sql_varchar">,
            fldBrandName = <cfqueryparam value="#arguments.ProductBrand#" cfsqltype="cf_sql_varchar">,
            fldSubcategoryID = <cfqueryparam value="#arguments.subcategoryID#" cfsqltype="cf_sql_varchar">,
            fldProductTax = <cfqueryparam value="#arguments.productTax#" cfsqltype="cf_sql_varchar">
        WHERE fldProduct_ID = <cfqueryparam value="#arguments.proId#" cfsqltype="cf_sql_varchar">;
    </cfquery>

    <!--- <cfquery name="deleteOldImages" datasource="sqlDatabase">
       UPDATE tblproductimages
       set fldActive=<cfqueryparam value="0" cfsqltype="cf_sql_bit">
       WHERE fldproduct_id=<cfqueryparam value="#arguments.proId#" cfsqltype="cf_sql_integer">;
    </cfquery> --->

        <cffile action="uploadall"
                filefield="ProductImages"
                destination="#expandPath('../assets/productImage/')#"
                accept="image/*"
                nameconflict="makeUnique">
        <cfset local.uploadedFiles = cffile.UPLOADALLRESULTS>

        <cfloop array="#local.uploadedFiles#" index="files">
          <cfquery name="insertImages" datasource="sqlDatabase">
              INSERT INTO  tblproductimages (fldimagename,fldEdittedBy,fldEdittedDate,fldproduct_id)
              VALUES(
                <cfqueryparam value="#files.SERVERFILE#" cfsqltype="cf_sql_varchar">,
                <cfqueryparam value="#session.userId#" cfsqltype="cf_sql_integer">,
                <cfqueryparam value="#CreateODBCDate(local.currentDate)#" cfsqltype="cf_sql_date">,
                <cfqueryparam value="#arguments.proId#" cfsqltype="cf_sql_integer">
              );
          </cfquery>
        </cfloop>
    <cfreturn {"result": true}>
  </cffunction>

  <cffunction name="deleteProductimage" access="remote" returnformat="JSON">
    <cfargument name="imageid" type="any">
    <cfquery name="deleteOldImages" datasource="sqlDatabase">
      UPDATE tblproductimages
      set fldActive=<cfqueryparam value="0" cfsqltype="cf_sql_bit">
      WHERE fldimageID=<cfqueryparam value="#arguments.imageid#" cfsqltype="cf_sql_integer">;
   </cfquery>
   <cfreturn {"result": true}>
  </cffunction>

  <!--- Edit Product WithOut image --->
  <cffunction name="editProductWithOutImage" access="remote" returnformat="JSON">
    <cfargument name="ProductName" type="string" >
    <cfargument name="subcategoryID" type="string" >
    <cfargument name="ProductDescription" type="string" >
    <cfargument name="ProductBrand" type="string" >
    <cfargument name="ProductPrice" type="string" >
    <cfargument name="proId" type="any" >
    <cfargument name="productTax" type="any" default=1>

        <cfset local.currentDate = dateFormat(now(),"yyyy-mm-dd")>
        <cfquery name="editCategoryList" datasource="sqlDatabase" result="addResult">
            UPDATE tblproducts
            SET fldProductName =  <cfqueryparam value="#arguments.ProductName#"  cfsqltype="cf_sql_varchar">,
                fldEditedBy =  <cfqueryparam value="#session.userId#"  cfsqltype="cf_sql_varchar">,
                fldEditedDate =  <cfqueryparam value="#local.currentDate#"  cfsqltype="cf_sql_varchar">,
                fldProductDescription = <cfqueryparam value="#arguments.ProductDescription#"  cfsqltype="cf_sql_varchar">,
                fldProductPrice = <cfqueryparam value="#arguments.ProductPrice#"  cfsqltype="cf_sql_varchar">,
                fldBrandName = <cfqueryparam value="#arguments.ProductBrand#"  cfsqltype="cf_sql_varchar">,
                fldSubcategoryID = <cfqueryparam value="#arguments.subcategoryID#"  cfsqltype="cf_sql_varchar">,
                fldProductTax = <cfqueryparam value="#arguments.productTax#"  cfsqltype="cf_sql_varchar">
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

        <cfquery name="deleteImages" datasource="sqlDatabase" result="editResult">
          UPDATE tblproductimages
          SET
            fldActive = <cfqueryparam value="0"  cfsqltype="cf_sql_varchar">
            WHERE fldproduct_id =  <cfqueryparam value="#arguments.id#"  cfsqltype="cf_sql_varchar">;
        </cfquery>
      <cfreturn {"result":true}>
  </cffunction>

  <!--- Add Cart --->
  <cffunction name="addCart" access="remote" returnformat="JSON">
    <cfargument name="proid" type="any" >
    <cfset local.currentDate = dateFormat(now(),"yyyy-mm-dd")>

    <cfif session.isLog>
      <cfquery name="checkCart" datasource="sqlDatabase" result="checkResult">
        SELECT 1 FROM tblcart
        WHERE fldProductID = <cfqueryparam value="#arguments.proid#"  cfsqltype="cf_sql_varchar">
        AND fldActive = <cfqueryparam value="1"  cfsqltype="cf_sql_varchar">
        AND fldUserID = <cfqueryparam value="#session.userId#"  cfsqltype="cf_sql_varchar">;
      </cfquery>
    
      <cfif checkResult.recordCount>
        <cfquery datasource="sqlDatabase">
          UPDATE tblcart
          SET fldQuantity =  fldQuantity + 1
          WHERE fldProductID =  <cfqueryparam value="#arguments.proid#"  cfsqltype="cf_sql_varchar">;
        </cfquery>
            <cfreturn {"result":false,'status':"edit"}>
        <cfelse>
          <cfquery name="addCart" datasource="sqlDatabase" result="addResult">
            INSERT INTO tblcart (fldUserID,fldCartDate,fldProductID)
            VALUES(
                <cfqueryparam value="#session.userId#"  cfsqltype="cf_sql_varchar">,
                <cfqueryparam value="#local.currentDate#"  cfsqltype="cf_sql_varchar">,
                <cfqueryparam value="#arguments.proid#"  cfsqltype="cf_sql_varchar">
            );
          </cfquery>
          <cfreturn {"result":true}>
      </cfif>
    <cfelse>
      <cfreturn {"result":"login"}>
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
      <cfargument name="addressId" type="any" >
      <cfargument name="proid" type="any" >
      <cfargument name="quantity" type="any" >
      <cfargument name="price" type="any" >
      <cfset local.currentDate = dateFormat(now(),"yyyy-mm-dd")>
        
      <cfset local.id = createuuid()>
      
      <cfquery name="addAddress" datasource="sqlDatabase" result="orderId">
        INSERT INTO tblorder (fldOrder_ID,fldUserID,fldOrderDate,fldShippingAddress)
        VALUES(
          <cfqueryparam value="#local.id#"  cfsqltype="cf_sql_varchar">,
          <cfqueryparam value="#session.userId#"  cfsqltype="cf_sql_varchar">,
          <cfqueryparam value="#local.currentDate#"  cfsqltype="cf_sql_varchar">,
          <cfqueryparam value="#arguments.addressId#"  cfsqltype="cf_sql_varchar">
        );
      </cfquery>

      <cfquery name="getTax" datasource="sqlDatabase" result="productTax">
        SELECT fldProductTax FROM tblproducts
        WHERE fldProduct_ID = <cfqueryparam value="#proid#" cfsqltype="cf_sql_varchar">;
      </cfquery>
      
      <cfquery name="addAddress" datasource="sqlDatabase" result="orderResult">
        INSERT INTO tblorderproducts (fldOrderID,fldProduct,fldProductQuantity,fldOrderDate,fldProductPrice,fldProductTax)
        VALUES(
            <cfqueryparam value="#local.id#"  cfsqltype="cf_sql_varchar">,
            <cfqueryparam value="#arguments.proid#"  cfsqltype="cf_sql_varchar">,
            <cfqueryparam value="#arguments.quantity#"  cfsqltype="cf_sql_varchar">,
            <cfqueryparam value="#local.currentDate#"  cfsqltype="cf_sql_varchar">,
            <cfqueryparam value="#arguments.price#"  cfsqltype="cf_sql_varchar">,
            <cfqueryparam value="#getTax.fldProductTax#"  cfsqltype="cf_sql_varchar">
        );
      </cfquery>
      <cfset local.productslist=application.getlistObj.getSingleProduct(arguments.proid)>
      <cfset local.product = local.productslist.product>
      <cfset local.userDetails = application.getlistObj.getUserDetails()>
      <cfset local.address = application.getlistObj.getselectedAddress(arguments.addressId)>
      <cfmail from="mycart@gmail.com"
        subject="Your Booking is Confirmed!"  
        to="#local.userDetails.data.fldemail#"
        server="smtp.gmail.com"
        port="25">
        Dear #session.username#,
          Thank you for shopping with us! 
          We’re excited to let you know that we’ve received your order. 
          Below are the details of your purchase:
          
          Product Name : #local.product.FLDPRODUCTNAME#
          Brand : #local.product.FLDBRANDNAME#
          Price : Rs.#local.product.FLDPRODUCTPRICE#/-
          Order ID: #local.id#
          Order Date: #local.currentDate#
          Shipping Address:
          #local.address.result.FLDBUILDINGNAME# #local.address.result.FLDAREA#, #local.address.result.FLDCITY#, #local.address.result.FLDSTATE# #local.address.result.FLDPINCODE#
          Contact Details:
          Name:#local.address.result.FLDFULLNAME#
          Phone:#local.address.result.FLDPHONE#
      </cfmail>
      <cfreturn {"result":true,"orderid":local.id}>
  </cffunction>

  <!---  Order Cart Product  --->
  <cffunction name="orderCartProduct" access="remote" returnformat="JSON">
      <cfargument name="addressId" type="any" >
      <cfset local.currentDate = dateFormat(now(),"yyyy-mm-dd")>
      <cfset local.id = createuuid()>
      
      <cfquery name="addAddress" datasource="sqlDatabase" result="orderId">
        INSERT INTO tblorder (fldOrder_ID,fldUserID,fldOrderDate,fldShippingAddress)
        VALUES(
            <cfqueryparam value="#local.id#"  cfsqltype="cf_sql_varchar">,
            <cfqueryparam value="#session.userId#"  cfsqltype="cf_sql_varchar">,
            <cfqueryparam value="#local.currentDate#"  cfsqltype="cf_sql_varchar">,
            <cfqueryparam value="#arguments.addressId#"  cfsqltype="cf_sql_varchar">
        );
      </cfquery>

      
      <cfset local.cartList = application.getlistObj.getCart(session.userId)>
      
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

      <cfset local.userDetails = application.getlistObj.getUserDetails()>
      <cfset local.address = application.getlistObj.getselectedAddress(arguments.addressId)>

      <cfmail from="mycart@gmail.com"
        subject="Your Booking is Confirmed!"  
        to="#local.userDetails.data.fldemail#"
        server="smtp.gmail.com"
        port="25">
        Dear #session.username#,
          Thank you for shopping with us! 
          We’re excited to let you know that we’ve received your order. 
          Below are the details of your purchase:
          <cfloop query="local.cartList.cartItems">
            <cfset local.productslist=application.getlistObj.getSingleProduct(FLDPRODUCT_ID)>
            <cfset local.product = local.productslist.product>
            Product Name : #local.product.FLDPRODUCTNAME#
            Brand : #local.product.FLDBRANDNAME#
            Price : Rs.#local.product.FLDPRODUCTPRICE#/-
            Order ID: #local.id#
            Order Date: #local.currentDate#
            Shipping Address:
            #local.address.result.FLDBUILDINGNAME# #local.address.result.FLDAREA#, #local.address.result.FLDCITY#, #local.address.result.FLDSTATE# #local.address.result.FLDPINCODE#
            Contact Details:
            Name:#local.address.result.FLDFULLNAME#
            Phone:#local.address.result.FLDPHONE#

          </cfloop>
      </cfmail>


      <cfset local.saveObj = createObject("component", "models.saveDetails")>
      <cfset local.removeCart = local.saveObj.removeCartProduct()>
      <cfif local.removeCart.result>
      <cfreturn {"result":true,"orderid":local.id}>
      </cfif>
  </cffunction>

  <!--- Remove Cart Product --->
  <cffunction name="removeCartProduct" access="remote" returnformat="JSON">
        <cfset local.currentDate = dateFormat(now(),"yyyy-mm-dd")>
        <cfquery name="removeCartProduct" datasource="sqlDatabase">
          UPDATE tblcart
          SET
            fldRemoveDate =  <cfqueryparam value="#local.currentDate#"  cfsqltype="cf_sql_varchar">,
            fldActive = <cfqueryparam value="0"  cfsqltype="cf_sql_varchar">
          WHERE fldUserID =  <cfqueryparam value="#session.userId#"  cfsqltype="cf_sql_varchar">;
        </cfquery>
      <cfreturn {"result":true}>
  </cffunction>

  <!--- Filter Sort --->
  <cffunction name="filterSort" access="remote" returnformat="json">
    <cfargument name="checkedValues" type="string" required="true">
    <cfargument name="subid" type="any">
    <cfset local.priceRanges = deserializeJSON(arguments.checkedValues)>
    <cfset local.conditions = []>
    <cfset local.params = {}>

    <cfloop array="#local.priceRanges#" index="range">
        <cfif range eq "0to1000">
            <cfset arrayAppend(local.conditions, "fldProductPrice BETWEEN 0 AND 1000")>
        <cfelseif range eq "1000to10000">
            <cfset arrayAppend(local.conditions, "fldProductPrice BETWEEN 1000 AND 10000")>
        <cfelseif range eq "10000to15000">
            <cfset arrayAppend(local.conditions, "fldProductPrice BETWEEN 10000 AND 15000")>
        <cfelseif range eq "15000to25000">
            <cfset arrayAppend(local.conditions, "fldProductPrice BETWEEN 15000 AND 25000")>
        <cfelseif range eq "25000above">
            <cfset arrayAppend(local.conditions, "fldProductPrice >= 25000")>
        </cfif>
    </cfloop>

    <cfset local.whereClause = arrayLen(local.conditions) ? arrayToList(local.conditions, " OR ") : "">
    <cfquery name="filteredProducts" datasource="sqlDatabase">
        SELECT p.fldProduct_ID, p.fldProductName, ROUND((p.fldProductTax / 100) *p.fldProductPrice +p.fldProductPrice, 2) AS fldProductPrice, p.fldBrandName,
          GROUP_CONCAT(pi.fldimagename) AS fldImageNames, p.fldProductDescription 
          FROM tblproducts p
          INNER JOIN  tblproductimages pi ON p.fldProduct_ID = pi.fldproduct_id
          WHERE p.fldActive = <cfqueryparam value="1" cfsqltype="cf_sql_integer">
          AND p.fldSubcategoryID = <cfqueryparam value="#arguments.subid#" cfsqltype="cf_sql_integer">
          AND pi.fldActive = <cfqueryparam value="1" cfsqltype="cf_sql_integer">
          AND pi.fldproduct_id = p.fldProduct_ID
          (#whereClause#)
          GROUP BY p.fldProduct_ID
    </cfquery>
    <cfdump var="#filteredProducts#"abort>
    <cfreturn serializeJSON(filteredProducts)>
  </cffunction>
</cfcomponent>
