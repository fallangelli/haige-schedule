<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<aside class="right-side">
    <!-- Main content -->
    <section class="content">
        <div class="row">
            <div class="col-md-10">
                <div class="box">
                    <div class="box-header">
                        <h3 class="box-title">编辑课程类型</h3>
                    </div>
                    <form id="classTypeEditForm" role="form" class="form-horizontal" method="post"
                          action="${ctx}/classtype/save">
                        <div class="box-body">
                            <input type="hidden" id="id" name="id" value="${type.id}"/>

                            <div class="form-group">
                                <label for="name" class="col-sm-2 control-label">课程类型名称</label>

                                <div class="col-sm-5">
                                    <input type="text" class="form-control" name="name" id="name" placeholder="名称"
                                           value="${type.name}"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="comment" class="col-sm-2 control-label">课程类型描述</label>

                                <div class="col-sm-5">
                                    <input type="text" class="form-control" name="comment" id="comment"
                                           placeholder="描述" value="${type.comment}"/>
                                </div>
                            </div>

                            <div class="box-footer" style="text-align: center;margin: 0">
                                <button type="submit" class="btn btn-primary btn-flat">保存</button>

                                <button type="button" class="btn btn-success btn-flat" style="margin-right: 20px"
                                        onclick="window.history.go(-1);">返回
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
                <!-- /.box -->
            </div>

        </div>
    </section>
    <!-- /.content -->
</aside>
