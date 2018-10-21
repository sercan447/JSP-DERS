<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>

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
<body>

<c:if test="${param.id == null }">
<h1>Kayıt İŞLEMİ</h1>
</c:if>
	
	<sql:setDataSource var="kaynak" 
					  driver="com.mysql.jdbc.Driver" 
					  url="jdbc:mysql://localhost/sirketbilgi?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC"
					  user="root"
					  password="" />
					  
	<c:if test="${param.id != null }">
	<h1>Kayıt Güncelleme İşlemi</h1>
		<sql:query var="personelbilgiTablosu" dataSource="${kaynak }">
		
			SELECT * FROM personelBilgi WHERE id = ?;
			
		<sql:param value="${param.id }" />
		
	</sql:query>
	
	<c:set var="gadi" value="${personelbilgiTablosu.rows[0].adi}"  />
	<c:set var="gsoyadi" value="${personelbilgiTablosu.rows[0].soyadi}"  />
	<c:set var="gtcno" value="${personelbilgiTablosu.rows[0].tcno}"  />
	
	</c:if>
	
		
					  

	<form action="veriKayit.jsp" method="post">
	
	<c:if test="${param.id == null }">
		<input type="hidden" name="durum" value="ekle" />
	</c:if>
	<c:if test="${param.id != null }">
		<input  type="hidden" name="id" value="${param.id }" />
		<input  type="hidden" name="durum" value="guncelle" />
	</c:if>
	
		<table>
			<tr>
				<th> Adı :</th>
				
				<td ><input type="text" name="adi"  value="${param.id != null ? gadi  : '' }" class="form-control"/>  </td>
			</tr>
			
			<tr>
				<th> Soyadi :</th>
				
				<td><input type="text" name="soyadi" value="${param.id != null ? gsoyadi  : '' }" class="form-control" />  </td>
			</tr>
			
			<tr>
				<th> TC NO :</th>
				
				<td><input type="text" name="tcno" value="${param.id != null ? gtcno  : '' }" class="form-control" />  </td>
			</tr>
			
				<tr>
				<td> </td>
				<td> 
					<input type="submit" value="${param.id != null ? 'Veri Güncelle' : 'Veri Kaydet' }" class="btn btn-primary btn-lg" />
				</td>
				</tr>
		
		</table>
	</form>


	
<!-- Latest compiled and minified JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" 
		integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
</body>
</html>