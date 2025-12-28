<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <!DOCTYPE html>
        <html>

        <head>
            <title>${param.title} | Mezun Platformu</title>
            <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
            <link rel="preconnect" href="https://fonts.googleapis.com">
            <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
            <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap"
                rel="stylesheet">
        </head>

        <body>
            <header class="glass-panel">
                <div class="logo">
                    <a href="${pageContext.request.contextPath}/" style="font-size: 1.5rem; font-weight: 700;">🎓
                        MezunPlatform</a>
                </div>
                <nav>
                    <ul>
                        <li><a href="${pageContext.request.contextPath}/">Anasayfa</a></li>
                        <c:if test="${not empty sessionScope.user}">
                            <li><a href="${pageContext.request.contextPath}/forum">Forum</a></li>
                            <li><a href="${pageContext.request.contextPath}/people">Kişiler</a></li>
                            <li><a href="${pageContext.request.contextPath}/photos">Fotoğraflar</a></li>
                            <li><a href="${pageContext.request.contextPath}/videos">Videolar</a></li>
                            <li><a href="${pageContext.request.contextPath}/status">Kim Nerede?</a></li>
                            <li><a href="${pageContext.request.contextPath}/map.jsp">Harita</a></li>
                            <li>
                                <span style="color: var(--text-muted);">Merhaba, ${sessionScope.user.username}</span>
                                <c:if test="${sessionScope.user.role == 'admin'}">
                                    <span
                                        style="background: var(--primary-color); padding: 2px 6px; border-radius: 4px; font-size: 0.8rem;">YÖNETİCİ</span>
                                </c:if>
                            </li>
                            <li><a href="${pageContext.request.contextPath}/logout">Çıkış</a></li>
                        </c:if>
                        <c:if test="${empty sessionScope.user}">
                            <li><a href="${pageContext.request.contextPath}/login.jsp">Giriş</a></li>
                            <li><a href="${pageContext.request.contextPath}/register.jsp">Kayıt Ol</a></li>
                        </c:if>
                    </ul>
                </nav>
                <div class="server-time" style="font-size: 0.8rem; color: var(--text-muted);">
                    <%= new java.text.SimpleDateFormat("dd.MM.yyyy HH:mm").format(new java.util.Date()) %>
                </div>
            </header>
            <main>