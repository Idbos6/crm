<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>
<!DOCTYPE html>
<html>
<head>
    <base href="<%=basePath%>">
    <meta charset="UTF-8">

    <link href="jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet"/>
    <link href="jquery/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.min.css" type="text/css"
          rel="stylesheet"/>

    <script type="text/javascript" src="jquery/jquery-1.11.1-min.js"></script>
    <script type="text/javascript" src="jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="jquery/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.js"></script>
    <script type="text/javascript"
            src="jquery/bootstrap-datetimepicker-master/locale/bootstrap-datetimepicker.zh-CN.js"></script>

    <script type="text/javascript">


        //默认情况下取消和保存按钮是隐藏的
        var cancelAndSaveBtnDefault = true;

        $(function () {

            $("#remark").focus(function () {
                if (cancelAndSaveBtnDefault) {
                    //设置remarkDiv的高度为130px
                    $("#remarkDiv").css("height", "130px");
                    //显示
                    $("#cancelAndSaveBtn").show("2000");
                    cancelAndSaveBtnDefault = false;
                }
            });

            $("#cancelBtn").click(function () {
                //显示
                $("#cancelAndSaveBtn").hide();
                //设置remarkDiv的高度为130px
                $("#remarkDiv").css("height", "90px");
                cancelAndSaveBtnDefault = true;
            });

            $(".remarkDiv").mouseover(function () {
                $(this).children("div").children("div").show();
            });

            $(".remarkDiv").mouseout(function () {
                $(this).children("div").children("div").hide();
            });

            $(".myHref").mouseover(function () {
                $(this).children("span").css("color", "red");
            });

            $(".myHref").mouseout(function () {
                $(this).children("span").css("color", "#E6E6E6");
            });

            //页面加载完毕后，取出关联的市场活动信息列表
            showActivityList();

            showRemarkList();

            //为关联市场活动模态窗口中的 搜索框 绑定事件，通过触发回车键，查询并展现所需市场活动列表
            $("#aname").keydown(function (event) {

                //如果是回车键
                if (event.keyCode == 13) {

                    //alert("查询并展现市场活动列表");

                    $.ajax({

                        url: "workbench/clue/getActivityListByNameAndNotByClueId.do",
                        data: {

                            "aname": $.trim($("#aname").val()),
                            "clueId": "${c.id}"

                        },
                        type: "get",
                        dataType: "json",
                        success: function (data) {

                            /*

                                data
                                    [{市场活动1},{2},{3}]

                             */
                            var html = "";

                            $.each(data, function (i, n) {

                                html += '<tr>';
                                html += '<td><input type="checkbox" name="xz" value="' + n.id + '"/></td>';
                                html += '<td>' + n.name + '</td>';
                                html += '<td>' + n.startDate + '</td>';
                                html += '<td>' + n.endDate + '</td>';
                                html += '<td>' + n.owner + '</td>';
                                html += '</tr>';

                            })

                            $("#activitySearchBody").html(html);


                        }

                    })


                    //展现完列表后，记得将模态窗口默认的回车行为禁用掉
                    return false;

                }


            })


            $("#saveRemarkBtn").click(function () {

                $.ajax({

                    url: "workbench/clue/saveRemark.do",
                    data: {
                        "noteContent": $.trim($("#remark").val()),
                        "clueId": "${c.id}"
                    },
                    type: "post",
                    dataType: "json",
                    success: function (data) {

                        if (data.success) {

                            $("#remark").val("");

                            var html = "";

                            html += '<div id="' + data.cr.id + '" class="remarkDiv" style="height: 60px;">';
                            html += '<img title="zhangsan" src="image/user-thumbnail.png" style="width: 30px; height:30px;">';
                            html += '<div style="position: relative; top: -40px; left: 40px;" >';
                            html += '<h5 id="e' + data.cr.id + '">' + data.cr.noteContent + '</h5>';
                            html += '<font color="gray">线索</font> <font color="gray">-</font> <b>' + data.c.fullname + data.c.appellation + '-' + data.c.company + '</b> <small style="color: gray;"> ' + data.cr.createTime + ' 由' + data.cr.createBy + '</small>';
                            html += '<div style="position: relative; left: 500px; top: -30px; height: 30px; width: 100px; display: none;">';
                            html += '<a class="myHref" href="javascript:void(0);"><span class="glyphicon glyphicon-edit" style="font-size: 20px; color: #E6E6E6;"></span></a>';
                            html += '&nbsp;&nbsp;&nbsp;&nbsp;';
                            html += '<a class="myHref" href="javascript:void(0);"><span class="glyphicon glyphicon-remove" style="font-size: 20px; color: #E6E6E6;"></span></a>';
                            html += '</div>';
                            html += '</div>';
                            html += '</div>';
                            $("#remarkDiv").before(html);

                        } else {

                            alert("添加线索失败");


                        }


                    }


                })


            })

            //为关联按钮绑定事件，执行关联表的添加操作
            $("#bundBtn").click(function () {

                var $xz = $("input[name=xz]:checked");

                if ($xz.length == 0) {

                    alert("请选择需要关联的市场活动");

                    //1条或者多条
                } else {

                    //workbench/clue/bund.do?cid=xxx&aid=xxx&aid=xxx&aid=xxx

                    var param = "cid=${c.id}&";

                    for (var i = 0; i < $xz.length; i++) {

                        param += "aid=" + $($xz[i]).val();

                        if (i < $xz.length - 1) {

                            param += "&";

                        }

                    }

                    //alert(param);

                    $.ajax({

                        url: "workbench/clue/bund.do",
                        data: param,
                        type: "post",
                        dataType: "json",
                        success: function (data) {

                            /*

                                data
                                    {"success":true/false}

                             */

                            if (data.success) {

                                //关联成功
                                //刷新关联市场活动的列表
                                showActivityList();

                                //清除搜索框中的信息  复选框中的√干掉 清空activitySearchBody中的内容

                                //关闭模态窗口
                                $("#bundModal").modal("hide");

                            } else {

                                alert("关联市场活动失败");

                            }

                        }

                    })

                }

            })

            $("#editBtn").click(function () {

                $(".time").datetimepicker({
                    minView: "month",
                    language: 'zh-CN',
                    format: 'yyyy-mm-dd',
                    autoclose: true,
                    todayBtn: true,
                    pickerPosition: "top-left"
                });

                var id = "${c.id}";
                $.ajax({

                    url: "workbench/clue/getUserListAndClue.do",
                    data: {

                        "id": id

                    },
                    type: "get",
                    dataType: "json",
                    success: function (data) {

                        //处理所有者下拉框
                        var html = "<option></option>";

                        $.each(data.uList, function (i, n) {

                            html += "<option value='" + n.id + "'>" + n.name + "</option>";

                        })

                        $("#edit-clueOwner").html(html);

                        //处理单条clue
                        $("#edit-id").val(data.c.id);
                        $("#edit-fullname").val(data.c.fullname);
                        $("#edit-clueOwner").val(data.c.owner);
                        $("#edit-appellation").val(data.c.appellation);
                        $("#edit-company").val(data.c.company);
                        $("#edit-job").val(data.c.job);
                        $("#edit-email").val(data.c.email);
                        $("#edit-phone").val(data.c.phone);
                        $("#edit-website").val(data.c.website);
                        $("#edit-mphone").val(data.c.mphone);
                        $("#edit-state").val(data.c.state);
                        $("#edit-source").val(data.c.source);
                        $("#edit-description").val(data.c.description);
                        $("#edit-contactSummary").val(data.c.contactSummary);
                        $("#edit-nextContactTime").val(data.c.nextContactTime);
                        $("#edit-address").val(data.c.address);

                        //所有的值都填写好之后，打开修改操作的模态窗口
                        $("#editClueModal").modal("show");

                    }

                })

            })


            $("#updateBtn").click(function () {

                $.ajax({

                    url: "workbench/clue/update.do",
                    data: {

                        "id": $.trim($("#edit-id").val()),
                        "fullname": $.trim($("#edit-fullname").val()),
                        "owner": $.trim($("#edit-clueOwner").val()),
                        "appellation": $.trim($("#edit-appellation").val()),
                        "company": $.trim($("#edit-company").val()),
                        "job": $.trim($("#edit-job").val()),
                        "email": $.trim($("#edit-email").val()),
                        "phone": $.trim($("#edit-phone").val()),
                        "website": $.trim($("#edit-website").val()),
                        "mphone": $.trim($("#edit-mphone").val()),
                        "state": $.trim($("#edit-state").val()),
                        "source": $.trim($("#edit-source").val()),
                        "description": $.trim($("#edit-description").val()),
                        "contactSummary": $.trim($("#edit-contactSummary").val()),
                        "nextContactTime": $.trim($("#edit-nextContactTime").val()),
                        "address": $.trim($("#edit-address").val())

                    },
                    type: "post",
                    dataType: "json",
                    success: function (data) {

                        /*

                            data
                                {"success":true/false}

                         */
                        if (data.success) {

                            //修改成功后
                            alert("修改线索活动成功");
                            //关闭修改操作的模态窗口
                            $("#editClueModal").modal("hide");

                            window.location.href = "workbench/clue/index.jsp";


                        } else {

                            alert("修改市场活动失败");

                        }


                    }

                })

            })


            $("#deleteBtn").click(function () {

                var id = "${c.id}";

                $.ajax({

                    url: "workbench/clue/delete.do",
                    data: {
                        "id":id
                    },
                    type: "post",
                    dataType: "json",
                    success: function (data) {

                        /*

                            data
                                {"success":true/false}

                         */
                        if (data.success) {

                            //删除成功后
                            alert("删除成功");
                            window.location.href = "workbench/clue/index.jsp";

                        } else {

                            alert("删除市场活动失败");

                        }


                    }

                })

            })




        });








        function showActivityList() {

            $.ajax({

                url: "workbench/clue/getActivityByCid.do",
                data: {

                    "clueId": "${c.id}"

                },
                type: "get",
                dataType: "json",
                success: function (data) {

                    /*

                        data
                            [{市场活动1},{2},{3}]

                     */

                    var html = "";

                    $.each(data, function (i, n) {

                        html += '<tr>';
                        html += '<td>' + n.name + '</td>';
                        html += '<td>' + n.startDate + '</td>';
                        html += '<td>' + n.endDate + '</td>';
                        html += '<td>' + n.owner + '</td>';
                        html += '<td><a href="javascript:void(0);" onclick="unbund(\'' + n.id + '\')" style="text-decoration: none;"><span class="glyphicon glyphicon-remove"></span>解除关联</a></td>';
                        html += '</tr>';

                    })

                    $("#activityBody").html(html);

                }

            })

        }

        /*

            id:我们想要一个关联关系表的id

         */
        function unbund(id) {

            $.ajax({

                url: "workbench/clue/unbund.do",
                data: {

                    "aid": id,
                    "cid":'${c.id}'

                },
                type: "post",
                dataType: "json",
                success: function (data) {

                    /*

                        data
                            {"success":true/false}

                     */

                    if (data.success) {

                        //解除关联成功
                        //刷新关联的市场活动列表
                        showActivityList();

                    } else {

                        alert("解除关联失败");

                    }

                }

            })

        }

        function showRemarkList() {
            $.ajax({

                url: "workbench/clue/getRemarkListByCid.do",
                data: {

                    "clueId": "${c.id}"

                },
                type: "get",
                dataType: "json",
                success: function (data) {

                    var html = "";

                    $.each(data, function (i, n) {

                        html += '<div id="' + n.id + '" class="remarkDiv" style="height: 60px;">';
                        html += '<img title="zhangsan" src="image/user-thumbnail.png" style="width: 30px; height:30px;">';
                        html += '<div style="position: relative; top: -40px; left: 40px;" >';
                        html += '<h5 id="e' + n.id + '">' + n.noteContent + '</h5>';
                        html += '<font color="gray">线索</font> <font color="gray">-</font> <b>${c.fullname}${c.appellation}-${c.company}</b> <small style="color: gray;"> ' + n.createTime + ' 由' + n.createBy + '</small>';
                        html += '<div style="position: relative; left: 500px; top: -30px; height: 30px; width: 100px;">';
                        html += '<a class="myHref" href="javascript:void(0);"><span class="glyphicon glyphicon-edit" style="font-size: 20px; color: #FF0000;"></span></a>';
                        html += '&nbsp;&nbsp;&nbsp;&nbsp;';
                        html += '<a class="myHref" href="javascript:void(0);"><span class="glyphicon glyphicon-remove" style="font-size: 20px; color: #FF0000;"></span></a>';
                        html += '</div>';
                        html += '</div>';
                        html += '</div>';


                    })



                    $("#remarkDiv").before(html);

                }

            })

        }

        function deleteRemark(id) {

            $.ajax({

                url: "workbench/clue/deleteRemark.do",
                data: {

                    "id": id

                },
                type: "post",
                dataType: "json",
                success: function (data) {

                    /*

                        data
                            {"success":true/false}

                     */

                    if (data.success) {

                        //删除备注成功
                        //这种做法不行，记录使用的是before方法，每一次删除之后，页面上都会保留原有的数据
                        //showRemarkList();

                        //找到需要删除记录的div，将div移除掉
                        $("#" + id).remove();


                    } else {

                        alert("删除备注失败");

                    }


                }

            })

        }

        function editRemark(id) {

            //将模态窗口中，隐藏域中的id进行赋值
            $("#remarkId").val(id);

            //找到指定的存放备注信息的h5标签
            var noteContent = $("#e" + id).html();

            //将h5中展现出来的信息，赋予到修改操作模态窗口的文本域中
            $("#noteContent").val(noteContent);

            //以上信息处理完毕后，将修改备注的模态窗口打开
            $("#editRemarkModal").modal("show");

        }



    </script>

