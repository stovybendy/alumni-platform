<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

            <jsp:include page="WEB-INF/header.jsp">
                <jsp:param name="title" value="${profileUser.firstName} Profili" />
            </jsp:include>

            <div class="glass-panel" style="padding: 2rem; margin-bottom: 2rem;">
                <div style="display: flex; gap: 2rem; align-items: start; flex-wrap: wrap;">
                    <div
                        style="width: 150px; height: 150px; background: #334; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 3rem;">
                        ${profileUser.username.substring(0,1).toUpperCase()}
                    </div>
                    <div style="flex: 1;">
                        <h1 style="margin-bottom: 0.5rem;">${profileUser.firstName} ${profileUser.lastName}</h1>
                        <p style="color: var(--primary-color); margin-bottom: 1rem;">${profileUser.username}</p>

                        <div
                            style="display: grid; grid-template-columns: repeat(auto-fill, minmax(200px, 1fr)); gap: 1rem;">
                            <div><strong>E-posta:</strong> ${profileUser.email}</div>
                            <div><strong>Şehir:</strong> ${profileUser.city}</div>
                            <div><strong>İş:</strong> ${profileUser.currentJob}</div>
                            <div><strong>Okul:</strong> ${profileUser.currentSchool}</div>
                            <div><strong>Cinsiyet:</strong> ${profileUser.gender}</div>
                        </div>

                        <div style="margin-top: 1rem;">
                            <strong>Hobiler:</strong>
                            <c:forEach var="hobby" items="${profileUser.hobbies}">
                                <span
                                    style="background: rgba(255,255,255,0.1); padding: 2px 8px; border-radius: 4px; margin-right: 4px; font-size: 0.9rem;">${hobby}</span>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>

            <div class="glass-panel" style="padding: 2rem; margin-bottom: 2rem;">
                <h3>Yıllık Yorumları / Anı Defteri</h3>
                <form action="profile" method="post" style="margin: 1rem 0;">
                    <input type="hidden" name="targetUserId" value="${profileUser.id}">
                    <div class="form-group">
                        <textarea name="content" rows="3" required
                            placeholder="${profileUser.firstName} için bir anı yaz..."></textarea>
                    </div>
                    <button type="submit" class="btn-primary" style="width: auto;">Yıllığı İmzala</button>
                </form>

                <table>
                    <thead>
                        <tr>
                            <th style="width: 20%;">Tarih</th>
                            <th style="width: 20%;">Yazan</th>
                            <th>Mesaj</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="comment" items="${comments}">
                            <tr>
                                <td>
                                    <fmt:formatDate value="${comment.timestamp}" pattern="dd-MM-yyyy HH:mm" />
                                </td>
                                <td>${comment.authorName}</td>
                                <td>${comment.content}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <jsp:include page="WEB-INF/footer.jsp" />