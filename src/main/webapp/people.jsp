<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>

        <jsp:include page="WEB-INF/header.jsp">
            <jsp:param name="title" value="Kişiler" />
        </jsp:include>

        <div style="margin-bottom: 2rem;">
            <h2>Sınıf Listesi</h2>
            <p style="color: var(--text-muted);">Eski arkadaşlarla yeniden buluşun.</p>
        </div>

        <div class="grid">
            <c:if test="${param.msg == 'make_admin_success'}">
                <div class="alert"
                    style="width: 100%; background: rgba(16, 185, 129, 0.2); border-color: rgba(16, 185, 129, 0.5); color: #6ee7b7; margin-bottom: 1rem;">
                    Kullanıcı başarıyla yönetici yapıldı.
                </div>
            </c:if>
            <c:if test="${param.msg == 'delete_success'}">
                <div class="alert"
                    style="width: 100%; background: rgba(239, 68, 68, 0.2); border-color: rgba(239, 68, 68, 0.5); color: #f87171; margin-bottom: 1rem;">
                    Kullanıcı silindi.
                </div>
            </c:if>

            <c:forEach var="u" items="${users}">
                <div class="glass-panel card" style="align-items: center; text-align: center;">
                    <div
                        style="width: 100px; height: 100px; background: #334; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 2rem; margin-bottom: 1rem;">
                        ${u.username.substring(0,1).toUpperCase()}
                    </div>
                    <h3>${u.firstName} ${u.lastName}</h3>
                    <p style="color: var(--text-muted); font-size: 0.9rem;">${u.email}</p>
                    <a href="profile?id=${u.id}" class="btn-primary" style="margin-top: 1rem; width: 100%;">Profili
                        Gör</a>

                    <c:if test="${sessionScope.user.role == 'admin'}">
                        <div style="margin-top: 0.5rem; display: flex; gap: 0.5rem; width: 100%;">
                            <c:if test="${u.role != 'admin'}">
                                <form action="user-management" method="post" style="flex: 1;">
                                    <input type="hidden" name="action" value="make_admin">
                                    <input type="hidden" name="id" value="${u.id}">
                                    <button type="submit" class="btn-primary"
                                        style="background-color: #f59e0b; width: 100%; font-size: 0.8rem;">Yönetici</button>
                                </form>
                            </c:if>
                            <c:if test="${u.role == 'admin'}">
                                <div
                                    style="flex: 1; align-self: center; font-size: 0.8rem; color: #f59e0b; font-weight: bold;">
                                    YÖNETİCİ</div>
                            </c:if>

                            <form action="user-management" method="post" style="flex: 1;">
                                <input type="hidden" name="action" value="delete">
                                <input type="hidden" name="id" value="${u.id}">
                                <button type="submit" class="btn-primary"
                                    style="background-color: #ef4444; width: 100%; font-size: 0.8rem;"
                                    onclick="return confirm('Bu kullanıcıyı silmek istediğinize emin misiniz?');">Sil</button>
                            </form>
                        </div>
                    </c:if>
                </div>
            </c:forEach>
        </div>

        <jsp:include page="WEB-INF/footer.jsp" />