</head>
<body>

<!-- 关联市场活动的模态窗口 -->
<div class="modal fade" id="bundModal" role="dialog">
    <div class="modal-dialog" role="document" style="width: 80%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">×</span>
                </button>
                <h4 class="modal-title">关联市场活动</h4>
            </div>
            <div class="modal-body">
                <div class="btn-group" style="position: relative; top: 18%; left: 8px;">
                    <form class="form-inline" role="form">
                        <div class="form-group has-feedback">
                            <input type="text" class="form-control" id="aname" style="width: 300px;"
                                   placeholder="请输入市场活动名称，支持模糊查询">
                            <span class="glyphicon glyphicon-search form-control-feedback"></span>
                        </div>
                    </form>
                </div>
                <table id="activityTable" class="table table-hover" style="width: 900px; position: relative;top: 10px;">
                    <thead>
                    <tr style="color: #B3B3B3;">
                        <td><input type="checkbox"/></td>
                        <td>名称</td>
                        <td>开始日期</td>
                        <td>结束日期</td>
                        <td>所有者</td>
                        <td></td>
                    </tr>
                    </thead>
                    <tbody id="activitySearchBody">
                    <%--<tr>
                        <td><input type="checkbox"/></td>
                        <td>发传单</td>
                        <td>2020-10-10</td>
                        <td>2020-10-20</td>
                        <td>zhangsan</td>
                    </tr>
                    <tr>
                        <td><input type="checkbox"/></td>
                        <td>发传单</td>
                        <td>2020-10-10</td>
                        <td>2020-10-20</td>
                        <td>zhangsan</td>
                    </tr>--%>
                    </tbody>
                </table>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" id="bundBtn">关联</button>
            </div>
        </div>
    </div>
