<cfoutput>
<!-- Category List -->
<div class="row">
  <div class="container-fluid bg-dark text-light px-5">
    <div class="d-flex">
      <ul class="navbar-nav w-100 d-flex flex-row justify-content-between">
        <cfset local.categorylist = application.getlistObj.getCategories()>
        <cfloop query="local.categorylist.categories">
          <li class="nav-item categ-head position-relative">
            <a class="nav-link category-list-items" href="categoryProduct.cfm?cateid=#FLDCATEGORY_ID#" role="button" aria-expanded="false" cate-id="#FLDCATEGORY_ID#">
              #FLDCATEGORY_NAME#
            </a>
            <ul class="dropdown-menu list-group-item-primary position-absolute" cate-id="#FLDCATEGORY_ID#">
              <cfset local.subcategorylist = application.getlistObj.getSubCategories(FLDCATEGORY_ID)>
              <cfloop query="local.subcategorylist.subcategories">
                <li class="subcategory-item" sub-id="#FLDSUBCATEGORY_ID#">
                  <a class="dropdown-item" href="userProductList.cfm?subid=#FLDSUBCATEGORY_ID#">#FLDSUBCATEGORYNAME#</a>
                </li>
              </cfloop>
            </ul>
          </li>
        </cfloop>
      </ul>
    </div>
  </div>
</div>
</cfoutput>