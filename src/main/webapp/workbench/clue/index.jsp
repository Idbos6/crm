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

    <link rel="stylesheet" type="text/css" href="jquery/bs_pagination/jquery.bs_pagination.min.css">
    <script type="text/javascript" src="jquery/bs_pagination/jquery.bs_pagination.min.js"></script>
    <script type="text/javascript" src="jquery/bs_pagination/en.js"></script>

    <script type="text/javascript">

        $(function () {

            $(".time").datetimepicker({
                minView: "month",
                language: 'zh-CN',
                format: 'yyyy-mm-dd',
                autoclose: true,
                todayBtn: true,
                pickerPosition: "top-left"
            });

            $(window).keydown(function (event) {

                if (event.keyCode == 13) {

                    $("#hidden-company").val($.trim($("#search-company").val()));
                    $("#hidden-fullname").val($.trim($("#search-fullname").val()));
                    $("#hidden-phone").val($.trim($("#search-phone").val()));
                    $("#hidden-mphone").val($.trim($("#search-mphone").val()));
                    $("#hidden-source").val($.trim($("#search-source").val()));
                    $("#hidden-owner").val($.trim($("#search-owner").val()));
                    $("#hidden-state").val($.trim($("#search-state").val()));

                    pageList(1, 2);

                }

            })

            //???????????????????????????????????????????????????????????????
            $("#addBtn").click(function () {

                $.ajax({

                    url: "workbench/activity/getUserList.do",
                    type: "get",
                    dataType: "json",
                    success: function (data) {

                        /*

                            data
                                [{??????1},{2},{3}]

                         */

                        var html = "<option></option>";

                        $.each(data, function (i, n) {

                            html += "<option value='" + n.id + "'>" + n.name + "</option>";

                        })

                        $("#create-owner").html(html);

                        var id = "${user.id}";

                        $("#create-owner").val(id);

                        //?????????????????????????????????????????????????????????
                        $("#createClueModal").modal("show");

                    }

                })

            })

            //??????????????????????????????????????????????????????
            $("#saveBtn").click(function () {

                $.ajax({

                    url: "workbench/clue/save.do",
                    data: {

                        "fullname": $.trim($("#create-fullname").val()),
                        "appellation": $.trim($("#create-appellation").val()),
                        "owner": $.trim($("#create-owner").val()),
                        "company": $.trim($("#create-company").val()),
                        "job": $.trim($("#create-job").val()),
                        "email": $.trim($("#create-email").val()),
                        "phone": $.trim($("#create-phone").val()),
                        "website": $.trim($("#create-website").val()),
                        "mphone": $.trim($("#create-mphone").val()),
                        "state": $.trim($("#create-state").val()),
                        "source": $.trim($("#create-source").val()),
                        "description": $.trim($("#create-description").val()),
                        "contactSummary": $.trim($("#create-contactSummary").val()),
                        "nextContactTime": $.trim($("#create-nextContactTime").val()),
                        "address": $.trim($("#create-address").val())


                    },
                    type: "post",
                    dataType: "json",
                    success: function (data) {

                        /*

                            data
                                {"success":true/false}

                         */

                        if (data.success) {

                            alert("??????????????????");
                            //????????????
                            pageList(1, $("#activityPage").bs_pagination('getOption', 'rowsPerPage'));
                            $("#clueAddForm")[0].reset();
                            //??????????????????
                            $("#createClueModal").modal("hide");

                        } else {

                            alert("??????????????????");

                        }

                    }

                })

            })

            pageList(1, 2);


            $("#searchBtn").click(function () {

                /*

                    ??????????????????????????????????????????????????????????????????????????????,?????????????????????


                 */

                $("#hidden-company").val($.trim($("#search-company").val()));
                $("#hidden-fullname").val($.trim($("#search-fullname").val()));
                $("#hidden-phone").val($.trim($("#search-phone").val()));
                $("#hidden-mphone").val($.trim($("#search-mphone").val()));
                $("#hidden-source").val($.trim($("#search-source").val()));
                $("#hidden-owner").val($.trim($("#search-owner").val()));
                $("#hidden-state").val($.trim($("#search-state").val()));

                pageList(1, 2);

            })

            //??????????????????????????????????????????????????????
            $("#qx").click(function () {

                $("input[name=xz]").prop("checked", this.checked);

            })

            $("#activityBody").on("click", $("input[name=xz]"), function () {

                $("#qx").prop("checked", $("input[name=xz]").length == $("input[name=xz]:checked").length);

            })



            //????????????????????????????????????????????????????????????
            $("#deleteBtn").click(function () {

                //?????????????????????????????????????????????jquery??????
                var $xz = $("input[name=xz]:checked");

                if ($xz.length == 0) {

                    alert("??????????????????????????????");

                    //?????????????????????????????????1????????????????????????
                } else {


                    if (confirm("????????????????????????????????????")) {

                        //url:workbench/activity/delete.do?id=xxx&id=xxx&id=xxx

                        //????????????
                        var param = "";

                        //???$xz???????????????dom???????????????????????????value???????????????????????????????????????????????????id
                        for (var i = 0; i < $xz.length; i++) {

                            param += "id=" + $($xz[i]).val();

                            //????????????????????????????????????????????????????????????&???
                            if (i < $xz.length - 1) {

                                param += "&";

                            }

                        }

                        //alert(param);
                        $.ajax({

                            url: "workbench/clue/delete.do",
                            data: param,
                            type: "post",
                            dataType: "json",
                            success: function (data) {

                                /*

                                    data
                                        {"success":true/false}

                                 */
                                if (data.success) {

                                    //???????????????
                                    alert("????????????");
                                    //????????????????????????????????????????????????
                                    pageList($("#activityPage").bs_pagination('getOption', 'currentPage'), $("#activityPage").bs_pagination('getOption', 'rowsPerPage'));


                                } else {

                                    alert("????????????????????????");

                                }


                            }

                        })


                    }


                }


            })

            //???????????????????????????????????????????????????????????????
            $("#editBtn").click(function () {

                var $xz = $("input[name=xz]:checked");

                if ($xz.length == 0) {

                    alert("??????????????????????????????");

                } else if ($xz.length > 1) {

                    alert("????????????????????????????????????");

                    //?????????????????????
                } else {

                    var id = $xz.val();

                    $.ajax({

                        url: "workbench/clue/getUserListAndClue.do",
                        data: {

                            "id": id

                        },
                        type: "get",
                        dataType: "json",
                        success: function (data) {

                            /*

                                data
                                    ????????????
                                    ??????????????????

                                    {"uList":[{??????1},{2},{3}],"c":{??????}}

                             */

                            //????????????????????????
                            var html = "<option></option>";

                            $.each(data.uList, function (i, n) {

                                html += "<option value='" + n.id + "'>" + n.name + "</option>";

                            })

                            $("#edit-clueOwner").html(html);

                            //????????????clue
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

                            //??????????????????????????????????????????????????????????????????
                            $("#editClueModal").modal("show");

                        }

                    })

                }

            })

            //???????????????????????????????????????????????????????????????
            /*

                ????????????????????????????????????????????????????????????????????????????????????
                ????????????????????????????????????????????????????????????copy????????????

             */
            $("#updateBtn").click(function () {

                $.ajax({

                    url: "workbench/clue/update.do",
                    data: {

                        "id":$.trim($("#edit-id").val()),
                        "fullname": $.trim($("#edit-fullname").val()),
                        "appellation": $.trim($("#edit-appellation").val()),
                        "owner": $.trim($("#edit-clueOwner").val()),
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

                            alert("??????????????????");
                            //????????????
                            pageList(1, $("#activityPage").bs_pagination('getOption', 'rowsPerPage'));
                            $("#clueEditForm")[0].reset();
                            //??????????????????
                            $("#editClueModal").modal("hide");

                        } else {

                            alert("??????????????????");

                        }

                    }

                })

            })


        });

        function pageList(pageNo, pageSize) {

            //?????????????????????????????????
            $("#qx").prop("checked", false);

            //?????????????????????????????????????????????????????????????????????????????????
            $("#search-company").val($.trim($("#hidden-company").val()));
            $("#search-fullname").val($.trim($("#hidden-fullname").val()));
            $("#search-phone").val($.trim($("#hidden-phone").val()));
            $("#search-mphone").val($.trim($("#hidden-mphone").val()));
            $("#search-source").val($.trim($("#hidden-source").val()));
            $("#search-owner").val($.trim($("#hidden-owner").val()));
            $("#search-state").val($.trim($("#hidden-state").val()));

            $.ajax({

                url: "workbench/clue/pageList.do",
                data: {

                    "pageNo": pageNo,
                    "pageSize": pageSize,
                    "fullname": $.trim($("#search-fullname").val()),
                    "company": $.trim($("#search-company").val()),
                    "phone": $.trim($("#search-phone").val()),
                    "mphone": $.trim($("#search-mphone").val()),
                    "source": $.trim($("#search-source").val()),
                    "owner": $.trim($("#search-owner").val()),
                    "state": $.trim($("#search-state").val())

                },
                type: "get",
                dataType: "json",
                success: function (data) {

                    var html = "";

                    //?????????n???????????????????????????
                    $.each(data.dataList, function (i, n) {

                        html += '<tr class="active">';
                        html += '<td><input type="checkbox" name="xz" value="' + n.id + '"/></td>';
                        html += '<td><a style="text-decoration: none; cursor: pointer;" onclick="window.location.href=\'workbench/clue/detail.do?id=' + n.id + '\';">' + n.fullname + '</a></td>';
                        html += '<td>' + n.company + '</td>';
                        html += '<td>' + n.phone + '</td>';
                        html += '<td>' + n.mphone + '</td>';
                        html += '<td>' + n.source + '</td>';
                        html += '<td>' + n.owner + '</td>';
                        html += '<td>' + n.state + '</td>';
                        html += '</tr>';

                    })

                    $("#activityBody").html(html);

                    //???????????????
                    var totalPages = data.total % pageSize == 0 ? data.total / pageSize : parseInt(data.total / pageSize) + 1;

                    //????????????????????????????????????????????????????????????????????????
                    $("#activityPage").bs_pagination({
                        currentPage: pageNo, // ??????
                        rowsPerPage: pageSize, // ???????????????????????????
                        maxRowsPerPage: 20, // ?????????????????????????????????
                        totalPages: totalPages, // ?????????
                        totalRows: data.total, // ???????????????

                        visiblePageLinks: 3, // ??????????????????

                        showGoToPage: true,
                        showRowsPerPage: false,
                        showRowsInfo: true,
                        showRowsDefaultInfo: false,

                        //????????????????????????????????????????????????????????????
                        onChangePage: function (event, data) {
                            pageList(data.currentPage, data.rowsPerPage);
                        }
                    });

                }

            })

        }

    </script>
