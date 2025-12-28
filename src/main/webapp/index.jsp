<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
    <jsp:include page="WEB-INF/header.jsp">
        <jsp:param name="title" value="Anasayfa" />
    </jsp:include>

    <div style="text-align: center; margin-top: 4rem;">
        <h1
            style="font-size: 3rem; margin-bottom: 1rem; background: linear-gradient(to right, #60a5fa, #3b82f6); -webkit-background-clip: text; -webkit-text-fill-color: transparent; background-clip: text;">
            Üniversite Mezun Platformu
        </h1>
        <p style="font-size: 1.2rem; color: var(--text-muted); max-width: 600px; margin: 0 auto 3rem;">
            Sınıf arkadaşlarınızla yeniden bağlantı kurun, anılarınızı paylaşın ve herkesin neler yaptığını görün.
        </p>

        <div class="grid" style="gap: 2rem;">
            <div class="glass-panel card">
                <h3>🎓 Kişiler</h3>
                <p>Eski dostlarınızı bulun ve şu an neler yaptıklarını öğrenin.</p>
            </div>
            <div class="glass-panel card">
                <h3>📸 Galeri</h3>
                <p>Eski güzel günlerden video ve fotoğraflar paylaşın.</p>
            </div>
            <div class="glass-panel card">
                <h3>💬 Forum</h3>
                <p>Sohbet edin ve buluşmalar organize edin.</p>
            </div>
        </div>
    </div>

    <jsp:include page="WEB-INF/footer.jsp" />