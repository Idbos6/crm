<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String basePath = request.getScheme() + "://" +
                request.getServerName() + ":" + request.getServerPort() +
                request.getContextPath() + "/";
%>
<html>
<head>
    <title>注册活动</title>
    <base href="<%=basePath%>">
</head>
<body>
    <div align="center">
        <form action="activity/addActivity.do" method="post">
            <table>
                <tr>
                    <td>id:</td>
                    <td><input type="text" name="id"></td>
                </tr>
                <tr>
                    <td>owner:</td>
                    <td><input type="text" name="owner"></td>
                </tr>
                <tr>
                    <td>name:</td>
                    <td><input type="text" name="name"></td>
                </tr>
                <tr>
                    <td>startDate:</td>
                    <td><input type="text" name="startDate"></td>
                </tr>
                <tr>
                    <td>endDate:</td>
                    <td><input type="text" name="endDate"></td>
                </tr>
                <tr>
                    <td>cost:</td>
                    <td><input type="text" name="cost"></td>
                </tr>
                <tr>
                    <td>description:</td>
                    <td><input type="text" name="description"></td>
                </tr>
                <tr>
                    <td>createTime:</td>
                    <td><input type="text" name="createTime"></td>
                </tr>
                <tr>
                    <td>createBy:</td>
                    <td><input type="text" name="createBy"></td>
                </tr>
                <tr>
                    <td>editTime:</td>
                    <td><input type="text" name="editTime"></td>
                </tr>
                <tr>
                    <td>editBy:</td>
                    <td><input type="text" name="editBy"></td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td><input type="submit" value="注册"></td>
                </tr>

            </table>
        </form>
    </div>
</body>
</html>
