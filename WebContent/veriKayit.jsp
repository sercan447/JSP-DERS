<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title></title>

<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" 
integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">

<!-- Optional theme -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css"
 integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">

</head>
<body class="container">
<!-- ?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC -->

<c:catch var="hataSonuc">

	<sql:setDataSource var="kaynak" 
					  driver="com.mysql.jdbc.Driver" 
					  url="jdbc:mysql://localhost/sirketbilgi?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC"
					  user="root"
					  password="" />

	
	<c:if test="${kaynak != null}">
	
		<c:if test="${param.durum == 'guncelle'}">
			
			<sql:transaction dataSource="${kaynak }">
					<sql:update>
						UPDATE personelbilgi SET
							adi = ? , soyadi = ? , tcno = ? WHERE id = ?
							
							<sql:param value="${param.adi }" />
							<sql:param value="${param.soyadi }" />
							<sql:param value="${param.tcno }" />
							<sql:param  value="${param.id }" />
					</sql:update>
			</sql:transaction>
		 </c:if>
		 
		 
		 <c:if test="${param.durum == 'sil' }">
		 		
		 		<sql:transaction dataSource="${kaynak }">
		 			<sql:update>
		 				
		 				DELETE FROM personelBilgi WHERE id = ?
		 				
		 				<sql:param value="${param.id}" />
		 				
		 			</sql:update>
		 		</sql:transaction>
		 		
		 </c:if>
			
	
<c:if test="${param.durum == 'ekle' }">	
	<c:if test="${param.adi != null or param.soyadi != null or param.tcno != null }">
	
	<c:set var="adi" value="${param.adi}" />		
	<c:set var="soyadi" value="${param.soyadi}" />
	<c:set var="tcno" value='<%= request.getParameter("tcno") %>' />
	

<sql:transaction dataSource="${kaynak }">

	<sql:update>
		
		INSERT INTO personelbilgi (adi,soyadi,tcno) VALUES (?,?,?);
		
		<sql:param value="${adi }" />
		<sql:param value="${soyadi }" />
		<sql:param value="${tcno }" />
		
	</sql:update>
	
</sql:transaction>
	</c:if>

		</c:if>
	</c:if>
	
		<sql:query var="personelbilgiTablosu" dataSource="${kaynak }">
		SELECT * FROM personelBilgi;
	</sql:query>


	<table class="table">
			
			<tr class="danger">
			<c:forEach var="kolon" items="${personelbilgiTablosu.columnNames}">
				<th><c:out value="${fn:toUpperCase(kolon)}" /></th>
			</c:forEach>
			<td> Sil </td>
			<td>Güncelle</td>
			</tr>
			
			
			<c:forEach var="datas" items="${personelbilgiTablosu.rows}">
			<tr class="info">
				<td> <c:out value="${datas.id }" /> </td>
				<td> <c:out value="${datas.adi }" /> </td>
				<td> <c:out value="${datas.soyadi }" /> </td>
				<td> <c:out value="${datas.tcno }" /> </td>
				<td> <a href="veriKayit.jsp?id=${datas.id }&durum=sil" class="btn btn-warning">SİL</a> </td>
				<td> <a href="index.jsp?id=${datas.id }" class="btn btn-default">Güncelle</a> </td>
			</tr>	
		
			</c:forEach>
				
	</table>
</c:catch>

	<if test="${hataSonuc != null }">
			<c:out value="${hataSonuc }" />
	</if>
	
	
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" 
integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
	
</body>
</html>