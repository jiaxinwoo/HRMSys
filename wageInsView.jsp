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
			//get thisyear
			Calendar ca = Calendar.getInstance();
			ca.setTime(new java.util.Date());
			int thisyear = ca.get(Calendar.YEAR);
			//get type and id
			String type = request.getParameter("type");
			
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
		<%
			if(type != null&& (request.getParameter("id")) != null){
				int id = Integer.parseInt(request.getParameter("id"));
				if("wage".equals(type)){
					//connect the db
					Class.forName("com.mysql.jdbc.Driver");
					Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hrmsys", "root", "123456");
					//select info
					String selSql = "SELECT wyear,wmonth,soffice,zwwage,jbwage,gwwage,jswage,basicwage,otherwage,"
								+" trywage,tqwage,lifebt,wagebt,ggbt,xjwage,otherbt,username,B.jid,idno"
								+" FROM wage A,user2 B WHERE A.jid = B.jid AND wid = ?";
					PreparedStatement ps = null;
					try{
								ResultSet rs = null;
								ps = conn.prepareStatement(selSql);
								ps.setInt(1,id);
								rs = ps.executeQuery();
								if(rs.next()){
		%>	
					 	<h3>工资信息</h3>
						<table>
							<tr>
								<td class="item_name">姓名:</td><td class="item_value"><%=rs.getString("username")%></td>
								<td class="item_name">工作证号:</td><td class="item_value"><%=rs.getString("B.jid")%></td>
							</tr>
							<tr>
								<td class="item_name">身份证:</td><td class="item_value"><%=rs.getString("idno")%></td>
								<td class="item_name">年份:</td><td class="item_value"><%=rs.getString("wyear")%></td>
							</tr>
							<tr>
								<td class="item_name">月份:</td><td class="item_value"><%=rs.getString("wmonth")%></td>
								<td class="item_name">科室:</td><td class="item_value"><%=rs.getString("soffice")%></td>
							</tr>
							<tr>
								<td class="item_name">职务工资:</td><td class="item_value"><%=rs.getString("zwwage")%></td>
								<td class="item_name">级别工资:</td><td class="item_value"><%=rs.getString("jbwage")%></td>
							</tr>
							<tr>
								<td class="item_name">岗位工资:</td><td class="item_value"><%=rs.getString("gwwage")%></td>
								<td class="item_name">技术等级工资:</td><td class="item_value"><%=rs.getString("jswage")%></td>
							</tr>
							<tr>
								<td class="item_name">基础工资:</td><td class="item_value"><%=rs.getString("basicwage")%></td>
								<td class="item_name">其他工资:</td><td class="item_value"><%=rs.getString("otherwage")%></td>
							</tr>
							<tr>
								<td class="item_name">试用期工资:</td><td class="item_value"><%=rs.getString("trywage")%></td>
								<td class="item_name">特区津贴:</td><td class="item_value"><%=rs.getString("tqwage")%></td>
							</tr>
							<tr>
								<td class="item_name">生活性补贴:</td><td class="item_value"><%=rs.getString("lifebt")%></td>
								<td class="item_name">工资性津贴:</td><td class="item_value"><%=rs.getString("wagebt")%></td>
							</tr>
							<tr>
								<td class="item_name">改革性津贴:</td><td class="item_value"><%=rs.getString("ggbt")%></td>
								<td class="item_name">薪级工资:</td><td class="item_value"><%=rs.getString("xjwage")%></td>
							</tr>
							<tr>
								<td class="item_name">其他津贴:</td><td class="item_value"><%=rs.getString("otherbt")%></td>
							</tr>
							<tr>
								<td class="item_name"></td><td class="item_value"><input type="button" onclick="history.back()" value="返回"></td>
							</tr>
						</table>
						<%
						}else{
							out.println("所查找记录不存在，请确认");
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
							String selSql = "SELECT syear,smonth,selfpay,compay,account,username,B.jid,idno"
										+" FROM social_ins A,user2 B WHERE A.jid = B.jid AND sid = ?";
							PreparedStatement ps = null;
							try{
								ResultSet rs = null;
								ps = conn.prepareStatement(selSql);
								ps.setInt(1,id);
								rs = ps.executeQuery();
								if(rs.next()){
						%>
						 	<h3>社保信息</h3>
							<table>
								<tr>
									<td class="item_name">姓名:</td><td class="item_value"><%=rs.getString("username")%></td>
									<td class="item_name">工作证号:</td><td class="item_value"><%=rs.getString("B.jid")%></td>
								</tr>
								<tr>
									<td class="item_name">身份证:</td><td class="item_value"><%=rs.getString("idno")%></td>
									<td class="item_name">年份:</td><td class="item_value"><%=rs.getString("syear")%></td>
								</tr>
								<tr>
									<td class="item_name">月份:</td><td class="item_value"><%=rs.getString("smonth")%></td>
									<td class="item_name">个人缴存:</td><td class="item_value"><%=rs.getString("selfpay")%></td>
								</tr>
								<tr>
									<td class="item_name">单位缴存:</td><td class="item_value"><%=rs.getString("compay")%></td>
									<td class="item_name">个人账户:</td><td class="item_value"><%=rs.getString("account")%></td>
								</tr>
								<tr>
									<td class="item_name"></td><td class="item_value"><input type="button" onclick="history.back()" value="返回"></td>
								</tr>
							</table>
							<%
							}else{
								out.println("所查找记录不存在，请确认");
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
							String selSql = "SELECT fyear,fmonth,selfpay,compay,accmoney,username,B.jid,idno "
										+" FROM public_fund A,user2 B WHERE A.jid = B.jid AND fid =?";
							PreparedStatement ps = null;
							try{
								ResultSet rs = null;
								ps = conn.prepareStatement(selSql);
								ps.setInt(1,id);
								rs = ps.executeQuery();
								if(rs.next()){
						%>
						 	<h3>公积金信息</h3>
							<table>
								<tr>
									<td class="item_name">姓名:</td><td class="item_value"><%=rs.getString("username")%></td>
									<td class="item_name">工作证号:</td><td class="item_value"><%=rs.getString("B.jid")%></td>
								</tr>
								<tr>
									<td class="item_name">身份证:</td><td class="item_value"><%=rs.getString("idno")%></td>
									<td class="item_name">年份:</td><td class="item_value"><%=rs.getString("fyear")%></td>
								</tr>
								<tr>
									<td class="item_name">月份:</td><td class="item_value"><%=rs.getString("fmonth")%></td>
									<td class="item_name">个人缴存:</td><td class="item_value"><%=rs.getString("selfpay")%></td>
								</tr>
								<tr>
									<td class="item_name">单位缴存:</td><td class="item_value"><%=rs.getString("compay")%></td>
									<td class="item_name">个人账户余额:</td><td class="item_value"><%=rs.getString("accmoney")%></td>
								</tr>
								<tr>
									<td class="item_name"></td><td class="item_value"><input type="button" onclick="history.back()" value="返回"></td>
								</tr>
							</table>
							<%
							}else{
								out.println("所查找记录不存在，请确认");
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
				</div>
			</div>
		</div>
		<div id="footer">
		</div>
		<%
		}
		}else{
			response.sendRedirect("login.jsp");
		} %>
	</body>
</html>
