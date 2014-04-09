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
						<a class = "wage_a" href ="wageIns.jsp?type=wage">工资信息 </a>|
						<a class = "wage_a" href ="wageIns.jsp?type=ins">社保信息</a>  |
						<a class = "wage_a" href ="wageIns.jsp?type=fund">公积金信息 </a>|
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
							String selSql = "SELECT wyear,wmonth,soffice,zwwage,jbwage,gwwage,jswage,basicwage,otherwage,"
											+" trywage,tqwage,lifebt,wagebt,ggbt,xjwage,otherbt"
											+" FROM wage A,user2 B WHERE A.jid = B.jid AND B.uid = ? AND wyear = ?";
							PreparedStatement ps = null;
					 %>
					 	<h3>工资信息</h3>
						<span>姓名:<%=session.getAttribute("username")%></span>
						<span>年份:<%=thisyear%>年</span>
						<span class="search_area">
							<input name="year" type="text"/>
							<button name="search">搜索</button>
						</span>
						<table class="showTable">
							<tr class="tablehead">
								<td>序号</td>
								<td>年份</td>
								<td>月份</td>
								<td>科室</td>
								<td>职务工资</td>
								<td>级别工资</td>
								<td>岗位工资</td>
								<td>技术等级工资</td>
								<td>基础工资</td>
								<td>其他工资</td>
								<td>试用期工资</td>
								<td>特区津贴</td>
								<td>生活性补贴</td>
								<td>工资性津贴</td>
								<td>改革性津贴</td>
								<td>薪级工资</td>
								<td>其他津贴</td>
							</tr>
						<%
						try{
								ResultSet rs = null;
								ps = conn.prepareStatement(selSql);
								ps.setString(1,uid);
								ps.setInt(2,thisyear);
								rs = ps.executeQuery();
								i=0;
								while(rs.next()){
									i++;
								%>
									<tr>
										<td><%=i%></td>
										<td><%=rs.getString("wyear") %></td>
										<td><%=rs.getString("wmonth") %></td>
										<td><%=rs.getString("soffice") %></td>
										<td><%=rs.getString("zwwage") %></td>
										<td><%=rs.getString("jbwage") %></td>
										<td><%=rs.getString("gwwage") %></td>
										<td><%=rs.getString("jswage") %></td>
										<td><%=rs.getString("basicwage") %></td>
										<td><%=rs.getString("otherwage") %></td>
										<td><%=rs.getString("trywage") %></td>
										<td><%=rs.getString("tqwage") %></td>
										<td><%=rs.getString("lifebt") %></td>
										<td><%=rs.getString("wagebt") %></td>
										<td><%=rs.getString("ggbt") %></td>
										<td><%=rs.getString("xjwage") %></td>
										<td><%=rs.getString("otherbt") %></td>
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
						}else if("ins".equals(type)){
							//connect the db
							Class.forName("com.mysql.jdbc.Driver");
							Connection conn = DriverManager.getConnection(
								"jdbc:mysql://localhost:3306/hrmsys", "root", "123456");//select info
							String selSql = "SELECT syear,smonth,selfpay,compay,account "
										+" FROM social_ins A,user2 B WHERE A.jid = B.jid AND B.uid = ? AND syear = ?";
							PreparedStatement ps = null;
							i = 0;
						 %>
						 	<h3>社保信息</h3>
							<span>姓名:<%=session.getAttribute("username")%></span>
							<table class="showTable">
								<tr class="tablehead">
									<td>序号</td>
									<td>年份</td>
									<td>月份</td>
									<td>个人缴存</td>
									<td>单位缴存</td>
									<td>个人账户</td>
								</tr>
							<%
							try{
									ResultSet rs = null;
									ps = conn.prepareStatement(selSql);
									ps.setString(1,uid);
									ps.setInt(2,thisyear);
									rs = ps.executeQuery();
									while(rs.next()){
										i++;
									%>
										<tr>
											<td><%=i%></td>
											<td><%=rs.getString("syear") %></td>
											<td><%=rs.getString("smonth") %></td>
											<td><%=rs.getString("selfpay") %></td>
											<td><%=rs.getString("compay") %></td>
											<td><%=rs.getString("account") %></td>
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
						}else if("fund".equals(type)){
							//connect the db
							Class.forName("com.mysql.jdbc.Driver");
							Connection conn = DriverManager.getConnection(
								"jdbc:mysql://localhost:3306/hrmsys", "root", "123456");//select info
							String selSql = "SELECT fyear,fmonth,selfpay,compay,accmoney "
										+" FROM public_fund A,user2 B WHERE A.jid = B.jid AND B.uid = ? AND fyear = ?";
							PreparedStatement ps = null;
							i = 0;
						 %>
						 	<h3>公积金信息</h3>
							<span>姓名:<%=session.getAttribute("username")%></span>
							<table class="showTable">
								<tr class="tablehead">
									<td>序号</td>
									<td>年份</td>
									<td>月份</td>
									<td>个人缴存</td>
									<td>单位缴存</td>
									<td>个人账户余额</td>
								</tr>
							<%
							try{
									ResultSet rs = null;
									ps = conn.prepareStatement(selSql);
									ps.setString(1,uid);
									ps.setInt(2,thisyear);
									rs = ps.executeQuery();
									while(rs.next()){
										i++;
									%>
										<tr>
											<td><%=i%></td>
											<td><%=rs.getString("fyear") %></td>
											<td><%=rs.getString("fmonth") %></td>
											<td><%=rs.getString("selfpay") %></td>
											<td><%=rs.getString("compay") %></td>
											<td><%=rs.getString("accmoney") %></td>
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