</head>
<body>
<input type="hidden" id="hidden-fullname"/>
<input type="hidden" id="hidden-company"/>
<input type="hidden" id="hidden-phone"/>
<input type="hidden" id="hidden-mphone"/>
<input type="hidden" id="hidden-source"/>
<input type="hidden" id="hidden-owner"/>
<input type="hidden" id="hidden-state"/>
<!-- ??????????????????????????? -->
<div class="modal fade" id="createClueModal" role="dialog">
    <div class="modal-dialog" role="document" style="width: 90%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">??</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">????????????</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" role="form" id="clueAddForm">

                    <div class="form-group">
                        <label for="create-clueOwner" class="col-sm-2 control-label">?????????<span
                                style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <select class="form-control" id="create-owner">


                            </select>
                        </div>
                        <label for="create-company" class="col-sm-2 control-label">??????<span
                                style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="create-company">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="create-call" class="col-sm-2 control-label">??????</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <select class="form-control" id="create-appellation">
                                <option></option>
                                <c:forEach items="${appellationList}" var="a">
                                    <option value="${a.value}">${a.text}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <label for="create-surname" class="col-sm-2 control-label">??????<span
                                style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="create-fullname">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="create-job" class="col-sm-2 control-label">??????</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="create-job">
                        </div>
                        <label for="create-email" class="col-sm-2 control-label">??????</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="create-email">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="create-phone" class="col-sm-2 control-label">????????????</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="create-phone">
                        </div>
                        <label for="create-website" class="col-sm-2 control-label">????????????</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="create-website">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="create-mphone" class="col-sm-2 control-label">??????</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="create-mphone">
                        </div>
                        <label for="create-status" class="col-sm-2 control-label">????????????</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <select class="form-control" id="create-state">
                                <option></option>
                                <c:forEach items="${clueStateList}" var="c">
                                    <option value="${c.value}">${c.text}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="create-source" class="col-sm-2 control-label">????????????</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <select class="form-control" id="create-source">
                                <option></option>
                                <c:forEach items="${sourceList}" var="s">
                                    <option value="${s.value}">${s.text}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>


                    <div class="form-group">
                        <label for="create-describe" class="col-sm-2 control-label">????????????</label>
                        <div class="col-sm-10" style="width: 81%;">
                            <textarea class="form-control" rows="3" id="create-description"></textarea>
                        </div>
                    </div>

                    <div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative;"></div>

                    <div style="position: relative;top: 15px;">
                        <div class="form-group">
                            <label for="create-contactSummary" class="col-sm-2 control-label">????????????</label>
                            <div class="col-sm-10" style="width: 81%;">
                                <textarea class="form-control" rows="3" id="create-contactSummary"></textarea>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="create-nextContactTime" class="col-sm-2 control-label">??????????????????</label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control time" id="create-nextContactTime">
                            </div>
                        </div>
                    </div>

                    <div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative; top : 10px;"></div>

                    <div style="position: relative;top: 20px;">
                        <div class="form-group">
                            <label for="create-address" class="col-sm-2 control-label">????????????</label>
                            <div class="col-sm-10" style="width: 81%;">
                                <textarea class="form-control" rows="1" id="create-address"></textarea>
                            </div>
                        </div>
                    </div>
                </form>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">??????</button>
                <button type="button" class="btn btn-primary" id="saveBtn">??????</button>
            </div>
        </div>
    </div>
