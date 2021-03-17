<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String basePath = request.getScheme() + "://" +
            request.getServerName() + ":" + request.getServerPort() +
            request.getContextPath() + "/";
%>
<html>
<head>
    <title>Title</title>
    <base href="<%=basePath%>">
    <script type="text/javascript" src="jquery/jquery-1.11.1-min.js"></script>
    <script type="text/javascript">
        $(function () {

            // 在当前页面dom对象加载后，执行loadActivityData
            loadActivityData();

            $("#btnLoader").click(function () {


                loadActivityData();

            })

        })

        function loadActivityData() {
            $("#info").html("");
            $.ajax({

                url:"activity/queryActivity.do",
                type:"get",
                dataType:"json",
                success:function(data){

                    $.each(data,function (i,n) {

                        $("#info").append("<tr>")
                            .append("<td>" + n.id + "</td>")
                            .append("<td>" + n.owner + "</td>")
                            .append("<td>" + n.name + "</td>")
                            .append("<td>" + n.startDate + "</td>")
                            .append("<td>" + n.endDate + "</td>")
                            .append("<td>" + n.cost + "</td>")
                            .append("<td>" + n.description + "</td>")
                            .append("<td>" + n.createTime + "</td>")
                            .append("<td>" + n.createBy + "</td>")
                            .append("<td>" + n.editTime + "</td>")
                            .append("<td>" + n.editBy + "</td>")
                            .append("</tr>");

                    })

                }

            })

        }


    </script>
</head>
<body>

<div align="center">
    <table>
        <thead>
            <tr>
                <td>id</td>
                <td>owner</td>
                <td>name</td>
                <td>startDate</td>
                <td>endDate</td>
                <td>cost</td>
                <td>description</td>
                <td>createTime</td>
                <td>createBy</td>
                <td>editTime</td>
                <td>editBy</td>
            </tr>
        </thead>

        <tbody id="info">

        </tbody>
        <input type="button" id="btnLoader" value="查询数据">

    </table>
</div>

</body>
</html>