</div>

<!-- 修改线索的模态窗口 -->
<div class="modal fade" id="editClueModal" role="dialog">
    <div class="modal-dialog" role="document" style="width: 90%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">×</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">修改线索</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" role="form">
                    <input type="hidden" id="edit-id">
                    <div class="form-group">
                        <label for="edit-clueOwner" class="col-sm-2 control-label">所有者<span
                                style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <select class="form-control" id="edit-clueOwner">

                            </select>
                        </div>
                        <label for="edit-company" class="col-sm-2 control-label">公司<span
                                style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="edit-company">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="edit-call" class="col-sm-2 control-label">称呼</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <select class="form-control" id="edit-appellation">
                                <c:forEach items="${appellationList}" var="a">
                                    <option value="${a.value}">${a.text}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <label for="edit-surname" class="col-sm-2 control-label">姓名<span
                                style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="edit-fullname">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="edit-job" class="col-sm-2 control-label">职位</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="edit-job">
                        </div>
                        <label for="edit-email" class="col-sm-2 control-label">邮箱</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="edit-email">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="edit-phone" class="col-sm-2 control-label">公司座机</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="edit-phone">
                        </div>
                        <label for="edit-website" class="col-sm-2 control-label">公司网站</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="edit-website">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="edit-mphone" class="col-sm-2 control-label">手机</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="edit-mphone">
                        </div>
                        <label for="edit-status" class="col-sm-2 control-label">线索状态</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <select class="form-control" id="edit-state">
                                <option></option>
                                <c:forEach items="${clueStateList}" var="c">
                                    <option value="${c.value}">${c.text}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="edit-source" class="col-sm-2 control-label">线索来源</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <select class="form-control" id="edit-source">
                                <option></option>
                                <c:forEach items="${sourceList}" var="s">
                                    <option value="${s.value}">${s.text}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="edit-describe" class="col-sm-2 control-label">描述</label>
                        <div class="col-sm-10" style="width: 81%;">
                            <textarea class="form-control" rows="3" id="edit-description"></textarea>
                        </div>
                    </div>

                    <div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative;"></div>

                    <div style="position: relative;top: 15px;">
                        <div class="form-group">
                            <label for="edit-contactSummary" class="col-sm-2 control-label">联系纪要</label>
                            <div class="col-sm-10" style="width: 81%;">
                                <textarea class="form-control" rows="3" id="edit-contactSummary"></textarea>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="edit-nextContactTime" class="col-sm-2 control-label">下次联系时间</label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control time" id="edit-nextContactTime">
                            </div>
                        </div>
                    </div>

                    <div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative; top : 10px;"></div>

                    <div style="position: relative;top: 20px;">
                        <div class="form-group">
                            <label for="edit-address" class="col-sm-2 control-label">详细地址</label>
                            <div class="col-sm-10" style="width: 81%;">
                                <textarea class="form-control" rows="1" id="edit-address"></textarea>
                            </div>
                        </div>
                    </div>
                </form>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button id="updateBtn" type="button" class="btn btn-primary" data-dismiss="modal">更新</button>
            </div>
        </div>
    </div>
