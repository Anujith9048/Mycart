<cfoutput>
<div class="row">
  <div class="container-fluid bg-success text-light px-5">
    <div class="d-flex">
      <ul class="navbar-nav w-100 d-flex flex-row justify-content-between">
        <cfset local.categorylist = application.getlistObj.getCategories()>
        <cfloop query="local.categorylist.categories">
          <li class="nav-item categ-head position-relative">
            <a class="nav-link category-list-items" href="categoryProduct.cfm?cateid=#local.categorylist.categories.FLDCATEGORY_ID#" role="button" aria-expanded="false" cate-id="#local.categorylist.categories.FLDCATEGORY_ID#">
              #local.categorylist.categories.FLDCATEGORY_NAME#
            </a>
            <ul class="dropdown-menu position-absolute" cate-id="#FLDCATEGORY_ID#">
              <cfset local.subcategorylist = application.getlistObj.getSubCategories(FLDCATEGORY_ID)>
              <cfloop query="local.subcategorylist.subcategories">
                <li class="subcategory-item" sub-id="#local.subcategorylist.subcategories.FLDSUBCATEGORY_ID#">
                  <a class="dropdown-item btn btn-outline-success" href="userProductList.cfm?subid=#local.subcategorylist.subcategories.FLDSUBCATEGORY_ID#">#local.subcategorylist.subcategories.FLDSUBCATEGORYNAME#</a>
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