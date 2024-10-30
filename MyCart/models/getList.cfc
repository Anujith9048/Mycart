<cfcomponent>
    <cffunction name="getCategories" access="remote" returnFormat="JSON">
      <cfquery name="selectCategories" datasource="sqlDatabase">
          SELECT fldCategory_name ,fldCategory_ID FROM tblcategories
          WHERE fldActive = <cfqueryparam value="1" cfsqltype="cf_sql_varchar">;
      </cfquery>
      <cfreturn { "categories": selectCategories }>
    </cffunction>

    <cffunction name="selectCategoryName" access="remote" returnFormat="JSON">
        <cfargument name="id" type="any">
        <cfquery name="selectCategory" datasource="sqlDatabase" result="name">
            SELECT fldCategory_name  FROM tblcategories
            WHERE fldCategory_ID = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_varchar">
        </cfquery>
        <cfreturn { "category": selectCategory, "name": name}>
    </cffunction>

    <cffunction name="getSubCategories" access="remote" returnFormat="JSON">
        <cfargument name="id" type="any">
        <cfquery name="selectSubcategories" datasource="sqlDatabase" result="subcategories">
            SELECT fldSubcategoryName ,fldSubcategory_ID FROM tblsubcategories
            WHERE fldActive = <cfqueryparam value="1" cfsqltype="cf_sql_varchar">
            AND fldCategoryID = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_varchar">;
        </cfquery>
        <cfreturn { "subcategories": selectSubcategories }>
    </cffunction>

    <cffunction name="selectSubCategory" access="remote" returnFormat="JSON">
        <cfargument name="cateId" type="any">
        <cfargument name="subId" type="any">
        <cfquery name="selectCategory" datasource="sqlDatabase">
            SELECT fldCategory_name  FROM tblcategories
            WHERE fldCategory_ID = <cfqueryparam value="#arguments.cateId#" cfsqltype="cf_sql_varchar">
            AND fldActive = <cfqueryparam value="1" cfsqltype="cf_sql_varchar">;
        </cfquery>

        <cfquery name="selectSubCategory" datasource="sqlDatabase">
            SELECT fldSubcategoryName  FROM tblsubcategories
            WHERE fldSubcategory_ID = <cfqueryparam value="#arguments.subId#" cfsqltype="cf_sql_varchar">
        </cfquery>

        <cfreturn { "category": selectCategory,"subcategory": selectSubCategory}>
    </cffunction>

    <cffunction name="getCategoryId" access="remote" returnFormat="JSON">
        <cfargument name="id" type="string">
        <cfquery name="selectCategoryId" datasource="sqlDatabase" result="categoryId">
            SELECT fldCategoryID FROM tblsubcategories
            WHERE fldSubcategory_ID = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_varchar">;
        </cfquery>
        <cfreturn { "categoryId": selectCategoryId.FLDCATEGORYID}>
    </cffunction>

    <cffunction name="getProducts" access="remote" returnFormat="JSON">
        <cfargument name="subid" type="string">
        <cfquery name="selectProducts" datasource="sqlDatabase" result="Products">
            SELECT fldProduct_ID,fldProductName ,fldProductPrice,fldBrandName,fldProductImage,fldProductDescription FROM tblproducts
            WHERE fldActive = <cfqueryparam value="1" cfsqltype="cf_sql_varchar">
            AND fldSubcategoryID = <cfqueryparam value="#arguments.subid#" cfsqltype="cf_sql_varchar">;
        </cfquery>
        <cfreturn { "products": selectProducts }>
    </cffunction>

    <cffunction name="selectProduct" access="remote" returnFormat="JSON">
        <cfargument name="subId" type="any">
        <cfargument name="proId" type="any">
        <cfquery name="selectProduct" datasource="sqlDatabase">
            SELECT fldProductName,fldProductDescription,fldProductPrice,fldBrandName,fldProductImage  FROM tblproducts
            WHERE fldSubcategoryID = <cfqueryparam value="#arguments.subId#" cfsqltype="cf_sql_varchar">
            AND fldProduct_ID = <cfqueryparam value="#arguments.proId#" cfsqltype="cf_sql_varchar">;
        </cfquery>

        <cfquery name="selectSubCategory" datasource="sqlDatabase">
            SELECT  tblcategories.fldCategory_name, tblsubcategories.fldSubcategoryName
            FROM tblsubcategories JOIN  tblcategories 
            ON tblsubcategories.fldCategoryID = tblcategories.fldCategory_ID
            WHERE tblsubcategories.fldSubcategory_ID = <cfqueryparam value="#arguments.subId#" cfsqltype="cf_sql_varchar">
            AND tblsubcategories.fldActive =  <cfqueryparam value="1" cfsqltype="cf_sql_varchar">;
        </cfquery>
        
        <cfreturn { "product": selectProduct,"subcategory": selectSubCategory}>
    </cffunction>

    <cffunction name="getSingleProduct" access="remote" returnFormat="JSON">
        <cfargument name="proId" type="any">
        <cfquery name="selectProduct" datasource="sqlDatabase">
            SELECT fldProductName,fldProductDescription,fldProductPrice,fldBrandName,fldProductImage  FROM tblproducts
            WHERE fldProduct_ID = <cfqueryparam value="#arguments.proId#" cfsqltype="cf_sql_varchar">;
        </cfquery>
        
        <cfreturn { "product": selectProduct}>
    </cffunction>

    <cffunction name="getSubcategoryName" access="remote" returnFormat="JSON">
        <cfargument name="subid" type="any">
        <cfquery name="selectCategory" datasource="sqlDatabase" result="name">
            SELECT fldSubcategoryName  FROM tblsubcategories
            WHERE fldSubcategory_ID = <cfqueryparam value="#arguments.subid#" cfsqltype="cf_sql_varchar">
        </cfquery>
        <cfreturn { "category": selectCategory, "name": name}>
    </cffunction>


    <cffunction name="getRandomProducts" access="remote" returnFormat="JSON">
        <cfquery name="selectProducts" datasource="sqlDatabase" result="Products">
            SELECT fldProduct_ID,fldProductName ,fldProductPrice,fldBrandName,fldProductImage,fldProductDescription FROM tblproducts
            WHERE fldActive = <cfqueryparam value="1" cfsqltype="cf_sql_varchar">
            ORDER BY RAND()
            LIMIT 4;
        </cfquery>
        <cfreturn { "products": selectProducts }>
    </cffunction>

    <cffunction name="getCart" access="remote" returnFormat="JSON">
        <cfargument name="userId" type="string">
        <cfquery name="selectCartItems" datasource="sqlDatabase" result="cartItems">
            SELECT p.fldProduct_ID, p.fldProductName, p.fldProductPrice, p.fldBrandName, p.fldProductImage, p.fldProductDescription
            FROM tblproducts p INNER JOIN tblcart c ON p.fldProduct_ID = c.fldProductID
            WHERE c.fldActive = <cfqueryparam value="1" cfsqltype="cf_sql_varchar"> 
            AND c.fldUserID = <cfqueryparam value="#arguments.userId#" cfsqltype="cf_sql_varchar">
            AND p.fldActive = <cfqueryparam value="1" cfsqltype="cf_sql_varchar">
        </cfquery>
        <cfreturn { "cartItems": selectCartItems }>
    </cffunction>

    <cffunction name="getCartPrice" access="remote" returnFormat="JSON">
        <cfargument name="userId" type="string">
        <cfquery name="selectCartAmount" datasource="sqlDatabase" result="cartamount">
            SELECT SUM(p.fldProductPrice) as sum
            FROM tblproducts p INNER JOIN tblcart c ON p.fldProduct_ID = c.fldProductID
            Where c.fldUserID = <cfqueryparam value="#arguments.userId#" cfsqltype="cf_sql_varchar">
            AND c.fldActive = <cfqueryparam value="1" cfsqltype="cf_sql_varchar">;
        </cfquery>
        <cfreturn { "price": selectCartAmount }>
    </cffunction>

    <cffunction name="getCartCount" access="remote" returnFormat="JSON">
        <cfquery name="selectCartCount" datasource="sqlDatabase" result="cartamount">
            SELECT COUNT(fldUserID) AS count
            FROM tblcart
            where fldActive = 1 
            AND fldUserID = <cfqueryparam value="#session.userId#" cfsqltype="cf_sql_varchar">;
        </cfquery>
        <cfreturn { "count": selectCartCount }>
    </cffunction>
</cfcomponent>
