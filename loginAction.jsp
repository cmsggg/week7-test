<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>

<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %> 
<%-- Table 데이터 저장하는 라이브러리 --%>
<%@ page import="java.util.ArrayList" %>

<%
    request.setCharacterEncoding("utf-8");
    String idValue = request.getParameter("id_value");
    String pwValue = request.getParameter("pw_value");

    // Connector 파일 찾아오는 것
    Class.forName("com.mysql.jdbc.Driver");
    // 데이터베이스에 연결하는 것
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/web", "stageus", "1234");

    // sql 작성
    String sql = "SELECT * FROM account WHERE id=? AND pw=?";
    PreparedStatement query = connect.prepareStatement(sql);   // SQL문을 가지고 전송할 준비
    query.setString(1, idValue);
    query.setString(2, pwValue);

    // sql 전송
    ResultSet result = query.executeQuery();

    // 데이터 정제 ( 프론트엔드에서 사용하기 쉽게, 여기에서 2차원 리스트로 편집해서 전달 )
    // var list = []
    // ArrayList<String> list = new ArrayList<String>();   // jsp 에서의 List
    ArrayList<ArrayList<String>> list = new ArrayList<ArrayList<String>>();
    while(result.next()) {
        ArrayList<String> data = new ArrayList<String>();
        String id = result.getString(1);
        String pw = result.getString(2);
        String name = result.getString(3);
        data.add("\"" + id + "\"");
        data.add("\"" + pw + "\"");
        data.add("\"" + name + "\"");
        list.add(data);
    }
%>

<script>
    var list = <%=list%>
    // 이 js list 변수는, 우리가 흔히 쓰던 리스트이기 때문에 우리 마음대로 요리하기 쉬움

    console.log(list)
</script>