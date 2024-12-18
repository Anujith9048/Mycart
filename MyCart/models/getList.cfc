<cfcomponent>
    <cffunction name="getCategories" access="remote" returnFormat="JSON">
      <cfquery name="local.selectCategories" datasource="sqlDatabase">
          SELECT 
            fldCategory_name ,
            fldCategory_ID 
          FROM 
            tblcategories
          WHERE 
            fldActive = <cfqueryparam value="1" cfsqltype="cf_sql_integer">;
      </cfquery>
      <cfreturn { "categories": local.selectCategories }>
    </cffunction>

    <cffunction name="selectCategoryName" access="remote" returnFormat="JSON">
        <cfargument name="id" type="numeric">
        <cfquery name="local.selectCategory" datasource="sqlDatabase" result="local.name">
            SELECT 
                fldCategory_name  
            FROM 
                tblcategories
            WHERE 
                fldCategory_ID = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer">
        </cfquery>
        <cfreturn { "category": local.selectCategory, "name": local.name}>
    </cffunction>

    <cffunction name="getSubCategories" access="remote" returnFormat="JSON">
        <cfargument name="id" type="numeric">
        <cfquery name="local.selectSubcategories" datasource="sqlDatabase">
            SELECT 
                fldSubcategoryName ,
                fldSubcategory_ID 
            FROM 
                tblsubcategories
            WHERE 
                fldActive = <cfqueryparam value="1" cfsqltype="cf_sql_integer">
            AND 
                fldCategoryID = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer">;
        </cfquery>
        <cfreturn { "subcategories": local.selectSubcategories }>
    </cffunction>

    <cffunction name="selectSubCategory" access="remote" returnFormat="JSON">
        <cfargument name="cateId" type="numeric">
        <cfargument name="subId" type="numeric">
        <cfquery name="local.selectCategory" datasource="sqlDatabase">
            SELECT 
                fldCategory_name  
            FROM 
                tblcategories
            WHERE 
                fldCategory_ID = <cfqueryparam value="#arguments.cateId#" cfsqltype="cf_sql_integer">
            AND 
                fldActive = <cfqueryparam value="1" cfsqltype="cf_sql_integer">;
        </cfquery>

        <cfquery name="local.selectSubCategory" datasource="sqlDatabase">
            SELECT fldSubcategoryName  FROM tblsubcategories
            WHERE fldSubcategory_ID = <cfqueryparam value="#arguments.subId#" cfsqltype="cf_sql_integer">
        </cfquery>

        <cfreturn { "category": local.selectCategory,"subcategory": local.selectSubCategory}>
    </cffunction>

    <cffunction name="getCategoryId" access="remote" returnFormat="JSON"> 
        <cfargument name="id" type="numeric">
        <cfquery name="local.selectCategoryId" datasource="sqlDatabase">
            SELECT 
                fldCategoryID 
            FROM 
                tblsubcategories
            WHERE 
                fldSubcategory_ID = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer">;
        </cfquery>
        <cfreturn { "categoryId": local.selectCategoryId.FLDCATEGORYID}>
    </cffunction>

    <cffunction name="getProducts" access="remote" returnFormat="JSON">
        <cfargument name="subid" type="numeric" default="0">
        <cfargument name="limit" type="numeric" default="8">
        <cfargument name="sort" type="string" default="">
        <cfargument name="search" type="string" default="">
        <cfquery name="local.selectProducts" datasource="sqlDatabase">
            SELECT 
                p.fldProduct_ID, 
                p.fldProductName, 
                ROUND((p.fldProductTax / 100) * p.fldProductPrice + p.fldProductPrice, 2) AS fldProductPrice, 
                p.fldBrandName, 
                GROUP_CONCAT(pi.fldimagename) AS fldImageNames, 
                p.fldProductDescription, 
                p.fldProductThumbnail
            FROM 
                tblproducts p
            INNER JOIN 
                tblproductimages pi 
            ON 
                p.fldProduct_ID = pi.fldproduct_id
            WHERE  
                p.fldActive = 1 
            AND  
                pi.fldActive = 1
            <cfif arguments.subid GT 0>
                AND p.fldSubcategoryID = <cfqueryparam value="#arguments.subid#" cfsqltype="cf_sql_integer">
            </cfif>
            <cfif len(arguments.search)>
                AND (p.fldProductName LIKE <cfqueryparam value="%#arguments.search#%" cfsqltype="cf_sql_varchar">
                OR p.fldProductDescription LIKE <cfqueryparam value="%#arguments.search#%" cfsqltype="cf_sql_varchar">)
            </cfif>
            GROUP BY 
                p.fldProduct_ID, 
                p.fldProductName, 
                p.fldProductTax, 
                p.fldProductPrice, 
                p.fldBrandName, 
                p.fldProductDescription, 
                p.fldProductThumbnail
            <cfif len(arguments.sort)>
                ORDER BY p.fldProductPrice
                #arguments.sort EQ "asc" ? 'ASC' : 'DESC'#
            <cfelse>
                ORDER BY RAND()
            </cfif>
            LIMIT <cfqueryparam value="#arguments.limit#" cfsqltype="cf_sql_integer">
        </cfquery>
        <cfreturn { "products": local.selectProducts }>
    </cffunction>
    
    <cffunction name="selectProduct" access="remote" returnFormat="JSON">
        <cfargument name="subId" type="numeric">
        <cfargument name="proId" type="numeric">
        <cfquery name="local.selectProduct" datasource="sqlDatabase">
            SELECT 
                fldProductName,
                fldProductDescription,
                ROUND((fldProductTax / 100) *fldProductPrice +fldProductPrice, 2) AS ProductPrice,
                fldProductPrice,
                fldBrandName,
                fldProductThumbnail,
                fldProductTax  
            FROM 
                tblproducts
            WHERE 
                fldSubcategoryID = <cfqueryparam value="#arguments.subId#" cfsqltype="cf_sql_integer">
            AND 
                fldProduct_ID = <cfqueryparam value="#arguments.proId#" cfsqltype="cf_sql_integer">;
        </cfquery>

        <cfquery name="local.selectSubCategory" datasource="sqlDatabase">
            SELECT  
                tblcategories.fldCategory_name, 
                tblsubcategories.fldSubcategoryName
            FROM 
                tblsubcategories 
            JOIN  
                tblcategories 
            ON 
                tblsubcategories.fldCategoryID = tblcategories.fldCategory_ID
            WHERE 
                tblsubcategories.fldSubcategory_ID = <cfqueryparam value="#arguments.subId#" cfsqltype="cf_sql_integer">
            AND 
                tblsubcategories.fldActive =  <cfqueryparam value="1" cfsqltype="cf_sql_integer">;
        </cfquery>
        
        <cfreturn { "product": local.selectProduct,"subcategory": local.selectSubCategory}>
    </cffunction>

    <cffunction name="getSingleProduct" access="remote" returnFormat="JSON">
        <cfargument name="proId" type="numeric">
        <cfquery name="local.selectProduct" datasource="sqlDatabase">
            SELECT 
                p.fldProduct_ID, 
                p.fldProductName, 
                ROUND((p.fldProductTax / 100) * p.fldProductPrice + p.fldProductPrice, 2) AS fldProductPriceWithTax, 
                p.fldBrandName, GROUP_CONCAT(pi.fldimagename) AS fldImageNames, 
                p.fldProductDescription ,
                p.fldProductTax ,
                p.fldProductPrice ,
                p.fldProductThumbnail
            FROM 
                tblproducts p 
            INNER JOIN 
                tblproductimages pi 
            ON 
                p.fldProduct_ID = pi.fldproduct_id
            WHERE 
                p.fldProduct_ID = <cfqueryparam value="#arguments.proId#" cfsqltype="cf_sql_integer">
            AND 
                pi.fldActive = <cfqueryparam value="1" cfsqltype="cf_sql_integer">;
        </cfquery>
        <cfreturn { "product": local.selectProduct}>
    </cffunction>

    <cffunction name="getProductImages" access="remote" returnFormat="JSON">
        <cfargument name="proID" type="any" required="true">
        <cfquery name="local.selectProductImage" datasource="sqlDatabase">
            SELECT 
                fldImageID, 
                fldImageName
            FROM 
                tblproductimages
            WHERE 
                fldProduct_id = <cfqueryparam value="#arguments.proID#" cfsqltype="cf_sql_integer">
            AND 
                fldActive = <cfqueryparam value="1" cfsqltype="cf_sql_integer">
            GROUP BY 
                fldImageID
        </cfquery>

        <cfquery name="local.selectThumbnail" datasource="sqlDatabase">
            SELECT fldProductThumbnail
            FROM tblproducts
            WHERE fldProduct_id = <cfqueryparam value="#arguments.proID#" cfsqltype="cf_sql_integer">
            AND fldActive = <cfqueryparam value="1" cfsqltype="cf_sql_integer">
        </cfquery>
        
        <cfset local.imagesArray = []>
        <cfloop query="local.selectProductImage">
            <cfset local.imagesArray.append({
                "FLDIMAGEID" = local.selectProductImage.fldImageID,
                "FLDIMAGENAME" = local.selectProductImage.fldImageName
            })>
        </cfloop>
        <cfreturn {images:local.imagesArray,thumbnail:local.selectThumbnail.FLDPRODUCTTHUMBNAIL}>
    </cffunction>

    <cffunction name="getSubcategoryName" access="remote" returnFormat="JSON">
        <cfargument name="subid" type="numeric">
        <cfquery name="local.selectCategory" datasource="sqlDatabase" result="local.name">
            SELECT 
                fldSubcategoryName 
            FROM 
                tblsubcategories
            WHERE
                fldSubcategory_ID = <cfqueryparam value="#arguments.subid#" cfsqltype="cf_sql_integer">
        </cfquery>
        <cfreturn { "category": local.selectCategory, "name": local.name}>
    </cffunction>

    <cffunction name="getRandomProducts" access="remote" returnFormat="JSON">
        <cfquery name="local.selectProducts" datasource="sqlDatabase">
            SELECT 
                p.fldProduct_ID, 
                p.fldProductName, 
                ROUND((p.fldProductTax / 100) * p.fldProductPrice + p.fldProductPrice, 2) AS fldProductPrice, 
                p.fldBrandName,
                GROUP_CONCAT(pi.fldimagename) AS fldImageNames, 
                p.fldProductDescription ,
                p.fldProductThumbnail
            FROM  
                tblproducts p
            INNER JOIN  
                tblproductimages pi 
            ON 
                p.fldProduct_ID = pi.fldproduct_id
            WHERE 
                p.fldActive = <cfqueryparam value="1" cfsqltype="cf_sql_integer">
            AND 
                pi.fldActive = <cfqueryparam value="1" cfsqltype="cf_sql_integer">
            AND 
                pi.fldproduct_id = p.fldProduct_ID
            GROUP BY 
                p.fldProduct_ID
            ORDER BY RAND()
            LIMIT 4;
        </cfquery>
        <cfreturn { "products": local.selectProducts }>
    </cffunction>
    
    <cffunction name="getCartDetails" access="remote" returnFormat="JSON">
        <cfargument name="userId" type="numeric">
    
        <cfquery name="local.cartDetails" datasource="sqlDatabase">
            SELECT 
                p.fldActive,
                p.fldProduct_ID,
                p.fldProductName,
                ROUND((p.fldProductTax / 100) * p.fldProductPrice + p.fldProductPrice, 2) * c.fldQuantity AS totalCost,
                p.fldProductThumbnail,
                p.fldProductPrice,
                p.fldProductTax,
                p.fldBrandName,
                GROUP_CONCAT(pi.fldimagename) AS fldimagename,
                p.fldProductDescription,
                c.fldQuantity,
                SUM(ROUND((p.fldProductTax / 100) * p.fldProductPrice + p.fldProductPrice, 2) * c.fldQuantity) OVER () AS totalPrice,
                SUM(ROUND(((p.fldProductTax /100)*(p.fldProductPrice * c.fldQuantity)) , 2)) OVER () AS totalTax
            FROM tblproducts p
            INNER JOIN tblcart c ON p.fldProduct_ID = c.fldProductID
            INNER JOIN tblproductimages pi ON p.fldProduct_ID = pi.fldproduct_id
            WHERE 
                c.fldActive = 1
                AND pi.fldActive = 1
                AND c.fldUserID = <cfqueryparam value="#arguments.userId#" cfsqltype="cf_sql_integer">
            GROUP BY 
                p.fldProduct_ID,
                p.fldProductName,
                p.fldProductThumbnail,
                p.fldProductPrice,
                p.fldProductTax,
                p.fldBrandName,
                p.fldProductDescription,
                c.fldQuantity
        </cfquery>
    
        <cfset var result = {
            "cartItems": [],
            "totalPrice": 0,
            "totalTax":0
        }>
    
        <cfloop query="local.cartDetails">
            <cfset arrayAppend(result.cartItems, {
                "fldActive": local.cartDetails.fldActive,
                "fldProduct_ID": local.cartDetails.fldProduct_ID,
                "fldProductName": local.cartDetails.fldProductName,
                "totalCost": local.cartDetails.totalCost,
                "fldProductThumbnail": local.cartDetails.fldProductThumbnail,
                "fldProductPrice": local.cartDetails.fldProductPrice,
                "fldProductTax": local.cartDetails.fldProductTax,
                "fldBrandName": local.cartDetails.fldBrandName,
                "fldimagename": local.cartDetails.fldimagename,
                "fldProductDescription": local.cartDetails.fldProductDescription,
                "fldQuantity": local.cartDetails.fldQuantity
            })>
        </cfloop>

        <cfif local.cartDetails.recordCount gt 0>
            <cfset result.totalPrice = local.cartDetails.totalPrice>
            <cfset result.totalTax = local.cartDetails.totalTax>
        </cfif>
        <cfreturn result>
    </cffunction>

    <cffunction name="getCartCount" access="remote" returnFormat="JSON">
        <cfquery name="local.selectCartCount" datasource="sqlDatabase">
            SELECT 
                COUNT(fldUserID) AS count
            FROM 
                tblcart
            where 
                fldActive = 1 
            AND 
                fldUserID = <cfqueryparam value="#session.userId#" cfsqltype="cf_sql_integer">;
        </cfquery>
        <cfreturn { "count": local.selectCartCount }>
    </cffunction>

    <cffunction name="getUserDetails" access="remote" returnFormat="JSON">
        <cfquery name="local.getUserDetails" datasource="sqlDatabase">
            SELECT 
                fldUserName ,
                fldEmail 
            FROM 
                tbluserlogin
            WHERE 
                fldActive = <cfqueryparam value="1" cfsqltype="cf_sql_integer">
            AND 
                fldUser_ID = <cfqueryparam value="#session.userId#" cfsqltype="cf_sql_integer">;
        </cfquery>
        <cfreturn { "data": local.getUserDetails }>
    </cffunction>

    <cffunction name="getUserAddress" access="remote" returnFormat="JSON">
        <cfquery name="local.getUserAddress" datasource="sqlDatabase">
            SELECT 
                fldAddress_ID ,
                fldFullname ,
                fldPhone ,
                fldPincode ,
                fldState ,
                fldCity ,
                fldBuildingName ,
                fldArea 
            FROM 
                tblsavedaddress
            WHERE 
                fldActive = <cfqueryparam value="1" cfsqltype="cf_sql_integer">
            AND 
                fldAddressUserID = <cfqueryparam value="#session.userId#" cfsqltype="cf_sql_integer">
            ORDER BY 
                fldAddress_ID DESC;
        </cfquery>
        <cfreturn { "data": local.getUserAddress }>
    </cffunction>

    <cffunction name="getselectedAddress" access="remote" returnFormat="JSON">
        <cfargument name="addressId" type="numeric">
        <cfquery name="local.getselectedAddress" datasource="sqlDatabase">
            SELECT 
                fldFullname ,
                fldPhone ,
                fldPincode ,
                fldState ,
                fldCity ,
                fldBuildingName ,
                fldArea 
            FROM 
                tblsavedaddress
            WHERE 
                fldActive = <cfqueryparam value="1" cfsqltype="cf_sql_integer">
            AND 
                fldAddress_ID  = <cfqueryparam value="#arguments.addressId#" cfsqltype="cf_sql_integer">;
        </cfquery>
        <cfreturn { "result": local.getselectedAddress }>
    </cffunction>

    <cffunction name="getorderHistory" access="remote" returnFormat="JSON">
        <cfquery name="local.getOrderHistory" datasource="sqlDatabase">
            SELECT 
                o.fldOrder_ID, 
                o.fldShippingAddress,  
                o.fldOrderDate,  
                op.fldProduct AS fldProduct_ID, 
                op.fldProductQuantity,  
                p.fldProductThumbnail, 
                ROUND((op.fldProductTax / 100) * op.fldProductPrice + op.fldProductPrice, 2) * op.fldProductQuantity AS totalOrderCost, 
                op.fldProductPrice, 
                op.fldProductTax,   
                p.fldProductName, 
                p.fldProduct_ID,  
                p.fldBrandName, 
                a.fldFullname, 
                a.fldPhone, 
                a.fldPincode,
                a.fldState, 
                a.fldCity, 
                a.fldBuildingName, 
                a.fldArea
            FROM 
                tblorder o
                INNER JOIN tblorderproducts op ON o.fldOrder_ID = op.fldOrderID
                INNER JOIN tblproducts p ON op.fldProduct = p.fldProduct_ID
                INNER JOIN tblproductimages pi ON p.fldProduct_ID = pi.fldproduct_id
                INNER JOIN tblsavedaddress a ON o.fldShippingAddress = a.fldAddress_ID
            WHERE 
                o.fldUserID = <cfqueryparam value="#session.userId#" cfsqltype="cf_sql_integer">
            GROUP BY 
                o.fldOrder_ID, 
                o.fldShippingAddress, 
                o.fldOrderDate, 
                op.fldProduct, 
                p.fldProductThumbnail, 
                op.fldProductQuantity, 
                p.fldProductName, 
                p.fldBrandName, 
                a.fldFullname,
                a.fldPhone, 
                a.fldPincode, 
                a.fldState, 
                a.fldCity, 
                a.fldBuildingName, 
                a.fldArea, 
                op.fldProductPrice, 
                op.fldProductTax, 
                p.fldProduct_ID
            ORDER BY 
                o.fldOrderDate DESC, 
                fldOrder_ID, 
                p.fldProduct_ID
        </cfquery>
    
        <cfset orderStruct = {}>
        <cfloop query="local.getOrderHistory" group="fldOrder_ID">
            <cfset local.productArray = []>
            <cfloop>
                <cfset ArrayAppend(local.productArray, {
                    productImage = fldProductThumbnail,
                    productID = fldProduct_ID,
                    productName = fldProductName,
                    productQuantity = fldProductQuantity,
                    productBrand = fldBrandName,
                    area = fldArea,
                    building = fldBuildingName,
                    city = fldCity,
                    name = fldFullname,
                    orderDate = fldOrderDate,
                    orderId = fldOrder_ID,
                    phone = fldPhone,
                    pincode = fldPincode,
                    state = fldState,
                    cost = fldProductPrice,
                    tax = fldProductTax,
                    totalCost = totalOrderCost
                })>
            </cfloop>
            <cfset orderStruct[fldOrder_ID] = local.productArray>
        </cfloop>
        <cfreturn { "result": orderStruct }>
    </cffunction>
    
    <cffunction name="getorderTotalCost" access="remote" returnFormat="JSON">
        <cfargument name="orderId" type="string">
        <cfquery name="local.getorderTotalCost" datasource="sqlDatabase">
            SELECT 
            sum(ROUND((fldProductTax / 100) * fldProductPrice + fldProductPrice, 2) * fldProductQuantity) as totalCost 
            FROM tblorderproducts
            WHERE 
                fldOrderStatus = <cfqueryparam value="1" cfsqltype="cf_sql_integer">
            AND 
                fldOrderID  = <cfqueryparam value="#arguments.orderId#" cfsqltype="cf_sql_varchar">;
        </cfquery>
        <cfreturn { "result": local.getorderTotalCost }>
    </cffunction>

    <cffunction name="getItemsInOrderID" access="remote" returnFormat="JSON">
        <cfargument name="orderId" type="string">
        <cfquery name="local.getItemsInOrderID" datasource="sqlDatabase">
            SELECT 
                o.fldShippingAddress, 
                o.fldOrderDate, 
                op.fldProduct AS fldProduct_ID,
                op.fldProductQuantity, 
                SUM(ROUND((op.fldProductTax / 100) * op.fldProductPrice + op.fldProductPrice, 2) * op.fldProductQuantity) AS totalOrderCost, 
                p.fldProductName, 
                p.fldBrandName, 
                p.fldProductThumbnail,
                op.fldProductPrice,
                op.fldProductTax,
                a.fldFullname,
                a.fldPhone,
                a.fldPincode,
                a.fldState,
                a.fldCity,
                a.fldBuildingName,
                a.fldArea
            FROM 
                tblorder o
            INNER JOIN 
                tblorderproducts op 
            ON 
                o.fldOrder_ID = op.fldOrderID
            INNER JOIN 
                tblproducts p 
            ON 
                op.fldProduct = p.fldProduct_ID
            INNER JOIN 
                tblsavedaddress a 
            ON 
                o.fldShippingAddress = a.fldAddress_ID
            WHERE 
                o.fldOrder_ID = <cfqueryparam value="#arguments.orderId#" cfsqltype="cf_sql_varchar">
            GROUP BY 
                o.fldOrder_ID, 
                o.fldShippingAddress, 
                o.fldOrderDate, 
                op.fldProduct, 
                op.fldProductQuantity, 
                p.fldProductName, 
                p.fldBrandName, 
                p.fldProductThumbnail, 
                op.fldProductPrice, 
                op.fldProductTax
        </cfquery>
        <cfreturn { "result": local.getItemsInOrderID }>
    </cffunction>

    <cffunction name="getpath" access="remote" returnFormat="JSON">
        <cfargument name="proId" type="numeric">
        <cfquery name="local.getpath" datasource="sqlDatabase">
            SELECT 
                p.fldSubcategoryID ,
                s.fldCategoryID ,
                c.fldCategory_name ,
                s.fldSubcategoryName 
            FROM 
                tblproducts p
            INNER JOIN 
                tblsubcategories s 
            ON 
                p.fldSubcategoryID = s.fldSubcategory_ID
            INNER JOIN 
                tblcategories c 
            ON 
                s.fldCategoryID = c.fldCategory_ID
            WHERE 
                fldProduct_ID = <cfqueryparam value="#arguments.proId#" cfsqltype="cf_sql_integer">;
        </cfquery>
        
        <cfreturn { "path": local.getpath}>
    </cffunction>
</cfcomponent>