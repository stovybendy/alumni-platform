<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>

        <jsp:include page="WEB-INF/header.jsp">
            <jsp:param name="title" value="Durum" />
        </jsp:include>

        <div style="margin-bottom: 2rem;">
            <h2>Kim, Nerede, Ne Yapıyor?</h2>
            <p style="color: var(--text-muted);">Herkesin güncel durumuna hızlı bir bakış.</p>
        </div>

        <div class="glass-panel" style="overflow-x: auto;">
            <table style="min-width: 800px;">
                <thead>
                    <tr>
                        <th>İsim</th>
                        <th>Şehir</th>
                        <th>Şu Anki İş</th>
                        <th>Şu Anki Okul</th>
                        <th>E-posta</th>
                        <th>Hobiler</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="u" items="${users}">
                        <tr>
                            <td>
                                <a href="profile?id=${u.id}" style="font-weight: bold;">${u.firstName} ${u.lastName}</a>
                            </td>
                            <td>${u.city}</td>
                            <td>${u.currentJob}</td>
                            <td>${u.currentSchool}</td>
                            <td>${u.email}</td>
                            <td>
                                <c:forEach var="hobby" items="${u.hobbies}">
                                    ${hobby},
                                </c:forEach>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <jsp:include page="WEB-INF/footer.jsp" />