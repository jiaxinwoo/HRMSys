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
			int uid = Integer.parseInt((String)session.getAttribute("uid"));
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
			if(type != null&& (request.getParameter("id").trim()) != null){
				int id = Integer.parseInt(request.getParameter("id").trim());
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
					 	<form name= "wageUpdForm" method="post" action="wageInsUpd.jsp">
							<table class="wage_table">
								<tr>
									<td class="item_name">姓名:</td><td class="item_value"><%=rs.getString("username")%></td>
									<td class="item_name">工作证号:</td><td class="item_value"><%=rs.getString("B.jid")%></td>
								</tr>
								<tr>
									<td class="item_name">身份证:</td><td class="item_value"><%=rs.getString("idno")%></td>
									<td class="item_name">年份:</td><td class="item_value"><input name="wyear" value="<%=rs.getString("wyear")%>"></td>
								</tr>
								<tr>
									<td class="item_name">月份:</td><td class="item_value"><input name="wmonth" value="<%=rs.getString("wmonth")%>"></td>
									<td class="item_name">科室:</td><td class="item_value"><input name="soffice" value="<%=rs.getString("soffice")%>"></td>
								</tr>
								<tr>
									<td class="item_name">职务工资:</td><td class="item_value"><input name="zwwage" value="<%=rs.getString("zwwage")%>"></td>
									<td class="item_name">级别工资:</td><td class="item_value"><input name="jbwage" value="<%=rs.getString("jbwage")%>"></td>
								</tr>
								<tr>
									<td class="item_name">岗位工资:</td><td class="item_value"><input name="gwwage" value="<%=rs.getString("gwwage")%>"></td>
									<td class="item_name">技术等级工资:</td><td class="item_value"><input name="jswage" value="<%=rs.getString("jswage")%>"></td>
								</tr>
								<tr>
									<td class="item_name">基础工资:</td><td class="item_value"><input name="basicwage" value="<%=rs.getString("basicwage")%>"></td>
									<td class="item_name">其他工资:</td><td class="item_value"><input name="otherwage" value="<%=rs.getString("otherwage")%>"></td>
								</tr>
								<tr>
									<td class="item_name">试用期工资:</td><td class="item_value"><input name="trywage" value="<%=rs.getString("trywage")%>"></td>
									<td class="item_name">特区津贴:</td><td class="item_value"><input name="tqwage" value="<%=rs.getString("tqwage")%>"></td>
								</tr>
								<tr>
									<td class="item_name">生活性补贴:</td><td class="item_value"><input name="lifebt" value="<%=rs.getString("lifebt")%>"></td>
									<td class="item_name">工资性津贴:</td><td class="item_value"><input name="wagebt" value="<%=rs.getString("wagebt")%>"></td>
								</tr>
								<tr>
									<td class="item_name">改革性津贴</td><td class="item_value"><input name="ggbt" value="<%=rs.getString("ggbt")%>"></td>
									<td class="item_name">薪级工资</td><td class="item_value"><input name="xjwage" value="<%=rs.getString("xjwage")%>"></td>
								</tr>
								<tr>
									<td class="item_name">其他津贴</td><td class="item_value"><input name="otherbt" value="<%=rs.getString("otherbt")%>"></td>
								</tr>
								<tr>
									<td class="item_name"></td><td class="item_value"><input type="hidden" name="wid" value="<%=id%>"></td>
								</tr>
								<tr>
									<td class="item_name"></td><td class="item_value"><input type="submit" name="wsubmit" value="修改"></td>
									<td class="item_name"><input type="button" name="back" value="返回" onclick="history.back()"></td><td class="item_value"></td>
								</tr>
							</table>
						</form>
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
						 	<form name="insUpdForm" method="post" action="wageInsUpd.jsp">
								<table class="wage_table">
									<tr>
										<td class="item_name">姓名:</td><td class="item_value"><%=rs.getString("username")%>"</td>
										<td class="item_name">工作证号:</td><td class="item_value"><%=rs.getString("B.jid")%></td>
									</tr>
									<tr>
										<td class="item_name">身份证:</td><td class="item_value"><%=rs.getString("idno")%></td>
										<td class="item_name">年份:</td><td class="item_value"><input name="syear" value="<%=rs.getString("syear")%>"></td>
									</tr>
									<tr>
										<td class="item_name">月份:</td><td class="item_value"><input name="smonth" value="<%=rs.getString("smonth")%>"></td>
										<td class="item_name">个人缴存:</td><td class="item_value"><input name="selfpay" value="<%=rs.getString("selfpay")%>"></td>
									</tr>
									<tr>
										<td class="item_name">单位缴存:</td><td class="item_value"><input name="compay" value="<%=rs.getString("compay")%>"></td>
										<td class="item_name">个人账户:</td><td class="item_value"><input name="account" value="<%=rs.getString("account")%>"></td>
									</tr>
									<tr>
										<td class="item_name"></td><td class="item_value"><input type="hidden" name="sid" value="<%=id%>"></td>
									</tr>
									<tr>
										<td class="item_name"></td><td class="item_value"><input type="submit" name="isubmit" value="修改"></td>
										<td class="item_name"><input type="button" name="back" value="返回" onclick="history.back()"></td><td class="item_value"></td>
									</tr>
								</table>
							</form>
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
						 	<form name="fundUpdForm" method="post" action="wageInsUpd.jsp">
								<table class="wage_table">
									<tr>
										<td class="item_name">姓名:</td><td class="item_value"><%=rs.getString("username")%></td>
										<td class="item_name">工作证号:</td><td class="item_value"><%=rs.getString("B.jid")%></td>
									</tr>
									<tr>
										<td class="item_name">身份证:</td><td class="item_value"><%=rs.getString("idno")%></td>
										<td class="item_name">年份:</td><td class="item_value"><input name="fyear" value="<%=rs.getString("fyear")%>"></td>
									</tr>
									<tr>
										<td class="item_name">月份:</td><td class="item_value"><input name="fmonth" value="<%=rs.getString("fmonth")%>"></td>
										<td class="item_name">个人缴存:</td><td class="item_value"><input name="selfpay" value="<%=rs.getString("selfpay")%>"></td>
									</tr>
									<tr>
										<td class="item_name">单位缴存:</td><td class="item_value"><input name="compay" value="<%=rs.getString("compay")%>"></td>
										<td class="item_name">个人账户余额:</td><td class="item_value"><input name="accmoney" value="<%=rs.getString("accmoney")%>"></td>
									</tr>
									<tr>
										<td class="item_name"></td><td class="item_value"><input type="hidden" name="fid" value="<%=id%>"></td>
									</tr>
									<tr>
										<td class="item_name"></td><td class="item_value"><input type="submit" name="fsubmit" value="修改"></td>
										<td class="item_name"><input type="button" name="back" value="返回" onclick="history.back()"></td><td class="item_value"></td>
									</tr>
								</table>
							</form>
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
		
		<%
		//get the time
		Calendar ca = Calendar.getInstance();
		ca.setTime(new java.util.Date());
		int thisyear = ca.get(Calendar.YEAR);
		int thismonth = ca.get(Calendar.MONTH);
		
		if(request.getParameter("wsubmit")!=null){
			int wid = Integer.parseInt(request.getParameter("wid"));
			out.println("<script>alert('update wage')</script>");
			if("".equals(request.getParameter("wyear").trim())||"".equals(request.getParameter("wmonth").trim())||"".equals(request.getParameter("zwwage").trim())||"".equals(request.getParameter("soffice").trim())
			||"".equals(request.getParameter("jbwage").trim())||"".equals(request.getParameter("gwwage").trim())||"".equals(request.getParameter("jswage").trim())||"".equals(request.getParameter("basicwage").trim())
			||"".equals(request.getParameter("otherwage").trim())||"".equals(request.getParameter("trywage").trim())||"".equals(request.getParameter("tqwage").trim())||"".equals(request.getParameter("lifebt").trim())
			||"".equals(request.getParameter("wagebt").trim())||"".equals(request.getParameter("ggbt").trim())||"".equals(request.getParameter("xjwage").trim())||"".equals(request.getParameter("otherbt").trim())){
			//warnning
				out.println("<script>alert('空值将默认为0')</script>");
			}
			//init the var
			int wyear =thisyear,wmonth = thismonth;
			float zwwage=0,jbwage=0,gwwage=0,jswage=0,basicwage=0,otherwage=0,
				trywage=0,tqwage=0,lifebt=0,wagebt=0,ggbt=0,xjwage=0,otherbt=0;
			String soffice = "";
			//if not nul change value to int
			if(!"".equals(request.getParameter("wyear").trim()))
				wyear = Integer.parseInt(request.getParameter("wyear").trim());
			if(!"".equals(request.getParameter("wmonth").trim()))
				wmonth = Integer.parseInt(request.getParameter("wmonth").trim());
			if(!"".equals(request.getParameter("zwwage").trim())) 
				zwwage = Float.parseFloat(request.getParameter("zwwage").trim());
			if(!"".equals(request.getParameter("soffice").trim()))
				soffice = request.getParameter("soffice").trim();
			if(!"".equals(request.getParameter("jbwage").trim()))
				jbwage = Float.parseFloat(request.getParameter("jbwage").trim());
			if(!"".equals(request.getParameter("gwwage").trim())) 
				gwwage = Float.parseFloat(request.getParameter("gwwage").trim());
			if(!"".equals(request.getParameter("jswage").trim())) 
				jswage = Float.parseFloat(request.getParameter("jswage").trim());
			if(!"".equals(request.getParameter("basicwage").trim())) 
				basicwage = Float.parseFloat(request.getParameter("basicwage").trim());
			if(!"".equals(request.getParameter("otherwage").trim())) 
				otherwage = Float.parseFloat(request.getParameter("otherwage").trim());
			if(!"".equals(request.getParameter("trywage").trim())) 
				trywage = Float.parseFloat(request.getParameter("trywage").trim());
			if(!"".equals(request.getParameter("tqwage").trim())) 
				tqwage = Float.parseFloat(request.getParameter("tqwage").trim());
			if(!"".equals(request.getParameter("lifeb").trim())) 
				lifebt = Float.parseFloat(request.getParameter("lifebt").trim());
			if(!"".equals(request.getParameter("wagebt").trim())) 
				wagebt = Float.parseFloat(request.getParameter("wagebt").trim());
			if(!"".equals(request.getParameter("ggbt").trim())) 
				ggbt = Float.parseFloat(request.getParameter("ggbt").trim());
			if(!"".equals(request.getParameter("xjwage").trim()))
				xjwage = Float.parseFloat(request.getParameter("xjwage").trim());
			if(!"".equals(request.getParameter("otherbt").trim())) 
				otherbt = Float.parseFloat(request.getParameter("otherbt").trim());
			//update the datebase
			Class.forName("com.mysql.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hrmsys","root","123456");
			String updSql = "UPDATE wage set wyear = ?,wmonth=?,soffice=?,zwwage=?,jbwage=?,gwwage=?,jswage=?,basicwage=?,otherwage=?,"
								+" trywage=?,tqwage=?,lifebt=?,wagebt=?,ggbt=?,xjwage=?,otherbt=?"
								+" WHERE wid = ?";
			PreparedStatement ps = null;
			try{
				ps = conn.prepareStatement(updSql);
				
				ps.setFloat(1,wyear);
				ps.setFloat(2,wmonth);
				ps.setString(3,soffice);
				ps.setFloat(4,zwwage);
				ps.setFloat(5,jbwage);
				ps.setFloat(6,gwwage);
				ps.setFloat(7,jswage);
				ps.setFloat(8,basicwage);
				ps.setFloat(9,otherwage);
				ps.setFloat(10,trywage);
				ps.setFloat(11,tqwage);
				ps.setFloat(12,lifebt);
				ps.setFloat(13,wagebt);
				ps.setFloat(14,ggbt);
				ps.setFloat(15,xjwage);
				ps.setFloat(16,otherbt);
					
				ps.setInt(17,wid);
				int i = ps.executeUpdate();
				if(i>0){
					response.sendRedirect("wageInsMgn.jsp?type=wage");
				}
				else{
					out.println("<script>alert('修改失败')</script>");
				%>
					<input type="button" value="返回" onclick="history.back()">
				<%
				}
			}catch(SQLException e){
					e.printStackTrace();
			}finally{
				ps.close();
				conn.close();
			}
		}
		if(request.getParameter("isubmit")!=null){
			int sid = Integer.parseInt(request.getParameter("sid"));
			if("".equals(request.getParameter("syear").trim())||"".equals(request.getParameter("smonth").trim())||"".equals(request.getParameter("selfpay").trim())||"".equals(request.getParameter("compay").trim())
			||"".equals(request.getParameter("account").trim())){
			//warnning
				out.println("<script>alert('年份为空将默认为今年，今月，数值空值将默认为0')</script>");
			}
			//get thisyear,thismonth
			
			//init the var
			int syear =thisyear,smonth = thismonth;
			float selfpay= 0 ,compay = 0,account = 0;
			//if not nul change value to int
			if(!"".equals(request.getParameter("syear").trim()))
				syear = Integer.parseInt(request.getParameter("syear").trim());
			if(!"".equals(request.getParameter("smonth").trim()))
				smonth = Integer.parseInt(request.getParameter("smonth").trim());
			if(!"".equals(request.getParameter("selfpay").trim())) 
				selfpay = Float.parseFloat(request.getParameter("selfpay").trim());
			if(!"".equals(request.getParameter("compay").trim()))
				compay = Float.parseFloat(request.getParameter("compay").trim());
				////make sure the account type ???ask teacher
			if(!"".equals(request.getParameter("account").trim())) 
				account = Float.parseFloat(request.getParameter("account").trim());
			
			//update the datebase
			Class.forName("com.mysql.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hrmsys","root","123456");
			String updSql = "UPDATE social_ins set syear = ?,smonth=?,selfpay=?,compay=?,account=?"
								+" WHERE sid = ?";
			PreparedStatement ps = null;
			try{
				ps = conn.prepareStatement(updSql);
	
				ps.setInt(1,syear);
				ps.setInt(2,smonth);
				ps.setFloat(3,selfpay);
				ps.setFloat(4,compay);
				ps.setFloat(5,account);
					
				ps.setInt(6,sid);
				int i = ps.executeUpdate();
				if(i>0){
					response.sendRedirect("wageInsMgn.jsp?type=ins");
				}else{
					out.println("<script>alert('修改失败')</script>");
				%>
					<input type="button" value="返回" onclick="history.back()">
				<%
				}
			}catch(SQLException e){
				e.printStackTrace();
			}finally{
				ps.close();
				conn.close();
			}
		}
		if(request.getParameter("fsubmit")!=null){
			int fid = Integer.parseInt(request.getParameter("fid"));
			if("".equals(request.getParameter("fyear").trim())||"".equals(request.getParameter("fmonth").trim())||"".equals(request.getParameter("selfpay").trim())||"".equals(request.getParameter("compay").trim())
			||"".equals(request.getParameter("accmoney").trim())){
			//warnning
				out.println("<script>alert('年份为空将默认为今年，今月，数值空值将默认为0')</script>");
			}
			//init the var
			int fyear =thisyear,fmonth = thismonth;
			float selfpay= 0 ,compay = 0,accmoney = 0;
			//if not nul change value to int
			if(!"".equals(request.getParameter("fyear").trim()))
				fyear = Integer.parseInt(request.getParameter("fyear").trim());
			if(!"".equals(request.getParameter("fmonth").trim()))
				fmonth = Integer.parseInt(request.getParameter("fmonth").trim());
			if(!"".equals(request.getParameter("selfpay").trim()))
				selfpay = Float.parseFloat(request.getParameter("selfpay").trim());
			if(!"".equals(request.getParameter("compay").trim()))
				compay = Float.parseFloat(request.getParameter("compay").trim());
				////make sure the account type ???ask teacher
			if(!"".equals(request.getParameter("accmoney").trim())) 
				accmoney = Float.parseFloat(request.getParameter("accmoney").trim());
			
			//update the datebase
			Class.forName("com.mysql.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hrmsys","root","123456");
			String updSql = "UPDATE public_fund set fyear = ?,fmonth=?,selfpay=?,compay=?,accmoney=?"
								+" WHERE fid = ?";
			PreparedStatement ps = null;
			try{
				ps = conn.prepareStatement(updSql);
	
				ps.setInt(1,fyear);
				ps.setInt(2,fmonth);
				ps.setFloat(3,selfpay);
				ps.setFloat(4,compay);
				ps.setFloat(5,accmoney);
					
				ps.setInt(6,fid);
				int i = ps.executeUpdate();
				if(i>0){
					response.sendRedirect("wageInsMgn.jsp?type=fund");
				}else{
					out.println("<script>alert('修改失败')</script>");
				%>
					<input type="button" value="返回" onclick="history.back()">
				<%
				}
			}catch(SQLException e){
				e.printStackTrace();
			}finally{
				ps.close();
				conn.close();
			}
		}
		%>
	</body>
</html>
