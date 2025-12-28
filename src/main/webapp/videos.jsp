<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>

        <jsp:include page="WEB-INF/header.jsp">
            <jsp:param name="title" value="Videolar" />
        </jsp:include>

        <div style="margin-bottom: 2rem; display: flex; justify-content: space-between; align-items: center;">
            <div>
                <h2>Video Galerisi</h2>
                <p style="color: var(--text-muted);">En güzel anları izleyin.</p>
            </div>

            <div class="glass-panel" style="padding: 1rem;">
                <h4 style="margin-bottom: 0.5rem;">Video Ekle</h4>
                <form action="videos" method="post" style="display: flex; gap: 0.5rem;">
                    <input type="hidden" name="action" value="add_video">
                    <input type="text" name="url" placeholder="Youtube ID (örn: dQw4..)" required style="width: 200px;">
                    <input type="text" name="description" placeholder="Açıklama" required style="width: 200px;">
                    <button type="submit" class="btn-primary" style="width: auto;">Ekle</button>
                </form>
            </div>
        </div>

        <div class="grid">
            <c:forEach var="v" items="${videos}">
                <div class="glass-panel card">
                    <a href="video?id=${v.id}">
                        <img src="https://img.youtube.com/vi/${v.url}/hqdefault.jpg" alt="${v.description}" />
                    </a>
                    <p style="margin-top: 0.5rem;">${v.description}</p>
                </div>
            </c:forEach>
        </div>

        <jsp:include page="WEB-INF/footer.jsp" />