</div>

<!-- ??????????????????????????? -->
<div class="modal fade" id="editClueModal" role="dialog">
    <div class="modal-dialog" role="document" style="width: 90%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">??</span>
                </button>
                <h4 class="modal-title">????????????</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" id="clueEditForm" role="form">
                    <input type="hidden" id="edit-id"/>
                    <div class="form-group">
                        <label for="edit-clueOwner" class="col-sm-2 control-label">?????????<span
                                style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <select class="form-control" id="edit-clueOwner">

                            </select>
                        </div>
                        <label for="edit-company" class="col-sm-2 control-label">??????<span
                                style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="edit-company">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="edit-call" class="col-sm-2 control-label">??????</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <select class="form-control" id="edit-appellation">
                                <option></option>
                                <c:forEach items="${appellationList}" var="a">
                                    <option value="${a.value}">${a.text}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <label for="edit-surname" class="col-sm-2 control-label">??????<span
                                style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="edit-fullname">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="edit-job" class="col-sm-2 control-label">??????</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="edit-job">
                        </div>
                        <label for="edit-email" class="col-sm-2 control-label">??????</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="edit-email">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="edit-phone" class="col-sm-2 control-label">????????????</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="edit-phone">
                        </div>
                        <label for="edit-website" class="col-sm-2 control-label">????????????</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="edit-website">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="edit-mphone" class="col-sm-2 control-label">??????</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="edit-mphone" value="12345678901">
                        </div>
                        <label for="edit-status" class="col-sm-2 control-label">????????????</label>
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
                        <label for="edit-source" class="col-sm-2 control-label">????????????</label>
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
                        <label for="edit-describe" class="col-sm-2 control-label">??????</label>
                        <div class="col-sm-10" style="width: 81%;">
                            <textarea class="form-control" rows="3" id="edit-description"></textarea>
                        </div>
                    </div>

                    <div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative;"></div>

                    <div style="position: relative;top: 15px;">
                        <div class="form-group">
                            <label for="edit-contactSummary" class="col-sm-2 control-label">????????????</label>
                            <div class="col-sm-10" style="width: 81%;">
                                <textarea class="form-control" rows="3" id="edit-contactSummary"></textarea>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="edit-nextContactTime" class="col-sm-2 control-label">??????????????????</label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control time" id="edit-nextContactTime">
                            </div>
                        </div>
                    </div>

                    <div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative; top : 10px;"></div>

                    <div style="position: relative;top: 20px;">
                        <div class="form-group">
                            <label for="edit-address" class="col-sm-2 control-label">????????????</label>
                            <div class="col-sm-10" style="width: 81%;">
                                <textarea class="form-control" rows="1" id="edit-address"></textarea>
                            </div>
                        </div>
                    </div>
                </form>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">??????</button>
                <button type="button" class="btn btn-primary" id="updateBtn">??????</button>
            </div>
        </div>
    </div>
