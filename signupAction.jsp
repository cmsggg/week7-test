<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>

<%-- Connector 파일을 찾는 라이브러리 --%>
<%@ page import="java.sql.DriverManager" %>
<%-- 데이터베이스에 연결하는 라이브러리 --%>
<%@ page import="java.sql.Connection" %>
<%-- SQL을 전송하는 라이브러리 --%>
<%@ page import="java.sql.PreparedStatement" %>

<%
    // 값 받아오기
    request.setCharacterEncoding("utf-8");
    String idValue = request.getParameter("id_value");
    String pwValue = request.getParameter("pw_value");
    String nameValue = request.getParameter("name_value");

    // Connector 파일 찾아오는 것
    Class.forName("com.mysql.jdbc.Driver");
    // 데이터베이스에 연결하는 것
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/web", "stageus", "1234");

    // sql 작성
    String sql = "INSERT INTO account (id, pw, name) VALUES (?, ?, ?)";
    PreparedStatement query = connect.prepareStatement(sql);   // SQL문을 가지고 전송할 준비
    query.setString(1, idValue);
    query.setString(2, pwValue);
    query.setString(3, nameValue);

    // sql 전송
    query.executeUpdate();
%>

<script>
    alert("회원가입에 성공하였습니다.")
    location.href = "index.html"
</script>
