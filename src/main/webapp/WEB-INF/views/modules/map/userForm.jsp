<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>用户注册</title>
<meta name="decorator" content="webDefault" />
<script type="text/javascript">
	$(document)
			.ready(
					function() {
						$("#loginName").focus();
						$("#inputForm")
								.validate(
										{
											rules : {
												loginName : {
													remote : "${ctxFront}/user/checkLoginName?oldLoginName="
															+ encodeURIComponent('${user.loginName}')
												}
											},
											messages : {
												loginName : {
													remote : "用户登录名已存在"
												},
												confirmNewPassword : {
													equalTo : "输入与上面相同的密码"
												}
											}
										});
					});
</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctxFront}/user/form?id=${user.id}">用户<shiro:hasPermission
					name="sys:user:edit">修改</shiro:hasPermission><shiro:lacksPermission name="sys:user:edit">注册</shiro:lacksPermission>
		</a>
		</li>
	</ul>
	<br />

	<form:form id="inputForm" modelAttribute="user"
		action="${ctxFront}/user/save" method="post" class="form-horizontal">
		<form:hidden path="id" />
		<tags:message content="${message}" />
		<div class="control-group">
			<input id="companyId" class="required" type="hidden" value="1" name="company.id">
			<input id="officeId" class="required" type="hidden" value="1" name="office.id">
			<label class="control-label" for="oldLoginName">登录名:</label>
			<div class="controls">
				<input id="oldLoginName" name="oldLoginName" type="hidden"
					value="${user.loginName}">
				<form:input path="loginName" htmlEscape="false" maxlength="50"
					class="required userName" />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="name">公司名:</label>
			<div class="controls">
				<form:input path="name" htmlEscape="false" maxlength="50"
					class="required" />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="newPassword">密码:</label>
			<div class="controls">
				<input id="newPassword" name="newPassword" type="password" value=""
					maxlength="50" minlength="3" class="${empty user.id?'required':''}" />
				<c:if test="${not empty user.id}">
					<span class="help-inline">若不修改密码，请留空。</span>
				</c:if>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="confirmNewPassword">确认密码:</label>
			<div class="controls">
				<input id="confirmNewPassword" name="confirmNewPassword"
					type="password" value="" maxlength="50" minlength="3"
					equalTo="#newPassword" />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="email">邮箱:</label>
			<div class="controls">
				<form:input path="email" htmlEscape="false" maxlength="100"
					class="email" />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="phone">电话:</label>
			<div class="controls">
				<form:input path="phone" htmlEscape="false" maxlength="100" />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="mobile">手机:</label>
			<div class="controls">
				<form:input path="mobile" htmlEscape="false" maxlength="100" />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="remarks">备注:</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="3"
					maxlength="200" class="input-xlarge" />
			</div>
		</div>
		<div class="control-group" style="display:none">
			<label class="control-label" for="roleIdList">用户角色:</label>
			<div class="controls">
				<form:checkboxes path="roleIdList" items="${allRoles}"
					itemLabel="name" itemValue="id" htmlEscape="false" class="required" />
			</div>
		</div>
		<c:if test="${not empty user.id}">
			<div class="control-group">
				<label class="control-label">创建时间:</label>
				<div class="controls">
					<label class="lbl"><fmt:formatDate
							value="${user.createDate}" type="both" dateStyle="full" />
					</label>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">最后登陆:</label>
				<div class="controls">
					<label class="lbl">IP:
						${user.loginIp}&nbsp;&nbsp;&nbsp;&nbsp;时间：<fmt:formatDate
							value="${user.loginDate}" type="both" dateStyle="full" />
					</label>
				</div>
			</div>
		</c:if>
		<div class="form-actions">
			<input id="btnSubmit" class="btn btn-primary" type="submit"
					value="保 存" />&nbsp;
			<input id="btnCancel" class="btn" type="button" value="返 回"
				onclick="history.go(-1)" />
		</div>
	</form:form>
</body>
</html>