</div>

<!-- 返回按钮 -->
<div style="position: relative; top: 35px; left: 10px;">
    <a href="javascript:void(0);" onclick="window.history.back();"><span class="glyphicon glyphicon-arrow-left"
                                                                         style="font-size: 20px; color: #DDDDDD"></span></a>
</div>

<!-- 大标题 -->
<div style="position: relative; left: 40px; top: -30px;">
    <div class="page-header">
        <h3>${c.fullname}${c.appellation} <small>${c.company}</small></h3>
    </div>
    <div style="position: relative; height: 50px; width: 500px;  top: -72px; left: 700px;">
        <button type="button" class="btn btn-default"
                onclick="window.location.href='workbench/clue/convert.jsp?id=${c.id}&fullname=${c.fullname}&appellation=${c.appellation}&company=${c.company}&owner=${c.owner}';">
            <span class="glyphicon glyphicon-retweet"></span> 转换
        </button>
        <button id="editBtn" type="button" class="btn btn-default"><span class="glyphicon glyphicon-edit"></span> 编辑</button>
        <button id="deleteBtn" type="button" class="btn btn-danger" ><span class="glyphicon glyphicon-minus"></span> 删除</button>
    </div>
</div>

<!-- 详细信息 -->
<div style="position: relative; top: -70px;">
    <div style="position: relative; left: 40px; height: 30px;">
        <div style="width: 300px; color: gray;">名称</div>
        <div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${c.fullname}${c.appellation}</b>
        </div>
        <div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">所有者</div>
        <div style="width: 300px;position: relative; left: 650px; top: -60px;"><b>${c.owner}</b></div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 10px;">
        <div style="width: 300px; color: gray;">公司</div>
        <div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${c.company}</b></div>
        <div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">职位</div>
        <div style="width: 300px;position: relative; left: 650px; top: -60px;"><b>${c.job}</b></div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 20px;">
        <div style="width: 300px; color: gray;">有限</div>
        <div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${c.email}</b></div>
        <div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">公司座机</div>
        <div style="width: 300px;position: relative; left: 650px; top: -60px;"><b>${c.phone}</b></div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 30px;">
        <div style="width: 300px; color: gray;">公司网站</div>
        <div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${c.website}</b></div>
        <div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">手机</div>
        <div style="width: 300px;position: relative; left: 650px; top: -60px;"><b>${c.mphone}</b></div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 40px;">
        <div style="width: 300px; color: gray;">线索状态</div>
        <div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${c.state}</b></div>
        <div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">线索来源</div>
        <div style="width: 300px;position: relative; left: 650px; top: -60px;"><b>${c.source}</b></div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 50px;">
        <div style="width: 300px; color: gray;">创建者</div>
        <div style="width: 500px;position: relative; left: 200px; top: -20px;"><b>${c.createBy}&nbsp;&nbsp;</b><small
                style="font-size: 10px; color: gray;">${c.createTime}</small></div>
        <div style="height: 1px; width: 550px; background: #D5D5D5; position: relative; top: -20px;"></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 60px;">
        <div style="width: 300px; color: gray;">修改者</div>
        <div style="width: 500px;position: relative; left: 200px; top: -20px;"><b>${c.editBy}&nbsp;&nbsp;</b><small
                style="font-size: 10px; color: gray;">${c.editTime}</small></div>
        <div style="height: 1px; width: 550px; background: #D5D5D5; position: relative; top: -20px;"></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 70px;">
        <div style="width: 300px; color: gray;">描述</div>
        <div style="width: 630px;position: relative; left: 200px; top: -20px;">
            <b>
                ${c.description}
            </b>
        </div>
        <div style="height: 1px; width: 850px; background: #D5D5D5; position: relative; top: -20px;"></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 80px;">
        <div style="width: 300px; color: gray;">联系纪要</div>
        <div style="width: 630px;position: relative; left: 200px; top: -20px;">
            <b>
                ${c.contactSummary}
            </b>
        </div>
        <div style="height: 1px; width: 850px; background: #D5D5D5; position: relative; top: -20px;"></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 90px;">
        <div style="width: 300px; color: gray;">下次联系时间</div>
        <div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${c.nextContactTime}</b></div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -20px; "></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 100px;">
        <div style="width: 300px; color: gray;">详细地址</div>
        <div style="width: 630px;position: relative; left: 200px; top: -20px;">
            <b>
                ${c.address}
            </b>
        </div>
        <div style="height: 1px; width: 850px; background: #D5D5D5; position: relative; top: -20px;"></div>
    </div>
