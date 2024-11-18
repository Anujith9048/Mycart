<cfcomponent>

  <!--- Check category --->
  <cffunction name="checkCategory" access="remote" returnformat="JSON">
    <cfargument name="categoryName" type="string" >
    <cfquery datasource="sqlDatabase" result="local.checkResult">
      SELECT 1 FROM tblcategories 
      WHERE fldCategory_name = <cfqueryparam value="#trim(arguments.categoryName)#"  cfsqltype="cf_sql_varchar">;
    </cfquery>
    <cfreturn {"result":local.checkResult}>
  </cffunction>

  <!--- Add Category --->
  <cffunction name="addCategory" access="remote" returnformat="JSON">
    <cfargument name="categoryName" type="string" >
        <cfquery datasource="sqlDatabase">
            INSERT INTO tblcategories (fldCategory_name,fldCreatedDate)
            VALUES(
                <cfqueryparam value="#arguments.categoryName#"  cfsqltype="cf_sql_varchar">,
                <cfqueryparam value="#session.userID#"  cfsqltype="cf_sql_integer">
            );
          </cfquery>
      <cfreturn {"result":true}>
  </cffunction>

  <!--- Edit Category --->
  <cffunction name="editCategory" access="remote" returnformat="JSON">
    <cfargument name="categoryName" type="string" >
    <cfargument name="id" type="string" >
    <cfset local.currentDate = Now()>
    <cfquery datasource="sqlDatabase">
      UPDATE tblcategories
      SET fldCategory_name =  <cfqueryparam value="#arguments.categoryName#"  cfsqltype="cf_sql_varchar">,
          fldEditedBy =  <cfqueryparam value="#session.userId#"  cfsqltype="cf_sql_integer">,
          fldEditedDate =  <cfqueryparam value="#local.currentDate#"  cfsqltype="cf_sql_timestamp">
      WHERE fldCategory_ID =  <cfqueryparam value="#arguments.id#"  cfsqltype="cf_sql_integer">;
    </cfquery>
    <cfreturn {"result":true}>
  </cffunction>

  <!--- Delete Categories --->
  <cffunction name="deleteCategories" access="remote" returnformat="JSON">
    <cfargument name="id" type="string" >
    <cfset local.currentDate = Now()>
    <cfquery datasource="sqlDatabase">
        UPDATE tblcategories
        SET
            fldDeactivatedBy =  <cfqueryparam value="#session.userId#"  cfsqltype="cf_sql_integer">,
            fldDeactivatedDate =  <cfqueryparam value="#local.currentDate#"  cfsqltype="cf_sql_timestamp">,
            fldActive = <cfqueryparam value="0"  cfsqltype="cf_sql_integer">
        WHERE fldCategory_ID =  <cfqueryparam value="#arguments.id#"  cfsqltype="cf_sql_integer">;
    </cfquery>
    <cfquery datasource="sqlDatabase">
      UPDATE tblsubcategories
      SET
          fldDeactivatedBy = <cfqueryparam value="#session.userId#" cfsqltype="cf_sql_integer">,
          fldDeactivatedDate = <cfqueryparam value="#local.currentDate#" cfsqltype="cf_sql_timestamp">,
          fldActive = <cfqueryparam value="0" cfsqltype="cf_sql_integer">
      WHERE fldCategoryID = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer">
    </cfquery>
    <cfquery datasource="sqlDatabase">
      UPDATE tblproducts
      SET fldActive = <cfqueryparam value="0" cfsqltype="cf_sql_integer">
      WHERE fldSubcategoryID IN (
          SELECT fldSubcategory_ID
          FROM tblsubcategories
          WHERE fldCategoryID = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer">
      )
    </cfquery>

    <cfreturn {"result":true}>
  </cffunction>

  <!---  getCategoryID --->
  <cffunction name="getCategoryID" access="remote" returnformat="JSON">
    <cfargument name="categoryName" type="string" >
    <cfquery name="local.checkCategoryList" datasource="sqlDatabase">
      SELECT fldCategory_ID FROM tblcategories 
      WHERE fldCategory_name = <cfqueryparam value="#arguments.categoryName#"  cfsqltype="cf_sql_varchar">;
    </cfquery>
    <cfreturn {"result":local.checkCategoryList}>
  </cffunction>

  <!--- Check SubCategory --->
  <cffunction name="checkSubCategory" access="remote" returnformat="JSON">
    <cfargument name="subCategoryName" type="string" >
    <cfargument name="id" type="string" >
    <cfquery datasource="sqlDatabase" result="local.checkResult">
      SELECT 1 FROM tblsubcategories
      WHERE fldSubcategoryName = <cfqueryparam value="#trim(arguments.subCategoryName)#"  cfsqltype="cf_sql_varchar">
      AND fldActive = <cfqueryparam value="1"  cfsqltype="cf_sql_integer">
      AND fldCategoryID = <cfqueryparam value="#arguments.id#"  cfsqltype="cf_sql_integer">;
    </cfquery>
    <cfreturn {"result":local.checkResult.recordCount}>
  </cffunction>

  <!--- Add SubCategory --->
  <cffunction name="addSubcategory" access="remote" returnformat="JSON">
    <cfargument name="subCategoryName" type="string" >
    <cfargument name="categoryID" type="string" >
      <cfquery datasource="sqlDatabase">
        INSERT INTO tblsubcategories (fldSubcategoryName,fldCreatedBy,fldCategoryID)
        VALUES(
          <cfqueryparam value="#arguments.subCategoryName#"  cfsqltype="cf_sql_varchar">,
          <cfqueryparam value="#session.userID#"  cfsqltype="cf_sql_integer">,
          <cfqueryparam value="#arguments.categoryID#"  cfsqltype="cf_sql_integer">
        );
      </cfquery>
      <cfreturn {"result":true}>
  </cffunction>

  <!--- Edit SubCategory --->
  <cffunction name="editSubcategory" access="remote" returnformat="JSON">
    <cfargument name="subCategoryName" type="string" >
    <cfargument name="categoryID" type="any" >
    <cfargument name="id" type="any" >
      <cfset local.currentDate = Now()>
      <cfquery datasource="sqlDatabase">
        UPDATE tblsubcategories
        SET fldSubcategoryName =  <cfqueryparam value="#arguments.subCategoryName#"  cfsqltype="cf_sql_varchar">,
            fldEditedBy =  <cfqueryparam value="#session.userId#"  cfsqltype="cf_sql_integer">,
            fldEditedDate =  <cfqueryparam value="#local.currentDate#"  cfsqltype="cf_sql_date">,
            fldCategoryID = <cfqueryparam value="#arguments.categoryID#"  cfsqltype="cf_sql_integer">
        WHERE fldSubcategory_ID =  <cfqueryparam value="#arguments.id#"  cfsqltype="cf_sql_integer">;
      </cfquery>
      <cfreturn {"result":true}>
  </cffunction>

  <!--- Delete SubCategories --->
  <cffunction name="deleteSubCategories" access="remote" returnformat="JSON">
      <cfargument name="id" type="any" >
          <cfset local.currentDate = Now()>
          <cfquery datasource="sqlDatabase">
            UPDATE tblsubcategories
            SET
              fldDeactivatedBy =  <cfqueryparam value="#session.userId#"  cfsqltype="cf_sql_integer">,
              fldDeactivatedDate =  <cfqueryparam value="#local.currentDate#"  cfsqltype="cf_sql_date">,
              fldActive = <cfqueryparam value="0"  cfsqltype="cf_sql_integer">
            WHERE fldSubcategory_ID =  <cfqueryparam value="#arguments.id#"  cfsqltype="cf_sql_integer">;
          </cfquery>

          <cfquery datasource="sqlDatabase">
            UPDATE tblproducts
            SET
              fldDeactivatedBy =  <cfqueryparam value="#session.userId#"  cfsqltype="cf_sql_integer">,
              fldDeactivatedDate =  <cfqueryparam value="#local.currentDate#"  cfsqltype="cf_sql_date">,
              fldActive = <cfqueryparam value="0"  cfsqltype="cf_sql_integer">
            WHERE fldSubcategory_ID =  <cfqueryparam value="#arguments.id#"  cfsqltype="cf_sql_integer">;
          </cfquery>
        <cfreturn {"result":true}>
  </cffunction>

  <!--- Check getSubCategoryID --->
  <cffunction name="getSubCategoryID" access="remote" returnformat="JSON">
    <cfargument name="subCategoryName" type="string" >
    <cfquery name="local.checkSubCategoryList" datasource="sqlDatabase">
      SELECT fldSubcategory_ID FROM tblsubcategories 
      WHERE fldSubcategoryName = <cfqueryparam value="#arguments.subCategoryName#"  cfsqltype="cf_sql_varchar">
      AND fldActive = <cfqueryparam value="1"  cfsqltype="cf_sql_integer">;
    </cfquery>
    <cfreturn {"result":local.checkSubCategoryList}>
  </cffunction>

  <!--- Valid subcategory --->
  <cffunction name="validSubcategory" access="remote" returnformat="JSON">
    <cfargument name="categoryId" type="string" >
    <cfargument name="subid" type="string" >
    <cfquery datasource="sqlDatabase" result="local.id">
      SELECT fldSubcategoryName FROM tblsubcategories 
      WHERE fldCategoryID = <cfqueryparam value="#arguments.categoryId#"  cfsqltype="cf_sql_integer">
      AND fldSubcategoryName = <cfqueryparam value="#trim(arguments.subid)#"  cfsqltype="cf_sql_varchar">;
    </cfquery>
    <cfreturn {"result":local.id}>
  </cffunction>

  <!--- Check Product --->
  <cffunction name="checkProduct" access="remote" returnformat="JSON">
    <cfargument name="productName" type="string" >
    <cfargument name="productBrand" type="string" >
    <cfargument name="subid" type="any" >
    <cfquery datasource="sqlDatabase" result="local.checkResult">
      SELECT 1 FROM tblproducts
      WHERE fldProductName = <cfqueryparam value="#arguments.productName#"  cfsqltype="cf_sql_varchar">
      AND fldActive = <cfqueryparam value="1"  cfsqltype="cf_sql_integer">
      AND fldBrandName = <cfqueryparam value="#productBrand#"  cfsqltype="cf_sql_varchar">
      AND fldSubcategoryID = <cfqueryparam value="#arguments.subid#"  cfsqltype="cf_sql_integer">;
    </cfquery>
    <cfreturn {"result":local.checkResult.recordCount}>
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
    
    <cfquery datasource="sqlDatabase" result="local.addResult">
      INSERT INTO tblproducts (fldSubcategoryID, fldProductName, fldProductDescription, fldProductPrice, fldCreatedBy, fldBrandName, fldProductTax)
      VALUES (
        <cfqueryparam value="#arguments.subcategoryID#" cfsqltype="cf_sql_integer">,
        <cfqueryparam value="#arguments.ProductName#" cfsqltype="cf_sql_varchar">,
        <cfqueryparam value="#arguments.ProductDescription#" cfsqltype="cf_sql_varchar">,
        <cfqueryparam value="#arguments.ProductPrice#" cfsqltype="cf_sql_float">,
        <cfqueryparam value="#session.userID#" cfsqltype="cf_sql_integer">,
        <cfqueryparam value="#arguments.ProductBrand#" cfsqltype="cf_sql_varchar">,
        <cfqueryparam value="#arguments.productTax#" cfsqltype="cf_sql_varchar">
      );
    </cfquery>
    <cfset local.productID = local.addResult.generatedKey>
    <cffile action="uploadall"
            filefield="ProductImages"
            destination="#expandPath('../assets/productImage/')#"
            accept="image/*"
            nameconflict="makeUnique">
    <cfset local.uploadedFiles = cffile.UPLOADALLRESULTS>
    <cfloop array="#local.uploadedFiles#" index="files">
      <cfquery datasource="sqlDatabase">
        INSERT INTO tblproductimages (fldproduct_id, fldimagename, fldaddedby)
        VALUES (
          <cfqueryparam value="#local.productID#" cfsqltype="cf_sql_integer">,
          <cfqueryparam value="#files.SERVERFILE#" cfsqltype="cf_sql_varchar">,
          <cfqueryparam value="#session.userId#" cfsqltype="cf_sql_varchar">
        )
      </cfquery>
    </cfloop>
    <cfdump var="#local.uploadedFiles[1].SERVERFILE#">
    <cfquery datasource="sqlDatabase">
      UPDATE tblproducts
      SET fldProductThumbnail = <cfqueryparam value="#local.uploadedFiles[1].SERVERFILE#" cfsqltype="cf_sql_varchar">
      WHERE fldProduct_ID = <cfqueryparam value="#local.productID#" cfsqltype="cf_sql_integer">;
    </cfquery>
    <cfreturn {"result": true}>
  </cffunction>

  <!--- Edit Product With image --->
  <cffunction name="editProduct" access="remote" returnformat="JSON">
    <cfargument name="ProductName" type="string">
    <cfargument name="subcategoryID" type="numeric">
    <cfargument name="ProductDescription" type="string">
    <cfargument name="ProductBrand" type="string">
    <cfargument name="ProductPrice" type="float">
    <cfargument name="ProductImage" type="array">
    <cfargument name="proId" type="numeric">
    <cfargument name="productTax" type="float" default=1>
    
    <cfset local.currentDate = Now()>

    <cfquery name="editCategoryList" datasource="sqlDatabase">
      UPDATE tblproducts
      SET 
          fldProductName = <cfqueryparam value="#arguments.ProductName#" cfsqltype="cf_sql_varchar">,
          fldEditedBy = <cfqueryparam value="#session.userId#" cfsqltype="cf_sql_integer">,
          fldEditedDate = <cfqueryparam value="#local.currentDate#" cfsqltype="cf_sql_timestamp">,
          fldProductDescription = <cfqueryparam value="#arguments.ProductDescription#" cfsqltype="cf_sql_varchar">,
          fldProductPrice = <cfqueryparam value="#arguments.ProductPrice#" cfsqltype="cf_sql_float">,
          fldBrandName = <cfqueryparam value="#arguments.ProductBrand#" cfsqltype="cf_sql_varchar">,
          fldSubcategoryID = <cfqueryparam value="#arguments.subcategoryID#" cfsqltype="cf_sql_integer">,
          fldProductTax = <cfqueryparam value="#arguments.productTax#" cfsqltype="cf_sql_float">
      WHERE fldProduct_ID = <cfqueryparam value="#arguments.proId#" cfsqltype="cf_sql_integer">;
    </cfquery>

    <cffile action="uploadall"
            filefield="ProductImages"
            destination="#expandPath('../assets/productImage/')#"
            accept="image/*"
            nameconflict="makeUnique">
    <cfset local.uploadedFiles = cffile.UPLOADALLRESULTS>
    <cfloop array="#local.uploadedFiles#" index="files">
      <cfquery datasource="sqlDatabase">
        INSERT INTO  tblproductimages (fldimagename,fldEdittedBy,fldEdittedDate,fldproduct_id)
        VALUES(
          <cfqueryparam value="#files.SERVERFILE#" cfsqltype="cf_sql_varchar">,
          <cfqueryparam value="#session.userId#" cfsqltype="cf_sql_integer">,
          <cfqueryparam value="#local.currentDate#" cfsqltype="cf_sql_timestamp">,
          <cfqueryparam value="#arguments.proId#" cfsqltype="cf_sql_integer">
        );
      </cfquery>
    </cfloop>
    <cfreturn {"result": true}>
  </cffunction>

  <!--- Delete Product Image--->
  <cffunction name="deleteProductimage" access="remote" returnformat="JSON">
    <cfargument name="imageid" type="numeric">
    <cfset local.currentDate = Now()>
    <cfquery datasource="sqlDatabase">
      UPDATE tblproductimages
      set fldActive=<cfqueryparam value="0" cfsqltype="cf_sql_bit">
      fldDeletedDate=<cfqueryparam value="#local.currentDate#" cfsqltype="cf_sql_timestamp">,
      WHERE fldimageID=<cfqueryparam value="#arguments.imageid#" cfsqltype="cf_sql_integer">;
   </cfquery>
   <cfreturn {"result": true}>
  </cffunction>

  <!--- Edit Product WithOut image --->
  <cffunction name="editProductWithOutImage" access="remote" returnformat="JSON">
    <cfargument name="ProductName" type="string" >
    <cfargument name="subcategoryID" type="numeric" >
    <cfargument name="ProductDescription" type="string" >
    <cfargument name="ProductBrand" type="string" >
    <cfargument name="ProductPrice" type="float" >
    <cfargument name="proId" type="numeric" >
    <cfargument name="productTax" type="float" default=1>

    <cfset local.currentDate = Now()>
    <cfquery datasource="sqlDatabase">
      UPDATE tblproducts
      SET fldProductName =  <cfqueryparam value="#arguments.ProductName#"  cfsqltype="cf_sql_varchar">,
          fldEditedBy =  <cfqueryparam value="#session.userId#"  cfsqltype="cf_sql_integer">,
          fldEditedDate =  <cfqueryparam value="#local.currentDate#"  cfsqltype="cf_sql_timestamp">,
          fldProductDescription = <cfqueryparam value="#arguments.ProductDescription#"  cfsqltype="cf_sql_varchar">,
          fldProductPrice = <cfqueryparam value="#arguments.ProductPrice#"  cfsqltype="cf_sql_float">,
          fldBrandName = <cfqueryparam value="#arguments.ProductBrand#"  cfsqltype="cf_sql_varchar">,
          fldSubcategoryID = <cfqueryparam value="#arguments.subcategoryID#"  cfsqltype="cf_sql_integer">,
          fldProductTax = <cfqueryparam value="#arguments.productTax#"  cfsqltype="cf_sql_float">
      WHERE fldProduct_ID =  <cfqueryparam value="#arguments.proId#"  cfsqltype="cf_sql_integer">;
    </cfquery>
    <cfreturn {"result":true}>
  </cffunction>

  <!--- Delete Product --->
  <cffunction name="deleteProduct" access="remote" returnformat="JSON">
    <cfargument name="id" type="numeric" >
    <cfargument name="subId" type="numeric" >
    <cfset local.currentDate = Now()>
    <cfquery datasource="sqlDatabase">
      UPDATE tblproducts
      SET
        fldDeactivatedBy =  <cfqueryparam value="#session.userId#"  cfsqltype="cf_sql_integer">,
        fldDeactivatedDate =  <cfqueryparam value="#local.currentDate#"  cfsqltype="cf_sql_timestamp">,
        fldActive = <cfqueryparam value="0"  cfsqltype="cf_sql_integer">
      WHERE fldProduct_ID =  <cfqueryparam value="#arguments.id#"  cfsqltype="cf_sql_integer">
      AND fldSubcategoryID = <cfqueryparam value="#arguments.subId#"  cfsqltype="cf_sql_integer">;
    </cfquery>

    <cfquery datasource="sqlDatabase">
      UPDATE tblproductimages
      SET
        fldActive = <cfqueryparam value="0"  cfsqltype="cf_sql_integer">
        WHERE fldproduct_id =  <cfqueryparam value="#arguments.id#"  cfsqltype="cf_sql_integer">;
    </cfquery>
    <cfreturn {"result":true}>
  </cffunction>

  <!--- Add Cart --->
  <cffunction name="addCart" access="remote" returnformat="JSON">
    <cfargument name="proid" type="numeric" >

    <cfif session.isLog>
      <cfquery datasource="sqlDatabase" result="checkResult">
        SELECT 1 FROM tblcart
        WHERE fldProductID = <cfqueryparam value="#arguments.proid#"  cfsqltype="cf_sql_integer">
        AND fldActive = <cfqueryparam value="1"  cfsqltype="cf_sql_integer">
        AND fldUserID = <cfqueryparam value="#session.userId#"  cfsqltype="cf_sql_integer">;
      </cfquery>
    
      <cfif checkResult.recordCount>
        <cfquery datasource="sqlDatabase">
          UPDATE tblcart
          SET fldQuantity =  fldQuantity + 1
          WHERE fldProductID =  <cfqueryparam value="#arguments.proid#"  cfsqltype="cf_sql_integer">
          AND fldUserID =  <cfqueryparam value="#session.userId#"  cfsqltype="cf_sql_integer">;
        </cfquery>
            <cfreturn {"result":true}>
        <cfelse>
          <cfquery datasource="sqlDatabase">
            INSERT INTO tblcart (fldUserID,fldProductID)
            VALUES(
              <cfqueryparam value="#session.userId#"  cfsqltype="cf_sql_integer">,
              <cfqueryparam value="#arguments.proid#"  cfsqltype="cf_sql_integer">
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
    <cfargument name="proid" type="numeric" >
    <cfset local.currentDate = Now()>
      <cfquery datasource="sqlDatabase">
        UPDATE tblcart
        SET
          fldRemoveDate =  <cfqueryparam value="#local.currentDate#"  cfsqltype="cf_sql_timestamp">,
          fldActive = <cfqueryparam value="0"  cfsqltype="cf_sql_integer">
        WHERE fldProductID =  <cfqueryparam value="#arguments.proid#"  cfsqltype="cf_sql_integer">
        AND fldUserID = <cfqueryparam value="#session.userId#"  cfsqltype="cf_sql_integer">;
      </cfquery>
      <cfreturn {"result":true}>
  </cffunction>

  <!---  addQuantity  --->
  <cffunction name="addQuantity" access="remote" returnformat="JSON">
    <cfargument name="id" type="numeric" >
    <cfargument name="type" type="string" >
      <cfset local.currentDate = dateFormat(now(),"yyyy-mm-dd")>
      <cfquery datasource="sqlDatabase" >
        UPDATE tblcart
        SET fldQuantity =   
          <cfif arguments.type EQ 'increase'>
              fldQuantity + 1
          <cfelse>
            fldQuantity - 1
          </cfif>
        WHERE fldProductID =  <cfqueryparam value="#arguments.id#"  cfsqltype="cf_sql_integer">
        AND fldUserID = <cfqueryparam value="#session.userId#"  cfsqltype="cf_sql_integer">;
      </cfquery>
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
    
    <cfquery datasource="sqlDatabase" result="local.addressResult">
      INSERT INTO tblsavedaddress (fldAddressUserID,fldFullname,fldPhone,fldPincode,fldState,fldCity,fldBuildingName,fldArea)
      VALUES(
          <cfqueryparam value="#session.userId#"  cfsqltype="cf_sql_integer">,
          <cfqueryparam value="#arguments.name#"  cfsqltype="cf_sql_varchar">,
          <cfqueryparam value="#arguments.phone#"  cfsqltype="cf_sql_varchar">,
          <cfqueryparam value="#arguments.pincode#"  cfsqltype="cf_sql_varchar">,
          <cfqueryparam value="#arguments.state#"  cfsqltype="cf_sql_varchar">,
          <cfqueryparam value="#arguments.city#"  cfsqltype="cf_sql_varchar">,
          <cfqueryparam value="#arguments.building#"  cfsqltype="cf_sql_varchar">,
          <cfqueryparam value="#arguments.area#"  cfsqltype="cf_sql_varchar">
      );
    </cfquery>
    <cfset local.id = local.addressResult.generatedKey>
    <cfreturn {"result":true,"id":local.id}>
  </cffunction>

  <!---  Order Product  --->
  <cffunction name="orderProduct" access="remote" returnformat="JSON">
    <cfargument name="cardnumber" type="numeric" >
    <cfargument name="cvv" type="numeric" >
      <cfargument name="addressId" type="numeric" >
      <cfargument name="proid" type="numeric" >
      <cfargument name="quantity" type="numeric" >
      <cfset local.currentDate = dateFormat(now(),"yyyy-mm-dd")>
        
      <cfif cardnumber EQ 11111111111 AND cvv EQ 123>
        <cfset local.id = createuuid()>
        <cfquery datasource="sqlDatabase">
          INSERT INTO tblorder (fldOrder_ID,fldUserID,fldShippingAddress)
          VALUES(
            <cfqueryparam value="#local.id#"  cfsqltype="cf_sql_varchar">,
            <cfqueryparam value="#session.userId#"  cfsqltype="cf_sql_integer">,
            <cfqueryparam value="#arguments.addressId#"  cfsqltype="cf_sql_integer">
          );
        </cfquery>

        <cfquery name="local.getTax" datasource="sqlDatabase">
          SELECT fldProductTax ,fldProductPrice FROM tblproducts
          WHERE fldProduct_ID = <cfqueryparam value="#proid#" cfsqltype="cf_sql_integer">;
        </cfquery>

        <cfquery datasource="sqlDatabase">
          INSERT INTO tblorderproducts (fldOrderID,fldProduct,fldProductQuantity,fldProductPrice,fldProductTax)
          VALUES(
              <cfqueryparam value="#local.id#"  cfsqltype="cf_sql_varchar">,
              <cfqueryparam value="#arguments.proid#"  cfsqltype="cf_sql_integer">,
              <cfqueryparam value="#arguments.quantity#"  cfsqltype="cf_sql_integer">,
              <cfqueryparam value="#local.getTax.fldProductPrice#"  cfsqltype="cf_sql_varchar">,
              <cfqueryparam value="#local.getTax.fldProductTax#"  cfsqltype="cf_sql_float">
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
            We are excited to let you know that we have received your order. 
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

        <cfelse>
          <cfreturn {"result":false,"msg":"Invalid Card Details"}>
      </cfif>
  </cffunction>

  <!---  Order Cart Product  --->
  <cffunction name="orderCartProduct" access="remote" returnformat="JSON">
    <cfargument name="addressId" type="numeric" >
    <cfset local.id = createuuid()>
    
    <cfquery datasource="sqlDatabase">
      INSERT INTO tblorder (fldOrder_ID,fldUserID,fldShippingAddress)
      VALUES(
        <cfqueryparam value="#local.id#"  cfsqltype="cf_sql_varchar">,
        <cfqueryparam value="#session.userId#"  cfsqltype="cf_sql_integer">,
        <cfqueryparam value="#arguments.addressId#"  cfsqltype="cf_sql_integer">
      );
    </cfquery>
    <cfset local.cartList = application.getlistObj.getCart(session.userId)>
    
    <cfloop query="local.cartList.cartItems">
      <cfquery datasource="sqlDatabase">
        INSERT INTO tblorderproducts (fldOrderID,fldProduct,fldProductQuantity,fldProductPrice)
        VALUES(
          <cfqueryparam value="#local.id#"  cfsqltype="cf_sql_varchar">,
          <cfqueryparam value="#FLDPRODUCT_ID#"  cfsqltype="cf_sql_integer">,
          <cfqueryparam value="#FLDQUANTITY#"  cfsqltype="cf_sql_integer">,
          <cfqueryparam value="#FLDPRODUCTPRICE#"  cfsqltype="cf_sql_integer">
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
        We are excited to let you know that we have received your order. 
        Below are the details of your purchase:

        Order ID: #local.id#
        Order Date: #Now()#
        Shipping Address:
        #local.address.result.FLDBUILDINGNAME# #local.address.result.FLDAREA#, #local.address.result.FLDCITY#, #local.address.result.FLDSTATE# #local.address.result.FLDPINCODE#
        Contact Details:
        Name:#local.address.result.FLDFULLNAME#
        Phone:#local.address.result.FLDPHONE#
        Products:
        <cfloop query="local.cartList.cartItems">
          <cfset local.productslist=application.getlistObj.getSingleProduct(FLDPRODUCT_ID)>
          <cfset local.product = local.productslist.product>

          Product Name : #local.product.FLDPRODUCTNAME#
          Brand : #local.product.FLDBRANDNAME#
          Price : Rs.#local.product.FLDPRODUCTPRICE#/-
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
        <cfset local.currentDate = Now()>
        <cfquery datasource="sqlDatabase">
          UPDATE tblcart
          SET
            fldRemoveDate =  <cfqueryparam value="#local.currentDate#"  cfsqltype="cf_sql_timestamp">,
            fldActive = <cfqueryparam value="0"  cfsqltype="cf_sql_integer">
          WHERE fldUserID =  <cfqueryparam value="#session.userId#"  cfsqltype="cf_sql_integer">;
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
    <cfquery name="local.filteredProducts" datasource="sqlDatabase">
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
    <cfreturn serializeJSON(local.filteredProducts)>
  </cffunction>

    <!--- Set Thumbnail Image --->
  <cffunction name="setThumbnailImage" access="remote" returnformat="json">
    <cfargument name="imageid" type="numeric" required="true">
    <cfargument name="productId" type="numeric" required="true">
    <cfquery name="getImage" datasource="sqlDatabase">
      SELECT fldimagename FROM tblproductimages 
      WHERE fldimageID = <cfqueryparam value="#arguments.imageid#" cfsqltype="cf_sql_integer">
    </cfquery>
    <cfquery name="setThumbnail" datasource="sqlDatabase">
      UPDATE tblproducts
        SET fldProductThumbnail = <cfqueryparam value="#getImage.FLDIMAGENAME#" cfsqltype="cf_sql_varchar">
        WHERE fldProduct_ID = <cfqueryparam value="#arguments.productId#" cfsqltype="cf_sql_integer">;
    </cfquery>
    <cfreturn {"result":true}>
  </cffunction>
</cfcomponent>