</div>


<div>
    <div style="position: relative; left: 10px; top: -10px;">
        <div class="page-header">
            <h3>????????????</h3>
        </div>
    </div>
</div>

<div style="position: relative; top: -20px; left: 0px; width: 100%; height: 100%;">

    <div style="width: 100%; position: absolute;top: 5px; left: 10px;">

        <div class="btn-toolbar" role="toolbar" style="height: 80px;">
            <form class="form-inline" role="form" style="position: relative;top: 8%; left: 5px;">

                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">??????</div>
                        <input class="form-control" type="text" id="search-fullname">
                    </div>
                </div>

                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">??????</div>
                        <input class="form-control" type="text" id="search-company">
                    </div>
                </div>

                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">????????????</div>
                        <input class="form-control" type="text" id="search-phone">
                    </div>
                </div>


                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">????????????</div>
                        <select class="form-control" id="search-source">
                            <option></option>
                            <option>??????</option>
                            <option>????????????</option>
                            <option>????????????</option>
                            <option>????????????</option>
                            <option>????????????</option>
                            <option>????????????</option>
                            <option>????????????</option>
                            <option>????????????</option>
                            <option>?????????????????????</option>
                            <option>???????????????</option>
                            <option>?????????</option>
                            <option>web??????</option>
                            <option>web??????</option>
                            <option>??????</option>
                        </select>
                    </div>
                </div>

                <br>

                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">?????????</div>
                        <input class="form-control" type="text" id="search-owner">
                    </div>
                </div>


                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">??????</div>
                        <input class="form-control" type="text" id="search-mphone">
                    </div>
                </div>

                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">????????????</div>
                        <select class="form-control" id="search-state">
                            <option></option>
                            <option>????????????</option>
                            <option>????????????</option>
                            <option>?????????</option>
                            <option>????????????</option>
                            <option>????????????</option>
                            <option>?????????</option>
                            <option>????????????</option>
                        </select>
                    </div>
                </div>

                <button type="button" class="btn btn-default" id="searchBtn">??????</button>

            </form>
        </div>
        <div class="btn-toolbar" role="toolbar"
             style="background-color: #F7F7F7; height: 50px; position: relative;top: 40px;">
            <div class="btn-group" style="position: relative; top: 18%;">
                <button type="button" class="btn btn-primary" id="addBtn"><span class="glyphicon glyphicon-plus"></span>
                    ??????
                </button>
                <button type="button" class="btn btn-default" id="editBtn"><span class="glyphicon glyphicon-pencil"></span> ??????
                </button>
                <button type="button" class="btn btn-danger" id="deleteBtn"><span
                        class="glyphicon glyphicon-minus"></span> ??????
                </button>
            </div>


        </div>
        <div style="position: relative;top: 50px;">
            <table class="table table-hover">
                <thead>
                <tr style="color: #B3B3B3;">
                    <td><input type="checkbox" id="qx"/></td>
                    <td>??????</td>
                    <td>??????</td>
                    <td>????????????</td>
                    <td>??????</td>
                    <td>????????????</td>
                    <td>?????????</td>
                    <td>????????????</td>
                </tr>
                </thead>
                <tbody id="activityBody">
                <%--<tr>
                    <td><input type="checkbox" /></td>
                    <td><a style="text-decoration: none; cursor: pointer;" onclick="window.location.href='workbench/clue/detail.do?id=464072f8e0234409981c8940c9d6a506';">????????????</a></td>
                    <td>?????????</td>
                    <td>010-84846003</td>
                    <td>12345678901</td>
                    <td>??????</td>
                    <td>zhangsan</td>
                    <td>?????????</td>
                </tr>
                <tr class="active">
                    <td><input type="checkbox" /></td>
                    <td><a style="text-decoration: none; cursor: pointer;" onclick="window.location.href='detail.jsp';">????????????</a></td>
                    <td>?????????</td>
                    <td>010-84846003</td>
                    <td>12345678901</td>
                    <td>??????</td>
                    <td>zhangsan</td>
                    <td>?????????</td>
                </tr>--%>
                </tbody>
            </table>
        </div>

        <div style="height: 50px; position: relative;top: 30px;">

            <div id="activityPage"></div>

        </div>

    </div>

</div>
</body>
</html>