</div>

<!-- 备注 -->
<div style="position: relative; top: 40px; left: 40px;">
    <div class="page-header">
        <h4>备注</h4>
    </div>


    <div id="remarkDiv" style="background-color: #E6E6E6; width: 870px; height: 90px;">
        <form role="form" style="position: relative;top: 10px; left: 10px;">
            <textarea id="remark" class="form-control" style="width: 850px; resize : none;" rows="2"
                      placeholder="添加备注..."></textarea>
            <p id="cancelAndSaveBtn" style="position: relative;left: 737px; top: 10px; display: none;">
                <button id="cancelBtn" type="button" class="btn btn-default">取消</button>
                <button id="saveRemarkBtn" type="button" class="btn btn-primary">保存</button>
            </p>
        </form>
    </div>
</div>

<!-- 市场活动 -->
<div>
    <div style="position: relative; top: 60px; left: 40px;">
        <div class="page-header">
            <h4>市场活动</h4>
        </div>
        <div style="position: relative;top: 0px;">
            <table class="table table-hover" style="width: 900px;">
                <thead>
                <tr style="color: #B3B3B3;">
                    <td>名称</td>
                    <td>开始日期</td>
                    <td>结束日期</td>
                    <td>所有者</td>
                    <td></td>
                </tr>
                </thead>
                <tbody id="activityBody">
                <%--<tr>
                    <td>发传单</td>
                    <td>2020-10-10</td>
                    <td>2020-10-20</td>
                    <td>zhangsan</td>
                    <td><a href="javascript:void(0);"  style="text-decoration: none;"><span class="glyphicon glyphicon-remove"></span>解除关联</a></td>
                </tr>
                <tr>
                    <td>发传单</td>
                    <td>2020-10-10</td>
                    <td>2020-10-20</td>
                    <td>zhangsan</td>
                    <td><a href="javascript:void(0);"  style="text-decoration: none;"><span class="glyphicon glyphicon-remove"></span>解除关联</a></td>
                </tr>--%>
                </tbody>
            </table>
        </div>

        <div>
            <a href="javascript:void(0);" data-toggle="modal" data-target="#bundModal"
               style="text-decoration: none;"><span class="glyphicon glyphicon-plus"></span>关联市场活动</a>
        </div>
    </div>
</div>


<div style="height: 200px;"></div>
</body>
</html>