<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

            <jsp:include page="WEB-INF/header.jsp">
                <jsp:param name="title" value="Fotoğraf Detayı" />
            </jsp:include>

            <div class="glass-panel" style="padding: 2rem; margin-bottom: 2rem; text-align: center;">
                <h2 style="margin-bottom: 1rem;">${photo.description}</h2>

                <img src="${photo.url}" alt="${photo.description}" usemap="#photomap"
                    style="max-width: 100%; border-radius: 8px; max-height: 600px;">

                <map name="photomap">
                    <area shape="rect" coords="0,0,100,100" href="index.jsp" alt="Demo Etiket">
                </map>

                <p style="margin-top: 1rem; color: var(--text-muted); font-size: 0.9rem;">
                    (İpucu: Kişilerin üzerine tıklayarak profillerine gidebilirsiniz - Demo)
                </p>
            </div>

            <div class="glass-panel" style="padding: 2rem;">
                <h3>Yorumlar</h3>
                <form action="photos" method="post" style="margin: 1rem 0;">
                    <input type="hidden" name="action" value="add_comment">
                    <input type="hidden" name="mediaId" value="${photo.id}">
                    <div class="form-group">
                        <textarea name="content" rows="3" required placeholder="Bir yorum yaz..."></textarea>
                    </div>
                    <button type="submit" class="btn-primary" style="width: auto;">Yorum Yap</button>
                </form>

                <table>
                    <tbody>
                        <c:forEach var="comment" items="${comments}">
                            <tr>
                                <td style="width: 20%; color: var(--text-muted);">
                                    <fmt:formatDate value="${comment.timestamp}" pattern="dd-MM-yyyy HH:mm" />
                                    <br>
                                    <strong>${comment.authorName}</strong>
                                </td>
                                <td>${comment.content}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <jsp:include page="WEB-INF/footer.jsp" />