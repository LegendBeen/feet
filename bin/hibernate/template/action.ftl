<#--${pojo.getPackageDeclaration()}-->
package com.shh.org.cms.web.site;
<#assign classbody>
<#assign declarationName = pojo.importType(pojo.getDeclarationName())>
<#assign entityName = declarationName?uncap_first>
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import org.apache.struts2.ServletActionContext;
import org.apache.commons.lang.StringUtils;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;
import org.springside.modules.orm.Page;
import org.springside.modules.orm.PropertyFilter;
import org.springside.modules.orm.hibernate.HibernateWebUtils;
import org.springside.modules.web.struts2.Struts2Utils;
import com.shh.org.cms.dao.site.${declarationName}Manager;
import com.shh.org.cms.service.ServiceException;
import com.shh.org.cms.utils.EasyTreeUtil;
import com.shh.org.cms.utils.JsonUtil;


@Namespace("/admin/site")
@Results( { @Result(name = CrudActionSupport.RELOAD, location = "${declarationName[0..1]?uncap_first}-${declarationName[2..]?uncap_first}.action", type = "redirect") })
public class ${declarationName}Action extends ${pojo.importType("com.shh.org.cms.web.CrudActionSupport")}<${declarationName}> {

	private static final long serialVersionUID = 1L;
	
	@Autowired
	private ${declarationName}Manager ${entityName}Manager;
	
	private ${declarationName} entity;

	public ${declarationName} getModel() {
		// TODO Auto-generated method stub
		return entity;
	}

	@Override
	public String deleteBatch() throws Exception {
		try {
			${entityName}Manager.deleteBatch(getIds());
			addActionMessage(getText("common.success"));
		} catch (ServiceException e) {
			logger.error(e.getMessage(), e);
			addActionMessage(getText("common.fail"));
		}
		return RELOAD;
	}

	@Override
	public String list() throws Exception {
		List<PropertyFilter> filters = HibernateWebUtils.buildPropertyFilters(Struts2Utils.getRequest());
		String sortField = Struts2Utils.getParameter("sort");
		String order = Struts2Utils.getParameter("order");
		String pageNo = Struts2Utils.getParameter("page");
		String rows = Struts2Utils.getParameter("rows");
		if (pageNo != null) {
			page.setPageNo(Integer.valueOf(pageNo));
		}
		if (rows != null) {
			page.setPageSize(Integer.valueOf(rows));
		}
		// 设置默认排序方式，按实际字段修改，放开下方的注释
		if (StringUtils.isEmpty(sortField)) {
			//page.setOrderBy("排序字段名");
			//page.setOrder(Page.ASC);
		} else {
			//page.setOrderBy(sortField + ",排序字段名");
			//page.setOrder(order + "," + Page.ASC);
		}
		page = ${entityName}Manager.findPage(page, filters);
		JsonUtil.renderJson(page, new String[] { "" });
		return null;
	}

	@Override
	public String input() throws Exception {
		return INPUT;
	}

	@Override
	public String save() throws Exception {
		try {
			${entityName}Manager.save${declarationName}(entity);
			Struts2Utils.renderHtml(entity.get${declarationName}Id());
		} catch (ServiceException e) {
			logger.error(e.getMessage(), e);
			addActionMessage(getText("common.fail"));
		}
		return null;
	}

	@Override
	public String delete() throws Exception {
		try {
			${entityName}Manager.delete${declarationName}(getId());
			addActionMessage(getText("common.success"));
		} catch (ServiceException e) {
			logger.error(e.getMessage(), e);
			addActionMessage(getText("common.fail"));
		}
		return RELOAD;
	}

	@Override
	protected void prepareModel() throws Exception {
		if (getId() != null) {
			entity = ${entityName}Manager.getEntity(getId());
		} else {
			entity = new ${declarationName}();
		}
		
	}
	
	public String isExists(){
		HttpServletRequest request = ServletActionContext.getRequest();
		String newValue = request.getParameter("newValue").trim();
		String oldValue = request.getParameter("oldValue").trim();
		String fieldName = request.getParameter("fieldName").trim();
		if (${entityName}Manager.isPropertyUnique(fieldName, newValue, oldValue)) {
			Struts2Utils.renderText("true");
		} else {
			Struts2Utils.renderText("false");
		}
		return null;
	}
}
</#assign>

${pojo.generateImports()}
import ${pojo.getQualifiedDeclarationName()};

${classbody}
