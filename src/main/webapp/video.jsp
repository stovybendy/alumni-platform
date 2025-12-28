<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

            <jsp:include page="WEB-INF/header.jsp">
                <jsp:param name="title" value="Video Detayı" />
            </jsp:include>

            <div class="glass-panel" style="padding: 2rem; margin-bottom: 2rem; text-align: center;">
                <h2 style="margin-bottom: 1rem;">${video.description}</h2>

                <div
                    style="position: relative; padding-bottom: 56.25%; height: 0; overflow: hidden; max-width: 100%; border-radius: 12px;">
                    <iframe src="https://www.youtube.com/embed/${video.url}?autoplay=1"
                        style="position: absolute; top: 0; left: 0; width: 100%; height: 100%; border:0;"
                        allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
                        allowfullscreen>
                    </iframe>
                </div>
            </div>
 
            <div class="glass-panel" style="padding: 2rem;">
                <h3>Yorumlar</h3>
                <form action="videos" method="post" style="margin: 1rem 0;">
                    <input type="hidden" name="action" value="add_comment">
                    <input type="hidden" name="mediaId" value="${video.id}">
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
