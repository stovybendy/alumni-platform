<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

            <jsp:include page="WEB-INF/header.jsp">
                <jsp:param name="title" value="Forum" />
            </jsp:include>

            <div style="margin-bottom: 2rem;">
                <h2>Topluluk Forumu</h2>
                <p style="color: var(--text-muted);">Düşüncelerinizi paylaşın.</p>
            </div>

            <div class="glass-panel" style="padding: 1.5rem; margin-bottom: 2rem;">
                <form action="forum" method="post">
                    <div class="form-group">
                        <label>Yeni Mesaj</label>
                        <textarea name="content" rows="3" required placeholder="Aklınızdan neler geçiyor?"></textarea>
                    </div>
                    <button type="submit" class="btn-primary" style="width: auto;">Gönder</button>
                </form>
            </div>

            <!-- Posts Table -->
            <div class="glass-panel">
                <table>
                    <thead>
                        <tr>
                            <th style="width: 20%;">Tarih</th>
                            <th style="width: 20%;">Yazan</th>
                            <th>Mesaj</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="post" items="${posts}">
                            <tr>
                                <td>
                                    <fmt:formatDate value="${post.timestamp}" pattern="dd-MM-yyyy HH:mm" />
                                </td>
                                <td>${post.authorName}</td>
                                <td>
                                    ${post.content}
                                    <c:if test="${sessionScope.user.role == 'admin'}">
                                        <form action="forum" method="post" style="display:inline; float:right;">
                                            <input type="hidden" name="action" value="delete">
                                            <input type="hidden" name="id" value="${post.id}">
                                            <button type="submit"
                                                style="background:none; border:none; color: #ef4444; cursor:pointer;">[Sil]</button>
                                        </form>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty posts}">
                            <tr>
                                <td colspan="3" style="text-align: center;">Henüz mesaj yok. İlk yazan siz olun!</td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>

                <!-- Pagination -->
                <div style="padding: 1rem; display: flex; justify-content: center; gap: 0.5rem;">
                    <c:if test="${currentPage > 1}">
                        <a href="forum?page=${currentPage - 1}" class="btn-primary"
                            style="padding: 0.25rem 0.75rem;">&lt; Önceki</a>
                    </c:if>

                    <span style="align-self: center;">Sayfa ${currentPage} / ${totalPages == 0 ? 1 : totalPages}</span>

                    <c:if test="${currentPage < totalPages}">
                        <a href="forum?page=${currentPage + 1}" class="btn-primary"
                            style="padding: 0.25rem 0.75rem;">Sonraki &gt;</a>
                    </c:if>
                </div>
            </div>

            <jsp:include page="WEB-INF/footer.jsp" />
