<%@ page contentType="text/html; charset=euc-kr" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="type" value="Product" scope="session"/>

<% //System.out.println("\n:: listProduct.jsp"); %>

<c:set var="menu" value="${param.menu}" />
<c:set var="title" value="" />
<c:if test="${param.menu == 'search'}">
	<c:set var="title" value="��ǰ ���" />
</c:if>
<c:if test="${param.menu == 'manage'}">
	<c:set var="title" value="��ǰ ����" />
</c:if>
	





<html>
<head>
<title>��ǰ �����ȸ</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">


<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type="text/javascript">
function fncGetProductList(currentPage){
	//document.getElementById("currentPage").value = currentPage;
	$("#currentPage").val(currentPage)
	//document.detailForm.submit();
	$("form").attr("method" , "POST").attr("action" , "/product/listProduct?menu=${menu}").submit();
}

$(function() {
	 
	 $( "td.ct_btn01:contains('�˻�')" ).on("click" , function() {
		fncGetProductList(1);
	});
	
	$( ".ct_list_pop td:nth-child(3)" ).on("click" , function() {
		var prodNo = $(this).data("prodNo");
		
		if("${param.menu}" == 'manage'){
		$.ajax( 
				{
					url : "/product/json/getProduct/"+prodNo ,
					method : "GET" ,
					dataType : "json" ,
					headers : {
						"Accept" : "application/json",
						"Content-Type" : "application/json"
					},
					success : function(JSONData , status) {
						
						var displayValue = "<h3>"
													+"�� ǰ �� ȣ : "+JSONData.prodNo+"<br/>"
													+"��  ǰ  �� : "+JSONData.prodName+"<br/>"
													+"�� ǰ �̹��� : ���� <br/>"
													+"��ǰ ������ : "+JSONData.prodDetail+"<br/>"
													+"�� �� �� �� : "+JSONData.manuDate+"<br/>"
													+"��     �� : "+JSONData.price+"<br/>"
													+"�� �� �� �� : "+JSONData.regDate+"<br/>"
													+"</h3>";
						//Debug...									
						//alert(displayValue);
						$("h3").remove();
						$( "#"+prodNo+"" ).html(displayValue);
					}
			});
		}
		else if("${param.menu}" == 'search'){
			$.ajax( 
					{
						url : "/product/json/getProduct/"+prodNo ,
						method : "GET" ,
						dataType : "json" ,
						headers : {
							"Accept" : "application/json",
							"Content-Type" : "application/json"
						},
						success : function(JSONData , status) {
							
							var displayValue = "<h3>"
														+"�� ǰ �� ȣ : "+JSONData.prodNo+"<br/>"
														+"��  ǰ  �� : "+JSONData.prodName+"<br/>"
														+"�� ǰ �̹��� : ���� <br/>"
														+"��ǰ ������ : "+JSONData.prodDetail+"<br/>"
														+"�� �� �� �� : "+JSONData.manuDate+"<br/>"
														+"��     �� : "+JSONData.price+"<br/>"
														+"�� �� �� �� : "+JSONData.regDate+"<br/>"
														+"</h3>";
							//Debug...									
							//alert(displayValue);
							$("h3").remove();
							$( "#"+prodNo+"" ).html(displayValue);
						}
				});
		}
	});
	
	$( ".ct_list_pop td:nth-child(3)" ).css("color" , "red");
	$( ".ct_list_pop td:nth-child(9)" ).css("color" , "red");
	$("h7").css("color" , "red");
	
	$(".ct_list_pop:nth-child(4n+4)" ).css("background-color" , "darkorange");
	$(".ct_list_pop:nth-child(4n+6)" ).css("background-color" , "skyblue");
	$(".ct_list_pop:nth-child(4n+8)" ).css("background-color" , "lightgreen");

});	
	
	
	
</script>
</head>

<body bgcolor="#ffffff" text="#000000">

<div style="width:98%; margin-left:10px;">

<form name="detailForm" action="/product/listProduct?menu=${menu}" method="post">

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37">
			<img src="/images/ct_ttl_img01.gif" width="15" height="37"/>
		</td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left:10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">
					
							${title}
					
					</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37">
			<img src="/images/ct_ttl_img03.gif" width="12" height="37"/>
		</td>
	</tr>
</table>


<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		
		<td align="right">
			<select name="searchCondition" class="ct_input_g" style="width:80px">
				<option value="0" ${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>��ǰ��ȣ</option>
				<option value="1" ${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>��ǰ��</option>
				<option value="2" ${ ! empty search.searchCondition && search.searchCondition==2 ? "selected" : "" }>��ǰ����</option>
			</select>
			<%--<input type="text" name="searchKeyword" value="<%= searchKeyword %>" class="ct_input_g" style="width:200px; height:19px" />--%>
			<input type="text" name="searchKeyword" 
						value="${! empty search.searchKeyword ? search.searchKeyword : ""}" 
						class="ct_input_g" style="width:200px; height:19px" />
		</td>
	
		
		<td align="right" width="70">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23">
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
						�˻�
					</td>
					<td width="14" height="23">
						<img src="/images/ct_btnbg03.gif" width="14" height="23">
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td colspan="11" >
		��ü  ${resultPage.totalCount } �Ǽ�, ���� ${resultPage.currentPage}  ������ </td>
		
	</tr>
	<tr>
		<td class="ct_list_b" width="100">No</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">��ǰ��</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">����</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">�����</td>	
		<td class="ct_line02"></td>
		<td class="ct_list_b">�������</td>	
	</tr>
	<tr>
		<td colspan="11" bgcolor="808285" height="1"></td>
	</tr>
	<c:set var="i" value="0" />
	<c:forEach var="product" items="${list}">
		<c:set var="i" value="${ i+1 }" />
		<tr class="ct_list_pop">
			<td align="center">${ i }</td>
			<td></td>
			<c:if test = "${param.menu == 'manage'}">
				<td align="left" data-prod-no="${product.prodNo}">${product.prodName}</td>
			</c:if>
			<c:if test = "${param.menu == 'search'}">
				<td align="left" data-prod-no="${product.prodNo}">${product.prodName}</td>
			</c:if>
			
			<td></td>
			<td align="left">${product.price}</td>
			<td></td>
			<td align="left">${product.regDate}</td>	
			<td></td>
			<td align="left">�Ǹ���</td>	
		</tr>
		<tr>
		<td id="${product.prodNo}" colspan="11" bgcolor="D6D7D6" height="1"></td>
		</tr>
	</c:forEach>
</table>



<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">

	<tr>
		<td align="center">
		   <input type="hidden" id="currentPage" name="currentPage" value=""/>
		   <%--
			<% if( resultPage.getCurrentPage() <= resultPage.getPageUnit() ){ %>
					�� ����
			<% }else{ %>
					<a href="javascript:fncGetProductList('<%=resultPage.getCurrentPage()-1%>')">�� ����</a>
			<% } %>

			<%	for(int i=resultPage.getBeginUnitPage();i<= resultPage.getEndUnitPage() ;i++){	%>
					<a href="javascript:fncGetProductList('<%=i %>')"><%=i %></a>
			<% 	}  %>
	
			<% if( resultPage.getEndUnitPage() >= resultPage.getMaxPage() ){ %>
					���� ��
			<% }else{ %>
					<a href="javascript:fncGetProductList('<%=resultPage.getEndUnitPage()+1%>')">���� ��</a>
			<% } %>
			--%>
			<jsp:include page="../common/pageNavigator.jsp"/>	
    	</td>
	</tr>
	
</table>


<!--  ������ Navigator �� -->

</form>

</div>
</body>
</html>