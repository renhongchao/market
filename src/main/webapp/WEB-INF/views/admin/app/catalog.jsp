<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/commons/taglibs.jsp"%>
<!DOCTYPE html>
<html>
	<head>
		
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<%@ include file="/WEB-INF/views/commons/easyui.jsp"%>
		<script type="text/javascript" src="${ctx}/resources/public/scripts/common.js?v1.2" ></script>
		<script type="text/javascript">
		$(function(){
			checkEditControl('${ctx}/back/permission/account?baseUri=/admin/app/catalog');
			$('#descTabs').tabs({onSelect:function(title){
				$(this).tabs('getSelected').show()
			}});
			$('#status').combobox({
				data:statusList,
				editable:false,
				valueField:'fieldValue',
				textField:'displayValue'
			});
			$('#status_edit').combobox({
				data:statusList,
				editable:false,
				valueField:'fieldValue',
				textField:'displayValue'
			});
			checkExisted($('#name_edit'),'${ctx}/portal/check/catalog?local=cn&name=');
			checkExisted($('#enName_edit'),'${ctx}/portal/check/catalog?local=en&name=');
			$('.combobox-f').each(function(){
				$(this).combobox('clear');
			});
		});
		function edit(index) {
			if(index>-1){//双击
				// clear selected
				$('#tt').datagrid('clearSelections');
				$('#tt').datagrid('selectRow',index); //让双击行选定
			}
			var m = $('#tt').datagrid('getSelected');
			if (m) {
				$('#editForm input').each(function(){
					$(this).removeClass('validatebox-invalid');
				});
				$('#editWin').window({title:'修改'+winTitle,iconCls:'icon-edit'});
				$('#editWin').window('open');
				// init data
				$('#name_edit').val(m.name);
				$('#enName_edit').val(m.enName);
				$('#displayIndex_edit').numberspinner('setValue',m.displayIndex);
				$('#status_edit').combobox('setValue',m.status);
				//$('#status_edit').val(m.status);			
				$('#description').val(m.description);
				$('#enDescription').val(m.enDescription);
				$('#id').val(m.id);
				$('#editWin').show();
			} else {
				$.messager.show({
					title : '警告',
					msg : '请先选择要修改的记录。'
				});
			}
		}

		</script>
		<style>
		#editWin label {width: 115px;}
		#editWin input {width: 295px;}
		#editWin textarea {width: 368px;height: 58px;}
		</style>
	</head>
	<body>
		<div style="width: 100%;">
		<form:form modelAttribute="appCatalog"
			action="${ctx}/admin/app/catalog/query"
			method="get" id="searchForm">
			<table>
				<tr>
					<td>
						<form:label for="name" path="name">邮箱：</form:label>
					</td>
					<td>
						<form:input path="name"/>
					</td>
					<td>
						<form:label for="displayIndex" path="displayIndex">显示顺序：</form:label>
					</td>
					<td>
						<form:input path="displayIndex"  cssClass="easyui-numberspinner"  min="1" max="1000" />
					</td>
					<td>
						<form:label for="status" path="status">状态：</form:label>
					</td>
					<td>
						<form:input path="status" />
					</td>
				</tr>
			</table>
		</form:form>
		<div style="text-align: center; padding: 5px;">
				<a href="javascript:void(0);" class="easyui-linkbutton" id="submit"
					iconCls="icon-search">查 询</a>
				<a href="javascript:void();" class="easyui-linkbutton" id="reset"
					iconCls="icon-undo">重 置</a>
			</div>
			<table id="tt" style="height: auto;" iconCls="icon-blank" title="应用分类列表" align="left"   
			idField="id" url="${ctx}/admin/app/catalog/query" pagination="true" rownumbers="true"
			fitColumns="true" pageList="[ 5, 10]" sortName="displayIndex" sortOrder="asc">
				<thead>
					<tr>
						<th field="ck" checkbox="true"></th>
						<th field="name" width="150" align="center">分类名称</th>
						<th field="enName" width="150" align="center">英文名称</th>
						<th field="description" width="200" align="center">中文描述</th>
						<th field="enDescription" width="200" align="center">英文描述</th>
						<th field="displayIndex" width="60" align="center" >显示顺序</th>
						<th field="status" width="60" align="center" formatter="statusFormatter">状态</th>
						<th field="createTime" width="100" align="center">创建时间</th>
						<th field="updateTime" width="100" align="center">更新时间</th>
					</tr>
				</thead>
			</table>
		</div>
		<div id="editWin" class="easyui-window" title="应用分类" closed="true" style="width:480px;height:380px;padding:5px;" modal="true">
			<form:form modelAttribute="appCatalog" id="editForm" action="${ctx}/admin/app/catalog/save" method="post" cssStyle="padding:10px 20px;">
				<table>
					<tr>
						<td><form:label	for="name" path="name"  cssClass="mustInput">分类名称：</form:label></td>
						<td><form:input path="name" id="name_edit" cssClass="easyui-validatebox" required="true"/></td>
					</tr>
					<tr>
						<td><form:label	for="enName" path="enName"  cssClass="mustInput">英文名称：</form:label></td>
						<td><form:input path="enName" id="enName_edit" cssClass="easyui-validatebox" required="true"/></td>
					</tr>
					<tr>
						<td><form:label for="displayIndex" path="displayIndex" cssClass="mustInput">顺序：</form:label></td>
						<td><form:input path="displayIndex" id="displayIndex_edit" cssClass="easyui-numberspinner"  min="1" max="1000" required="true" validType="number"  cssStyle="width:295px;"/></td>
					</tr>
					<tr>
						<td><form:label	for="status" path="status" cssClass="mustInput">状态：</form:label></td>
						<td>
							<form:input path="status" id="status_edit" required="true"/>
						</td>
					</tr>
					<tr>
						<td><form:label	for="description" path="description" cssClass="easyui-validatebox">描述：</form:label></td>
					</tr>
					<tr>
						<td colspan="2">
							<div id="descTabs" class="easyui-tabs" style="width:380px;height:95px;">  
								<div title="中文" style="padding:3px;">  
									<form:textarea path="description"  class="easyui-validatebox"  validType="maxLength[50]" maxLen="50" msg="中文描述"/>
								</div>  
								<div title="英文" style="overflow:auto;padding:3px;display:none;">  
									<form:textarea path="enDescription"  class="easyui-validatebox" validType="maxLength[50]" maxLen="50" msg="英文描述"/>
								</div> 
							</div> 
						</td>
					</tr>
				</table>
				<form:hidden path="id"/>
				<div style="text-align: center; padding: 5px;">
					<a href="javascript:void(0)" class="easyui-linkbutton" id="edit_submit"
						iconCls="icon-save">保 存</a>
					<a href="javascript:void(0)" class="easyui-linkbutton" id="edit_reset"
						iconCls="icon-undo">重 置</a>
				</div>
			</form:form>
		</div>
	</body>
</html>