<%@page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.Calendar"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>人事管理系统</title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<script type="text/javascript" src="static/js/jquery-1.7.1.min.js"></script>
		<script type="text/javascript" src="static/js/index.js"></script>
		<script type="text/javascript" src="static/js/validateAUF.js"></script>
		<link rel="stylesheet" type="text/css" href="static/css/global.css" />
		<link rel="stylesheet" type="text/css" href="static/css/menu.css" />
	</head>
	<body>
		<%if(session.getAttribute("uid")!=null){
			String uid = (String)session.getAttribute("uid");
			Calendar ca = Calendar.getInstance();
			ca.setTime(new java.util.Date());
			int thisyear = ca.get(Calendar.YEAR);
			
		%>	
		<jsp:include page="basic/top.jsp"/>
		<div id="main">
			<div class="left">
				<jsp:include page="basic/logo.jsp"/>
				<div class="leftnav">
					<jsp:include page="basic/mainMenu.jsp" />
				</div>
			</div>
			<div id="right">
				<div id="content">
					<div class="wageIns_nav">
						<a class = "wage_a" href ="wageInsMgn.jsp?type=wage">工资信息 </a>|
						<a class = "wage_a" href ="wageInsMgn.jsp?type=ins">社保信息</a>  |
						<a class = "wage_a" href ="wageInsMgn.jsp?type=fund">公积金信息 </a>|
						<hr>
					</div>
					<%
						int i;
						String type = request.getParameter("type");
						if(type==null||"wage".equals(type)){
							//connect the db
							Class.forName("com.mysql.jdbc.Driver");
											Connection conn = DriverManager.getConnection(
													"jdbc:mysql://localhost:3306/hrmsys", "root", "123456");//select info
							String selSql = "SELECT wid,wyear,wmonth,soffice,zwwage,jbwage,gwwage,jswage,basicwage,otherwage,"
											+" trywage,tqwage,lifebt,wagebt,ggbt,xjwage,otherbt,username,B.jid,idno"
											+" FROM wage A,user2 B WHERE A.jid = B.jid AND wyear = ? ORDER BY wmonth DESC";
							PreparedStatement ps = null;
					 %>
					 	<h3>工资信息</h3>
						<span>年份:<%=thisyear%>年</span>
						<span class="search_area">
							<input name="year" type="text"/>
							<button name="search">搜索</button>
						</span>
						<table class="wage_table">
							<tr class="tablehead">
								<td>序号</td>
								<td>姓名</td>
								<td>工作证号</td>
								<td>身份证</td>
								<td>年份</td>
								<td>月份</td>
								<td>科室</td>
								<td>职务工资</td>
								<td>级别工资</td>
								<td>岗位工资</td>
								<td>技术等级工资</td>
								<td>基础工资</td>
								<td colspan = 2>操作</td>
							</tr>
						<%
						try{
								ResultSet rs = null;
								ps = conn.prepareStatement(selSql);
								ps.setInt(1,thisyear);
								rs = ps.executeQuery();
								i=0;
								while(rs.next()){
									i++;
								%>
									<tr>
										<td><%=i%></td>
										<td><a href="wageInsView.jsp?type=wage&id=<%=rs.getString("wid")%>"><%=rs.getString("username")%></a></td>
										<td><%=rs.getString("B.jid") %></td>
										<td><%=rs.getString("idno") %></td>
										<td><%=rs.getString("wyear") %></td>
										<td><%=rs.getString("wmonth") %></td>
										<td><%=rs.getString("soffice") %></td>
										<td><%=rs.getString("zwwage") %></td>
										<td><%=rs.getString("jbwage") %></td>
										<td><%=rs.getString("gwwage") %></td>
										<td><%=rs.getString("jswage") %></td>
										<td><%=rs.getString("basicwage") %></td>
										<td> <a href="wageInsUpd.jsp?type=wage&id=<%=rs.getString("wid")%>">编辑</a> </td>
										<td><a href="wageInsMgn.jsp?type=wage&del=<%=rs.getString("wid")%>">删除</a> </td>
									</tr>
								<% 
								}
								%>
								</table>
								<% 	
								rs.close();			
						}catch(SQLException e){
							e.printStackTrace();
						}finally{
							ps.close();
							conn.close();
						}
						}else if("ins".equals(type)){
							//connect the db
							Class.forName("com.mysql.jdbc.Driver");
							Connection conn = DriverManager.getConnection(
								"jdbc:mysql://localhost:3306/hrmsys", "root", "123456");//select info
							String selSql = "SELECT sid,syear,smonth,selfpay,compay,account,username,B.jid,idno"
										+" FROM social_ins A,user2 B WHERE A.jid = B.jid AND syear = ? ORDER BY smonth DESC";
							PreparedStatement ps = null;
							i = 0;
						 %>
						 	<h3>社保信息</h3>
						 	<span>年份:<%=thisyear%>年</span>
							<span class="search_area">
								<input name="year" type="text"/>
								<button name="search">搜索</button>
							</span>
							<table class="showTable">
								<tr class="tablehead">
									<td>序号</td>
									<td>姓名</td>
									<td>工作证号</td>
									<td>身份证</td>
									<td>年份</td>
									<td>月份</td>
									<td>个人缴存</td>
									<td>单位缴存</td>
									<td>个人账户</td>
									<td colspan = 2>操作</td>
								</tr>
							<%
							try{
									ResultSet rs = null;
									ps = conn.prepareStatement(selSql);
									ps.setInt(1,thisyear);
									rs = ps.executeQuery();
									while(rs.next()){
										i++;
									%>
										<tr>
											<td><%=i%></td>
											<td><a href="wageInsView.jsp?type=ins&id=<%=rs.getString("sid")%>"><%=rs.getString("username") %></a></td>
											<td><%=rs.getString("B.jid") %></td>
											<td><%=rs.getString("idno") %></td>
											<td><%=rs.getString("syear") %></td>
											<td><%=rs.getString("smonth") %></td>
											<td><%=rs.getString("selfpay") %></td>
											<td><%=rs.getString("compay") %></td>
											<td><%=rs.getString("account") %></td>
											<td><a href="wageInsUpd.jsp?type=ins&id=<%=rs.getString("sid")%>">编辑</a></td>
											<td><a href="wageInsMgn.jsp?type=ins&del=<%=rs.getString("sid")%>">删除</a></td>
										</tr>
									<% 
									}
									%>
									</table>
									<% 	
									rs.close();			
							}catch(SQLException e){
								e.printStackTrace();
							}finally{
								ps.close();
								conn.close();
							}
						}else if("fund".equals(type)){
							//connect the db
							Class.forName("com.mysql.jdbc.Driver");
							Connection conn = DriverManager.getConnection(
								"jdbc:mysql://localhost:3306/hrmsys", "root", "123456");//select info
							String selSql = "SELECT fid,fyear,fmonth,selfpay,compay,accmoney,username,B.jid,idno "
										+" FROM public_fund A,user2 B WHERE A.jid = B.jid AND fyear = ? ORDER BY fmonth DESC";
							PreparedStatement ps = null;
							i = 0;
						 %>
						 	<h3>公积金信息</h3>
						 	<span>年份:<%=thisyear%>年</span>
							<span class="search_area">
								<input name="year" type="text"/>
								<button name="search">搜索</button>
							</span>
							<table class="showTable">
								<tr class="tablehead">
									<td>序号</td>
									<td>姓名</td>
									<td>工作证号</td>
									<td>身份证</td>
									<td>年份</td>
									<td>月份</td>
									<td>个人缴存</td>
									<td>单位缴存</td>
									<td>个人账户余额</td>
									<td>操作</td>
								</tr>
							<%
							try{
									ResultSet rs = null;
									ps = conn.prepareStatement(selSql);
									ps.setInt(1,thisyear);
									rs = ps.executeQuery();
									while(rs.next()){
										i++;
									%>
										<tr>
											<td><%=i%></td>
											<td><a href="wageInsView.jsp?type=fund&id=<%=rs.getString("fid")%>"><%=rs.getString("username") %></a></td>
											<td><%=rs.getString("B.jid") %></td>
											<td><%=rs.getString("idno") %></td>
											<td><%=rs.getString("fyear") %></td>
											<td><%=rs.getString("fmonth") %></td>
											<td><%=rs.getString("selfpay") %></td>
											<td><%=rs.getString("compay") %></td>
											<td><%=rs.getString("accmoney") %></td>
											<td><a href="wageInsUpd.jsp?type=fund&id=<%=rs.getString("fid")%>">编辑</a></td>
											<td><a href="wageInsMgn.jsp?type=fund&del=<%=rs.getString("fid")%>">删除</a></td>
										</tr>
									<% 
									}	
									rs.close();			
							}catch(SQLException e){
								e.printStackTrace();
							}finally{
								ps.close();
								conn.close();
							}
						}
						%>
						</table>
				</div>
			</div>
		</div>
		<div id="footer">
		</div>
		<%}else{
			response.sendRedirect("login.jsp");
		} %>
	</body>
</html>
