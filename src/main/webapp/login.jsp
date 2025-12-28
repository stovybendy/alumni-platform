<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
    <jsp:include page="WEB-INF/header.jsp">
        <jsp:param name="title" value="Giriş Yap" />
    </jsp:include>

    <div class="glass-panel" style="max-width: 400px; margin: 4rem auto; padding: 2rem;">
        <h2 style="text-align: center; margin-bottom: 2rem;">Tekrar Kavuştuk</h2>

        <% String error=(String) request.getAttribute("error"); %>
            <% if (error !=null) { %>
                <div class="alert">
                    <%= error %>
                </div>
                <% } %>

                    <% if (request.getParameter("registered") !=null) { %>
                        <div class="alert"
                            style="background: rgba(16, 185, 129, 0.2); border-color: rgba(16, 185, 129, 0.5); color: #6ee7b7;">
                            Kayıt başarılı! Lütfen giriş yapınız.
                        </div>
                        <% } %>

                            <form action="login" method="post">
                                <div class="form-group">
                                    <label>Kullanıcı Adı</label>
                                    <input type="text" name="username" required>
                                </div>

                                <div class="form-group">
                                    <label>Şifre</label>
                                    <input type="password" name="password" required>
                                </div>

                                <button type="submit" class="btn-primary">Giriş Yap</button>
                            </form>

                            <div style="margin-top: 1rem; text-align: center;">
                                <p style="color: var(--text-muted); font-size: 0.9rem;">
                                    Hesabınız yok mu? <a href="register.jsp">Kayıt Olun</a>
                                </p>
                            </div>
    </div>

    <jsp:include page="WEB-INF/footer.jsp" />