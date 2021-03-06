<%@ page import="java.util.Date" %>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html>
<html lang="zh">
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<aside class="right-side">
    <!-- Content Header (Page header) -->
    <section class="content-header">
        <h1>
            课程活动管理
        </h1>
        <ol class="breadcrumb">
            <li><a href="${ctx}/index"><i class="fa fa-dashboard"></i> 首页</a></li>
        </ol>
    </section>

    <section class="content">
        <div class="row">
            <div class="col-xs-12">
                <div class="box">
                    <div class="box-header">
                        <h3 class="box-title">课程活动列表</h3>
                        <shiro:hasAnyRoles name="root,admin,manager">
                            <div class="box-tools pull-right" style="margin-right: 80px;">
                                <a class="btn btn-primary btn-flat" style="color: #ffffff;" role="button"
                                   onclick="addNewSchedule();">添加</a>
                            </div>
                        </shiro:hasAnyRoles>
                    </div>
                    <div class="box-body table-responsive">
                        <form class="form-horizontal" role="form" method="post"
                              action="${ctx}/schedule/${scheduleType}/list">
                            <div class="form-group">
                                <label for="queryName" class="col-sm-1 control-label">类型:</label>

                                <div class="col-sm-2">
                                    <input type="text" value="${queryName}" class="form-control"
                                           id="queryName"
                                           name="queryName" placeholder="类型">
                                </div>

                                <label for="queryTeacherId" class="col-sm-1 control-label">教练:</label>

                                <div class="col-sm-2">
                                    <select name="queryTeacherId" id="queryTeacherId" style="width: 100%">
                                        <option value=""></option>
                                        <c:forEach items="${teachers}" var="r">
                                            <option value="${r.id}"
                                                    <c:if test="${queryTeacherId==r.id}">selected</c:if> >${r.realName}</option>
                                        </c:forEach>
                                    </select>
                                </div>

                                <label for="queryDate" class="col-sm-2 control-label">日期:</label>

                                <div class="col-sm-2">
                                    <input type="text" value="${queryScheduleDate}" class="form-control"
                                           id="queryDate"
                                           name="queryDate" placeholder="日期">
                                </div>


                                <div class="col-sm-2">
                                <span class="input-group-btn">
                                    <button type="submit"
                                            class="btn btn-primary btn-flat">查询
                                    </button>
                                </span>
                                </div>
                            </div>


                        </form>
                        <table id="scheduleTable" style="margin-top: 10px" class="table table-bordered table-striped">
                            <thead>
                            <tr>
                                <th class="text-center">类型</th>
                                <th class="text-center">教练</th>
                                <th class="text-center">日期</th>
                                <th class="text-center">开始时间</th>
                                <th class="text-center">结束时间</th>
                                <th class="text-center">扣除课时</th>
                                <th class="text-center" width="10%">学员</th>
                                <th class="text-center" style="width: 200px">操 作</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:if test="${not empty schedules}">
                                <c:forEach items="${schedules}" var="item">
                                    <tr>
                                        <td class="text-center">${item.classBase.name}</td>
                                        <td class="text-center">${item.teacher.realName}</td>
                                        <c:set var="nowDate" value="<%=new Date()%>"></c:set>
                                        <td class="text-center"
                                                <c:if test="${item.scheduleDate < nowDate}"> style="background-color: indianred" </c:if>
                                        >${item.scheduleDate}</td>
                                        <td class="text-center">
                                            <fmt:formatDate value="${item.startTime}" pattern="HH:mm"/>
                                        </td>
                                        <td class="text-center">
                                            <fmt:formatDate value="${item.endTime}" pattern="HH:mm"/>
                                        </td>
                                        <td class="text-center">${item.costTimes}</td>
                                        <td class="text-center" style="WORD-WRAP: break-word">
                                            <c:forEach items="${item.members}" var="member">
                                                ${member.realName}
                                            </c:forEach>
                                        </td>
                                        <td class="text-center">
                                            <shiro:hasAnyRoles name="root,admin">
                                                <a class="btn btn-primary btn-xs"
                                                   onclick="finishSchedule(${item.id});">
                                                    <i class="fa fa-play">结束</i>
                                                </a>
                                            </shiro:hasAnyRoles>
                                            <shiro:hasAnyRoles name="coach">
                                                <c:if test="${currUserId== item.teacher.id}">
                                                    <a class="btn btn-primary btn-xs"
                                                       onclick="finishSchedule(${item.id});">
                                                        <i class="fa fa-play">结束</i>
                                                    </a>
                                                </c:if>
                                            </shiro:hasAnyRoles>

                                            <a class="btn btn-primary btn-xs" onclick="editSchedule (${item.id});">
                                                <i class="fa fa-edit">详情</i>
                                            </a>
                                            <shiro:hasAnyRoles name="root,admin,manager">
                                                <a class="btn btn-primary btn-xs" onclick="deleteSchedule(${item.id});">
                                                    <i class="fa fa-times">删除</i>
                                                </a>
                                            </shiro:hasAnyRoles>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:if>

                            </tbody>
                        </table>

                    </div>
                    <div class="box-footer" style="text-align: center;margin: 0">
                        <p class="pull-left">共 <span>${totalCount}</span> 项&nbsp;&nbsp;页次 : <span><span
                                style="color: red; "><c:choose><c:when
                                test="${totalPage==0}">0</c:when><c:otherwise>${page}</c:otherwise></c:choose></span> / ${totalPage}</span>
                        </p>
                        <ul id="paginator" class="pagination">
                        </ul>
                    </div>
                </div>
                <!-- /.box -->
            </div>
        </div>
    </section>
</aside>


<div class="modal fade" id="cmModal" tabindex="-100" role="dialog" aria-labelledby="mcModalTitle" aria-hidden="true">
    <div class="modal-dialog">
        <form role="form" class="form-horizontal" method="post" id="evaluationForm"
              action="${ctx}/schedule/${scheduleType}/finish">
            <div class="modal-content" style="width: 650px;">
                <button class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <div class="modal-header">
                    <h4 class="modal-title" id="cmModalTitle">结束课程</h4>
                </div>
                <div class="modal-body">

                    <div class="box-body">
                        <input type="hidden" id="ev_scheduleid" name="ev_scheduleid"/>

                        <table id="evaluationTable" class="table table-bordered table-striped">
                            <thead>
                            <tr>
                                <th class="text-center">用户名</th>
                                <th class="text-center">姓名</th>
                                <th class="text-center" style="width: 450px;">评价</th>
                            </tr>
                            </thead>
                            <tbody id="evaluationTableBody">

                            </tbody>
                        </table>

                        <%--<div class="col-sm-12">--%>
                        <%--<div class="form-group">--%>
                        <%----%>
                        <%--<label for="evaluation" class="col-sm-2 control-label">评价</label>--%>

                        <%--<div class="col-sm-10">--%>
                        <%--<textarea type="text" class="form-control" name="evaluation" id="evaluation"--%>
                        <%--placeholder="评价"></textarea>--%>
                        <%--</div>--%>
                        <%--</div>--%>
                        <%--</div>--%>

                    </div>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消
                    </button>
                    <button type="button" class="btn btn-primary btn-flat" onclick="submitFinish()">结束课程</button>
                </div>
            </div>
        </form>
    </div>
</div>
