<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
    <jsp:include page="WEB-INF/header.jsp">
        <jsp:param name="title" value="Kayıt Ol" />
    </jsp:include>

    <div class="glass-panel" style="max-width: 600px; margin: 0 auto; padding: 2rem;">
        <h2 style="text-align: center; margin-bottom: 2rem;">Aramıza Katılın</h2>

        <% String error=(String) request.getAttribute("error"); %>
            <% if (error !=null) { %>
                <div class="alert">
                    <%= error %>
                </div>
                <% } %>

                    <form action="register" method="post">
                        <div class="form-group">
                            <label>Kullanıcı Adı</label>
                            <input type="text" name="username" required>
                        </div>

                        <div class="form-group">
                            <label>Şifre</label>
                            <input type="password" name="password" required>
                        </div>

                        <div class="grid" style="grid-template-columns: 1fr 1fr; gap: 1rem;">
                            <div class="form-group">
                                <label>Ad</label>
                                <input type="text" name="firstName" required>
                            </div>
                            <div class="form-group">
                                <label>Soyad</label>
                                <input type="text" name="lastName" required>
                            </div>
                        </div>

                        <div class="form-group">
                            <label>E-posta</label>
                            <input type="email" name="email" required>
                        </div>

                        <div class="form-group">
                            <label>Şehir</label>
                            <select name="city">
                                <option value="Istanbul">İstanbul</option>
                                <option value="Ankara">Ankara</option>
                                <option value="Izmir">İzmir</option>
                                <option value="Sakarya">Sakarya</option>
                                <option value="Other">Diğer</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label>Şu Anki İş</label>
                            <input type="text" name="currentJob">
                        </div>

                        <div class="form-group">
                            <label>Şu Anki Okul</label>
                            <input type="text" name="currentSchool">
                        </div>

                        <div class="form-group">
                            <label>Cinsiyet</label>
                            <div style="display: flex; gap: 1rem; color: var(--text-color);">
                                <label style="display: flex; align-items: center; gap: 0.5rem; font-weight: normal;">
                                    <input type="radio" name="gender" value="Male" style="width: auto;"> Erkek
                                </label>
                                <label style="display: flex; align-items: center; gap: 0.5rem; font-weight: normal;">
                                    <input type="radio" name="gender" value="Female" style="width: auto;"> Kadın
                                </label>
                            </div>
                        </div>

                        <div class="form-group">
                            <label>Hobiler</label>
                            <div
                                style="display: grid; grid-template-columns: 1fr 1fr; gap: 0.5rem; color: var(--text-color);">
                                <label style="display: flex; align-items: center; gap: 0.5rem; font-weight: normal;">
                                    <input type="checkbox" name="hobbies" value="Kitap Okuma" style="width: auto;">
                                    Kitap Okuma
                                </label>
                                <label style="display: flex; align-items: center; gap: 0.5rem; font-weight: normal;">
                                    <input type="checkbox" name="hobbies" value="Spor" style="width: auto;"> Spor
                                </label>
                                <label style="display: flex; align-items: center; gap: 0.5rem; font-weight: normal;">
                                    <input type="checkbox" name="hobbies" value="Yazılım" style="width: auto;"> Yazılım
                                </label>
                                <label style="display: flex; align-items: center; gap: 0.5rem; font-weight: normal;">
                                    <input type="checkbox" name="hobbies" value="Seyahat" style="width: auto;"> Seyahat
                                </label>
                            </div>
                        </div>

                        <button type="submit" class="btn-primary">Kayıt Ol</button>
                    </form>
    </div>

    <jsp:include page="WEB-INF/footer.jsp" />