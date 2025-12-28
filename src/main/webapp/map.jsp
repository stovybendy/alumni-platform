<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>

<jsp:include page="WEB-INF/header.jsp">
    <jsp:param name="title" value="Harita" />
</jsp:include>

<div style="text-align: center; margin-bottom: 1rem;">
    <h2>Harita</h2>
    <p>Yakınlaştırmak için aşağıdaki kontrolleri kullanın.</p>
</div>

<style>
    #map-container {
        width: 100%;
        height: 600px;
        overflow: hidden;
        position: relative;
        border: 1px solid rgba(255, 255, 255, 0.1);
        background-color: #f0f0f0;
        cursor: grab;
    }

    #map-container.dragging {
        cursor: grabbing;
    }

    #map-wrapper {
        position: absolute;
        top: 0;
        left: 0;
        transition: transform 0.1s;
        transform-origin: 0 0;
    }

    #map-image {
        display: block;
        width: 1200px;
        height: auto;
        user-select: none;
    }
</style>

<div class="glass-panel" style="padding: 1rem;">
    <div class="map-controls" style="margin-bottom: 1rem; text-align: center;">
        <button class="btn-primary" type="button" onclick="zoomIn()">Yakınlaştır (+)</button>
        <button class="btn-primary" type="button" onclick="zoomOut()">Uzaklaştır (-)</button>
        <button class="btn-primary" type="button" onclick="resetZoom()">Sıfırla</button>
        <span id="zoom-level" style="margin-left: 1rem;">Zoom: 100%</span>
    </div>

    <div id="map-container">
        <div id="map-wrapper">
            <img id="map-image"
                 src="https://www.kgm.gov.tr/SiteCollectionImages/KGMimages/Haritalar/turistik.jpg"
                 alt="Türkiye Haritası"
                 draggable="false"
                 onerror="console.log('Görsel yüklenemedi:', this.src); alert('Harita görseli yüklenemedi. Lütfen internet bağlantınızı kontrol edin.');"
                 onload="console.log('Görsel başarıyla yüklendi!', this.width, 'x', this.height)">
        </div>
    </div>
</div>

<script>
    let currentZoom = 1;
    let posX = 0;
    let posY = 0;
    let isDragging = false;
    let startX = 0;
    let startY = 0;

    function updateTransform() {
        const wrapper = document.getElementById('map-wrapper');
        const zoomLevel = document.getElementById('zoom-level');
        
        wrapper.style.transform = 'translate(' + posX + 'px, ' + posY + 'px) scale(' + currentZoom + ')';
        zoomLevel.textContent = 'Zoom: ' + Math.round(currentZoom * 100) + '%';
        
        console.log('Transform güncellendi - Zoom:', currentZoom, 'Pos:', posX, posY);
    }

    function zoomIn() {
        currentZoom += 0.2;
        if (currentZoom > 5) currentZoom = 5;
        updateTransform();
    }

    function zoomOut() {
        currentZoom -= 0.2;
        if (currentZoom < 0.3) currentZoom = 0.3;
        updateTransform();
    }

    function resetZoom() {
        currentZoom = 1;
        posX = 0;
        posY = 0;
        updateTransform();
    }

    // Sayfa yüklendiğinde başlat
    document.addEventListener('DOMContentLoaded', function() {
        const container = document.getElementById('map-container');
        const wrapper = document.getElementById('map-wrapper');
        
        updateTransform();
        console.log('Harita sistemi hazır');

        // Mouse ile sürükleme
        container.addEventListener('mousedown', function(e) {
            isDragging = true;
            startX = e.clientX - posX;
            startY = e.clientY - posY;
            container.classList.add('dragging');
            e.preventDefault();
        });

        document.addEventListener('mousemove', function(e) {
            if (!isDragging) return;
            
            posX = e.clientX - startX;
            posY = e.clientY - startY;
            updateTransform();
        });

        document.addEventListener('mouseup', function() {
            isDragging = false;
            container.classList.remove('dragging');
        });

        // Mouse tekerleği ile zoom
        container.addEventListener('wheel', function(e) {
            e.preventDefault();
            if (e.deltaY < 0) {
                zoomIn();
            } else {
                zoomOut();
            }
        });
    });
</script>

<jsp:include page="WEB-INF/footer.jsp" />