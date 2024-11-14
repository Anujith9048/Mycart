<cfcomponent>
    <cffunction name="getCategories" access="remote" returnFormat="JSON">
      <cfquery name="local.selectCategories" datasource="sqlDatabase">
          SELECT fldCategory_name ,fldCategory_ID FROM tblcategories
          WHERE fldActive = <cfqueryparam value="1" cfsqltype="cf_sql_integer">;
      </cfquery>
      <cfreturn { "categories": local.selectCategories }>
    </cffunction>

    <cffunction name="selectCategoryName" access="remote" returnFormat="JSON">
        <cfargument name="id" type="any">
        <cfquery name="local.selectCategory" datasource="sqlDatabase" result="local.name">
            SELECT fldCategory_name  FROM tblcategories
            WHERE fldCategory_ID = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer">
        </cfquery>
        <cfreturn { "category": local.selectCategory, "name": local.name}>
    </cffunction>

    <cffunction name="getSubCategories" access="remote" returnFormat="JSON">
        <cfargument name="id" type="any">
        <cfquery name="local.selectSubcategories" datasource="sqlDatabase">
            SELECT fldSubcategoryName ,fldSubcategory_ID FROM tblsubcategories
            WHERE fldActive = <cfqueryparam value="1" cfsqltype="cf_sql_integer">
            AND fldCategoryID = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer">;
        </cfquery>
        <cfreturn { "subcategories": local.selectSubcategories }>
    </cffunction>

    <cffunction name="selectSubCategory" access="remote" returnFormat="JSON">
        <cfargument name="cateId" type="any">
        <cfargument name="subId" type="any">
        <cfquery name="local.selectCategory" datasource="sqlDatabase">
            SELECT fldCategory_name  FROM tblcategories
            WHERE fldCategory_ID = <cfqueryparam value="#arguments.cateId#" cfsqltype="cf_sql_integer">
            AND fldActive = <cfqueryparam value="1" cfsqltype="cf_sql_integer">;
        </cfquery>

        <cfquery name="local.selectSubCategory" datasource="sqlDatabase">
            SELECT fldSubcategoryName  FROM tblsubcategories
            WHERE fldSubcategory_ID = <cfqueryparam value="#arguments.subId#" cfsqltype="cf_sql_integer">
        </cfquery>

        <cfreturn { "category": local.selectCategory,"subcategory": local.selectSubCategory}>
    </cffunction>

    <cffunction name="getCategoryId" access="remote" returnFormat="JSON">
        <cfargument name="id" type="string">
        <cfquery name="local.selectCategoryId" datasource="sqlDatabase" result="categoryId">
            SELECT fldCategoryID FROM tblsubcategories
            WHERE fldSubcategory_ID = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer">;
        </cfquery>
        <cfreturn { "categoryId": local.selectCategoryId.FLDCATEGORYID}>
    </cffunction>

    <cffunction name="getProducts" access="remote" returnFormat="JSON">
        <cfargument name="subid" type="string" required="true">
        <cfargument name="limit" type="string" default="8">
        <cfif structKeyExists(arguments, "limit")>

        <cfquery name="local.selectProducts" datasource="sqlDatabase" result="Products">
            SELECT p.fldProduct_ID, p.fldProductName, ROUND((p.fldProductTax / 100) * p.fldProductPrice + p.fldProductPrice, 2) AS fldProductPrice, p.fldBrandName, GROUP_CONCAT(pi.fldimagename) AS fldImageNames, p.fldProductDescription 
            FROM tblproducts p 
            INNER JOIN tblproductimages pi ON p.fldProduct_ID = pi.fldproduct_id
            WHERE  p.fldActive = <cfqueryparam value="1" cfsqltype="cf_sql_integer"> 
            AND pi.fldActive = <cfqueryparam value="1" cfsqltype="cf_sql_integer">
            AND p.fldSubcategoryID = <cfqueryparam value="#arguments.subid#" cfsqltype="cf_sql_integer">
            GROUP BY p.fldProduct_ID, p.fldProductName, p.fldProductTax, p.fldProductPrice, p.fldBrandName, p.fldProductDescription
            ORDER BY RAND()
            LIMIT <cfqueryparam value="#arguments.limit#" cfsqltype="cf_sql_integer">;
        </cfquery>
        <cfelse>
            <cfquery name="local.selectProducts" datasource="sqlDatabase" result="Products">
                SELECT p.fldProduct_ID, p.fldProductName, ROUND((p.fldProductTax / 100) * p.fldProductPrice + p.fldProductPrice, 2) AS fldProductPrice,
                p.fldBrandName, GROUP_CONCAT(pi.fldimagename) AS fldImageNames, p.fldProductDescription 
                FROM tblproducts p 
                INNER JOIN  tblproductimages pi ON p.fldProduct_ID = pi.fldproduct_id
                WHERE p.fldActive = <cfqueryparam value="1" cfsqltype="cf_sql_integer"> 
                AND pi.fldActive = <cfqueryparam value="1" cfsqltype="cf_sql_integer">
                AND pi.fldproduct_id = p.fldProduct_ID
                AND p.fldSubcategoryID = <cfqueryparam value="#arguments.subid#" cfsqltype="cf_sql_integer">
                GROUP BY p.fldProduct_ID, p.fldProductName, p.fldProductTax, p.fldProductPrice, p.fldBrandName, p.fldProductDescription;
            </cfquery>
            
        </cfif>
        <cfreturn { "products": local.selectProducts }>
    </cffunction>

    <cffunction name="getProductsSorted" access="remote" returnFormat="JSON">
        <cfargument name="subid" type="string">
        <cfargument name="sort" type="string">
        <cfif sort EQ 'asc'>
            <cfquery name="local.selectProducts" datasource="sqlDatabase">
                SELECT p.fldProduct_ID, p.fldProductName, ROUND((p.fldProductTax / 100) *p.fldProductPrice +p.fldProductPrice, 2) AS fldProductPrice, p.fldBrandName,
                GROUP_CONCAT(pi.fldimagename) AS fldImageNames, p.fldProductDescription 
                FROM tblproducts p
                INNER JOIN  tblproductimages pi ON p.fldProduct_ID = pi.fldproduct_id
                WHERE p.fldActive = <cfqueryparam value="1" cfsqltype="cf_sql_integer">
                AND p.fldSubcategoryID = <cfqueryparam value="#arguments.subid#" cfsqltype="cf_sql_integer">
                AND pi.fldActive = <cfqueryparam value="1" cfsqltype="cf_sql_integer">
                AND pi.fldproduct_id = p.fldProduct_ID
                GROUP BY p.fldProduct_ID
                ORDER BY p.fldProductPrice ASC;
            </cfquery>

            <cfelse>
                <cfquery name="local.selectProducts" datasource="sqlDatabase" >
                    SELECT p.fldProduct_ID, p.fldProductName, ROUND((p.fldProductTax / 100) *p.fldProductPrice +p.fldProductPrice, 2) AS fldProductPrice, p.fldBrandName,
                    GROUP_CONCAT(pi.fldimagename) AS fldImageNames, p.fldProductDescription 
                    FROM tblproducts p
                    INNER JOIN  tblproductimages pi ON p.fldProduct_ID = pi.fldproduct_id
                    WHERE p.fldActive = <cfqueryparam value="1" cfsqltype="cf_sql_integer">
                    AND p.fldSubcategoryID = <cfqueryparam value="#arguments.subid#" cfsqltype="cf_sql_integer">
                    AND pi.fldActive = <cfqueryparam value="1" cfsqltype="cf_sql_integer">
                    AND pi.fldproduct_id = p.fldProduct_ID
                    GROUP BY p.fldProduct_ID
                    ORDER BY fldProductPrice DESC;
                </cfquery>
        </cfif>
        
        <cfreturn { "products": local.selectProducts }>
    </cffunction>

    <cffunction name="selectProduct" access="remote" returnFormat="JSON">
        <cfargument name="subId" type="any">
        <cfargument name="proId" type="any">
        <cfquery name="local.selectProduct" datasource="sqlDatabase">
            SELECT fldProductName,fldProductDescription,ROUND((fldProductTax / 100) *fldProductPrice +fldProductPrice, 2) AS ProductPrice,fldProductPrice,fldBrandName,fldProductImage,fldProductTax  FROM tblproducts
            WHERE fldSubcategoryID = <cfqueryparam value="#arguments.subId#" cfsqltype="cf_sql_integer">
            AND fldProduct_ID = <cfqueryparam value="#arguments.proId#" cfsqltype="cf_sql_integer">;
        </cfquery>

        <cfquery name="local.selectSubCategory" datasource="sqlDatabase">
            SELECT  tblcategories.fldCategory_name, tblsubcategories.fldSubcategoryName
            FROM tblsubcategories JOIN  tblcategories 
            ON tblsubcategories.fldCategoryID = tblcategories.fldCategory_ID
            WHERE tblsubcategories.fldSubcategory_ID = <cfqueryparam value="#arguments.subId#" cfsqltype="cf_sql_integer">
            AND tblsubcategories.fldActive =  <cfqueryparam value="1" cfsqltype="cf_sql_integer">;
        </cfquery>
        
        <cfreturn { "product": local.selectProduct,"subcategory": local.selectSubCategory}>
    </cffunction>

    <cffunction name="getSingleProduct" access="remote" returnFormat="JSON">
        <cfargument name="proId" type="any">
        <cfquery name="selectProduct" datasource="sqlDatabase">
           SELECT p.fldProduct_ID, p.fldProductName, ROUND((p.fldProductTax / 100) * p.fldProductPrice + p.fldProductPrice, 2) AS fldProductPriceWithTax, p.fldBrandName, GROUP_CONCAT(pi.fldimagename) AS fldImageNames, p.fldProductDescription ,p.fldProductTax ,p.fldProductPrice
            FROM tblproducts p 
            INNER JOIN tblproductimages pi 
            ON p.fldProduct_ID = pi.fldproduct_id
            WHERE p.fldProduct_ID = <cfqueryparam value="#arguments.proId#" cfsqltype="cf_sql_integer">
            AND pi.fldActive = <cfqueryparam value="1" cfsqltype="cf_sql_integer">;
        </cfquery>
        <cfreturn { "product": selectProduct}>
    </cffunction>


    <cffunction name="getProductImages" access="remote" returnFormat="JSON">
        <cfargument name="proID" type="any" required="true">
        
        <cfquery name="local.selectProductImage" datasource="sqlDatabase">
            SELECT fldImageID, fldImageName
            FROM tblproductimages
            WHERE fldProduct_id = <cfqueryparam value="#arguments.proID#" cfsqltype="cf_sql_integer">
            AND fldActive = <cfqueryparam value="1" cfsqltype="cf_sql_integer">
            GROUP BY fldImageID
        </cfquery>
        
        <cfset var imagesArray = []>
        
        <cfloop query="local.selectProductImage">
            <cfset imagesArray.append({
                "FLDIMAGEID" = local.selectProductImage.fldImageID,
                "FLDIMAGENAME" = local.selectProductImage.fldImageName
            })>
        </cfloop>
        <cfreturn imagesArray>
    </cffunction>

    <cffunction name="getSubcategoryName" access="remote" returnFormat="JSON">
        <cfargument name="subid" type="any">
        <cfquery name="selectCategory" datasource="sqlDatabase" result="name">
            SELECT fldSubcategoryName  FROM tblsubcategories
            WHERE fldSubcategory_ID = <cfqueryparam value="#arguments.subid#" cfsqltype="cf_sql_integer">
        </cfquery>
        <cfreturn { "category": selectCategory, "name": name}>
    </cffunction>


    <cffunction name="getRandomProducts" access="remote" returnFormat="JSON">
        <cfquery name="selectProducts" datasource="sqlDatabase" result="Products">
            SELECT p.fldProduct_ID, p.fldProductName, ROUND((p.fldProductTax / 100) * p.fldProductPrice + p.fldProductPrice, 2) AS fldProductPrice, p.fldBrandName,GROUP_CONCAT(pi.fldimagename) AS fldImageNames, p.fldProductDescription 
            FROM  tblproducts p
            INNER JOIN  tblproductimages pi ON p.fldProduct_ID = pi.fldproduct_id
            WHERE p.fldActive = <cfqueryparam value="1" cfsqltype="cf_sql_integer">
            AND pi.fldActive = <cfqueryparam value="1" cfsqltype="cf_sql_integer">
            AND pi.fldproduct_id = p.fldProduct_ID
            GROUP BY p.fldProduct_ID
            ORDER BY RAND()
            LIMIT 4;
        </cfquery>
        <cfreturn { "products": selectProducts }>
    </cffunction>
    

    <cffunction name="getCart" access="remote" returnFormat="JSON">
        <cfargument name="userId" type="string">
        <cfquery name="selectCartItems" datasource="sqlDatabase" result="cartItems">
            SELECT p.fldActive,p.fldProduct_ID, p.fldProductName, ROUND((p.fldProductTax / 100) * p.fldProductPrice + p.fldProductPrice, 2) AS totalCost,p.fldProductPrice,p.fldProductTax, p.fldBrandName,
            GROUP_CONCAT(pi.fldimagename) AS fldimagename, p.fldProductDescription, c.fldQuantity
            FROM tblproducts p 
            INNER JOIN tblcart c ON p.fldProduct_ID = c.fldProductID
            INNER JOIN tblproductimages pi ON p.fldProduct_ID = pi.fldproduct_id
            WHERE c.fldActive = <cfqueryparam value="1" cfsqltype="cf_sql_integer"> 
            AND pi.fldActive = <cfqueryparam value="1" cfsqltype="cf_sql_integer"> 
            AND c.fldUserID = <cfqueryparam value="#arguments.userId#" cfsqltype="cf_sql_integer">
            GROUP BY p.fldProduct_ID ,c.fldQuantity
        </cfquery>
        <cfreturn { "cartItems": selectCartItems }>
    </cffunction>

    <cffunction name="getCartPrice" access="remote" returnFormat="JSON">
        <cfargument name="userId" type="string">
        <cfquery name="selectCartAmount" datasource="sqlDatabase" result="cartamount">
            SELECT SUM(ROUND((p.fldProductTax / 100) * p.fldProductPrice + p.fldProductPrice, 2) * c.fldQuantity) as sum
            FROM tblproducts p
            INNER JOIN tblcart c ON p.fldProduct_ID = c.fldProductID
            WHERE c.fldUserID = <cfqueryparam value="#arguments.userId#" cfsqltype="cf_sql_integer">
            AND c.fldActive = <cfqueryparam value="1" cfsqltype="cf_sql_integer">
        </cfquery>
        
        <cfreturn { "price": selectCartAmount }>
    </cffunction>

    <cffunction name="getCartCount" access="remote" returnFormat="JSON">
        <cfquery name="selectCartCount" datasource="sqlDatabase" result="cartamount">
            SELECT COUNT(fldUserID) AS count
            FROM tblcart
            where fldActive = 1 
            AND fldUserID = <cfqueryparam value="#session.userId#" cfsqltype="cf_sql_integer">;
        </cfquery>
        <cfreturn { "count": selectCartCount }>
    </cffunction>

    <cffunction name="searchProduct" access="remote" returnFormat="JSON">
        <cfargument name='productName' type="any">
        <cfquery name="searchProduct" datasource="sqlDatabase" result="cartamount">
            SELECT p.fldProduct_ID, p.fldProductName ,ROUND((p.fldProductTax / 100) * p.fldProductPrice + p.fldProductPrice, 2) AS fldProductPrice, p.fldBrandName,
                GROUP_CONCAT(pi.fldimagename) AS fldImageNames, p.fldProductDescription 
                FROM tblproducts p
                INNER JOIN  tblproductimages pi ON p.fldProduct_ID = pi.fldproduct_id
                WHERE p.fldProductName LIKE <cfqueryparam value="%#arguments.productName#%" cfsqltype="cf_sql_integer">
                AND pi.fldActive = <cfqueryparam value="1" cfsqltype="cf_sql_integer">
                AND pi.fldproduct_id = p.fldProduct_ID
                AND p.fldActive = <cfqueryparam value="1" cfsqltype="cf_sql_integer">
                GROUP BY p.fldProduct_ID;
        </cfquery>
        <cfreturn { "products": searchProduct }>
    </cffunction>
    
    <cffunction name="searchProductSorted" access="remote" returnFormat="JSON">
        <cfargument name='productName' type="any">
        <cfargument  name="sort" type="string">
        <cfif sort EQ 'asc'>
            <cfquery name="searchProduct" datasource="sqlDatabase" result="cartamount">
                SELECT p.fldProduct_ID, p.fldProductName ,ROUND((p.fldProductTax / 100) * p.fldProductPrice + p.fldProductPrice, 2) AS fldProductPrice, p.fldBrandName,
                GROUP_CONCAT(pi.fldimagename) AS fldImageNames, p.fldProductDescription 
                FROM tblproducts p
                INNER JOIN  tblproductimages pi ON p.fldProduct_ID = pi.fldproduct_id
                WHERE p.fldProductName LIKE <cfqueryparam value="%#arguments.productName#%" cfsqltype="cf_sql_integer">
                AND pi.fldActive = <cfqueryparam value="1" cfsqltype="cf_sql_integer">
                AND pi.fldproduct_id = p.fldProduct_ID
                AND p.fldActive = <cfqueryparam value="1" cfsqltype="cf_sql_integer">
                GROUP BY p.fldProduct_ID
                ORDER BY p.fldProductPrice ASC;
            </cfquery>

            <cfelse>
                <cfquery name="searchProduct" datasource="sqlDatabase" result="cartamount">
                    SELECT p.fldProduct_ID, p.fldProductName ,ROUND((p.fldProductTax / 100) * p.fldProductPrice + p.fldProductPrice, 2) AS fldProductPrice, p.fldBrandName,
                GROUP_CONCAT(pi.fldimagename) AS fldImageNames, p.fldProductDescription 
                FROM tblproducts p
                INNER JOIN  tblproductimages pi ON p.fldProduct_ID = pi.fldproduct_id
                WHERE p.fldProductName LIKE <cfqueryparam value="%#arguments.productName#%" cfsqltype="cf_sql_integer">
                AND pi.fldActive = <cfqueryparam value="1" cfsqltype="cf_sql_integer">
                AND pi.fldproduct_id = p.fldProduct_ID
                AND p.fldActive = <cfqueryparam value="1" cfsqltype="cf_sql_integer">
                GROUP BY p.fldProduct_ID
                    ORDER BY fldProductPrice DESC;
                </cfquery>
        </cfif>
        <cfreturn { "products": searchProduct }>
    </cffunction>

    <cffunction name="getUserDetails" access="remote" returnFormat="JSON">
        <cfquery name="getUserDetails" datasource="sqlDatabase" result="Products">
            SELECT fldUserName ,fldEmail FROM tbluserlogin
            WHERE fldActive = <cfqueryparam value="1" cfsqltype="cf_sql_integer">
            AND fldUser_ID = <cfqueryparam value="#session.userId#" cfsqltype="cf_sql_integer">;
        </cfquery>
        <cfreturn { "data": getUserDetails }>
    </cffunction>

    <cffunction name="getUserAddress" access="remote" returnFormat="JSON">
        <cfquery name="getUserAddress" datasource="sqlDatabase" result="Products">
            SELECT fldAddress_ID ,fldFullname ,fldPhone ,fldPincode ,fldState ,fldCity ,fldBuildingName ,fldArea FROM tblsavedaddress
            WHERE fldActive = <cfqueryparam value="1" cfsqltype="cf_sql_integer">
            AND fldAddressUserID = <cfqueryparam value="#session.userId#" cfsqltype="cf_sql_integer">
            ORDER BY fldAddress_ID DESC;
        </cfquery>
        <cfreturn { "data": getUserAddress }>
    </cffunction>

    <cffunction name="getselectedAddress" access="remote" returnFormat="JSON">
        <cfargument name="addressId" type="any">
        <cfquery name="getselectedAddress" datasource="sqlDatabase" result="Products">
            SELECT fldFullname ,fldPhone ,fldPincode ,fldState ,fldCity ,fldBuildingName ,fldArea FROM tblsavedaddress
            WHERE fldActive = <cfqueryparam value="1" cfsqltype="cf_sql_integer">
            AND fldAddress_ID  = <cfqueryparam value="#arguments.addressId#" cfsqltype="cf_sql_integer">;
        </cfquery>
        <cfreturn { "result": getselectedAddress }>
    </cffunction>

    <cffunction name="getorderHistory" access="remote" returnFormat="JSON">
        <cfquery name="getOrderHistory" datasource="sqlDatabase">
            SELECT o.fldOrder_ID,  o.fldShippingAddress, o.fldOrderDate, op.fldProduct AS fldProduct_ID,op.fldProductQuantity, 
                   ROUND((op.fldProductTax / 100) * op.fldProductPrice + op.fldProductPrice, 2) * op.fldProductQuantity AS totalOrderCost,op.fldProductPrice,op.fldProductTax, p.fldProductName,p.fldProduct_ID, p.fldBrandName, GROUP_CONCAT(pi.fldimagename) AS fldImageNames,
                   a.fldFullname,a.fldPhone,a.fldPincode,a.fldState,a.fldCity,a.fldBuildingName,a.fldArea
            FROM tblorder o
            INNER JOIN tblorderproducts op ON o.fldOrder_ID = op.fldOrderID
            INNER JOIN tblproducts p ON op.fldProduct = p.fldProduct_ID
            INNER JOIN tblproductimages pi ON p.fldProduct_ID = pi.fldproduct_id
            INNER JOIN tblsavedaddress a ON o.fldShippingAddress = a.fldAddress_ID
            WHERE o.fldUserID = <cfqueryparam value="#session.userId#" cfsqltype="cf_sql_integer">
            AND pi.fldproduct_id = p.fldProduct_ID
            GROUP BY o.fldOrder_ID, o.fldShippingAddress, o.fldOrderDate, op.fldProduct, op.fldProductQuantity, p.fldProductName, p.fldBrandName, a.fldFullname,a.fldPhone,a.fldPincode,a.fldState,a.fldCity,a.fldBuildingName,a.fldArea,op.fldProductPrice,op.fldProductTax,p.fldProduct_ID
        </cfquery>
        
        <cfset orderStruct = {}>
        <cfloop query="getOrderHistory">
            <cfset orderID = FLDORDER_ID>
        
            <cfif NOT structKeyExists(orderStruct, orderID)>
                <cfset orderStruct[orderID] = []>
            </cfif>
        
            <cfset local.product = {
                productImage =listToArray(fldImageNames)[1],
                productID = fldProduct_ID,
                productName = fldProductName,
                productQuantity = FLDPRODUCTQUANTITY,
                productBrand = FLDBRANDNAME,
                area = FLDAREA,
                building = FLDBUILDINGNAME,
                city = FLDCITY,
                name = FLDFULLNAME,
                orderDate = FLDORDERDATE,
                orderId = FLDORDER_ID,
                phone = FLDPHONE,
                pincode = FLDPINCODE,
                state = FLDSTATE,
                cost = FLDPRODUCTPRICE,
                tax = FLDPRODUCTTAX,
                totalCost:TOTALORDERCOST
            }>
        
            <cfset ArrayAppend(orderStruct[orderID], product)>
        </cfloop>
        <cfreturn { "result": orderStruct }>
    </cffunction>

    <cffunction name="getorderTotalCost" access="remote" returnFormat="JSON">
        <cfargument name="orderId" type="any">
        <cfquery name="getorderTotalCost" datasource="sqlDatabase" result="Products">
            SELECT sum(ROUND((fldProductTax / 100) * fldProductPrice + fldProductPrice, 2) * fldProductQuantity) as totalCost FROM tblorderproducts
            WHERE fldOrderStatus = <cfqueryparam value="1" cfsqltype="cf_sql_integer">
            AND fldOrderID  = <cfqueryparam value="#arguments.orderId#" cfsqltype="cf_sql_integer">;
        </cfquery>
        <cfreturn { "result": getorderTotalCost }>
    </cffunction>

    <cffunction name="getItemsInOrderID" access="remote" returnFormat="JSON">
        <cfargument name="orderId" type="any">
        <cfquery name="getItemsInOrderID" datasource="sqlDatabase">
            SELECT o.fldShippingAddress, o.fldOrderDate, op.fldProduct AS fldProduct_ID,op.fldProductQuantity, 
                   SUM(ROUND((op.fldProductTax / 100) * op.fldProductPrice + op.fldProductPrice, 2) * op.fldProductQuantity) AS totalOrderCost, p.fldProductName, p.fldBrandName, p.fldProductImage,op.fldProductPrice,op.fldProductTax,
                   a.fldFullname,a.fldPhone,a.fldPincode,a.fldState,a.fldCity,a.fldBuildingName,a.fldArea
            FROM tblorder o
            INNER JOIN tblorderproducts op ON o.fldOrder_ID = op.fldOrderID
            INNER JOIN tblproducts p ON op.fldProduct = p.fldProduct_ID
            INNER JOIN tblsavedaddress a ON o.fldShippingAddress = a.fldAddress_ID
            WHERE o.fldOrder_ID = <cfqueryparam value="#arguments.orderId#" cfsqltype="cf_sql_integer">
            GROUP BY o.fldOrder_ID, o.fldShippingAddress, o.fldOrderDate, op.fldProduct, op.fldProductQuantity, p.fldProductName, p.fldBrandName, p.fldProductImage, op.fldProductPrice, op.fldProductTax
        </cfquery>
        <cfreturn { "result": getItemsInOrderID }>
    </cffunction>

    <cffunction name="getpath" access="remote" returnFormat="JSON">
        <cfargument name="proId" type="any">
        <cfquery name="getpath" datasource="sqlDatabase">
            SELECT p.fldSubcategoryID ,s.fldCategoryID ,c.fldCategory_name ,s.fldSubcategoryName FROM tblproducts p
            INNER JOIN tblsubcategories s ON p.fldSubcategoryID = s.fldSubcategory_ID
            INNER JOIN tblcategories c ON s.fldCategoryID = c.fldCategory_ID
            WHERE fldProduct_ID = <cfqueryparam value="#arguments.proId#" cfsqltype="cf_sql_integer">;
        </cfquery>
        
        <cfreturn { "path": getpath}>
    </cffunction>
</cfcomponent>
