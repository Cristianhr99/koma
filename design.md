# KOMA — Especificación de diseño

> Documento de dirección de arte para agentes IA y personas que amplíen el proyecto.
> Versión 1.0 · 2026 · Tema: archivo visual de paneles icónicos del manga.

---

## 1. Resumen

**KOMA** es un archivo editorial independiente de viñetas de manga. La web presenta
nueve piezas curadas, un panel destacado de la semana, una línea de tiempo y una
newsletter. El tono es de museo, no de tienda: pocas piezas, mucho aire y una
jerarquía tipográfica agresiva.

**Promesa de marca:** «El instante que lo cambió todo».
**Idea visual:** una página de manga impresa en papel cálido, ampliada a escala de
cartel y montada sobre una pared negra.

---

## 2. Concepto creativo: «tinta editorial»

La estética combina tres referencias:

1. **Editorial japonés:** tramas de puntos (screentone), líneas de velocidad,
   kanji como acento gráfico y numeración de figura (`Fig. 01`).
2. **Editorial de moda/arquitectura:** rejilla estricta, reglas de 1 px,
   titulares condensados y mucho espacio negativo.
3. **Web premium tipo Apple:** contenedores anchos, secciones que alternan
   negro y papel, navegación discreta y microinteracciones contenidas.

La página debe sentirse **impresa, no ilustrada**: el color no decora, marca
jerarquía. El rojo bermellón es tinta de sello, no un botón de alerta.

---

## 3. Público y objetivos

- **Público:** lectores de manga, estudiantes de diseño y personas curiosas por
  la cultura visual japonesa, 18–40 años.
- **Objetivo principal:** que el visitante entienda la propuesta en menos de
  5 segundos y explore al menos un panel del archivo.
- **Objetivo secundario:** suscribirse a la newsletter dominical.
- **Sensación buscada:** silencio, precisión, obsesión por el detalle.

---

## 4. Principios de diseño

1. **Una idea por pantalla.** Cada sección tiene un único protagonista visual.
2. **Contraste antes que color.** El sistema funciona en blanco y negro; el rojo
   aparece después, con moderación.
3. **La tipografía es la imagen.** Los titulares pueden ocupar el 70 % del ancho.
4. **Reglas visibles.** Las líneas de 1 px ordenan la página como una retícula
   de revista; no se ocultan.
5. **Movimiento con freno.** Solo tres animaciones: entrada del hero, marquesina
   y elevación al hover. Nada rebota, nada gira sin motivo.

---

## 5. Paleta

| Token | Hex | Uso | Notas de contraste |
|---|---|---|---|
| `--ink` | `#08080A` | Fondo principal, texto sobre papel | Base |
| `--ink-1` | `#0E0E12` | Superficies elevadas, dropdowns | — |
| `--ink-2` | `#16161C` | Fondo de imágenes, tarjetas | — |
| `--ink-3` | `#1F1F27` | Hover de menús, scrollbar | — |
| `--paper` | `#F2ECE1` | Sección destacada, botones invertidos | 17:1 sobre ink |
| `--paper-2` | `#D9D1C1` | Texto secundario claro | 12:1 sobre ink |
| `--muted` | `#A29B8D` | Párrafos y metadatos en oscuro | 7:1 sobre ink |
| `--muted-dark` | `#6B6458` | Párrafos y metadatos en papel | 5:1 sobre paper |
| `--red` | `#FF4A2F` | Acento, CTA, foco, sello | 6.5:1 sobre ink |
| `--red-deep` | `#C92A13` | Acento sobre papel | 4.9:1 sobre paper |
| `--line` | `rgba(242,236,225,.14)` | Reglas en oscuro | Decorativo |
| `--line-dark` | `rgba(8,8,10,.14)` | Reglas en papel | Decorativo |

**Reglas de color**

- El rojo nunca supera el **10 %** de la superficie visible.
- Prohibido un segundo acento (azul, verde, morado). Si hace falta jerarquía,
  usar peso tipográfico o escala, no color.
- Los degradados solo se permiten como **halo ambiental** del hero y como
  **trama de puntos**. Nunca en botones, tarjetas o texto.
- Sobre papel, el acento cambia a `--red-deep` para mantener contraste.

---

## 6. Tipografía

### Familias (Google Fonts CDN)

| Rol | Familia | Pesos | Uso |
|---|---|---|---|
| Display | **Anton** | 400 | H1, H2, títulos de tarjeta, cifras, wordmark |
| Acento | **Instrument Serif** | 400 italic | Una palabra emocional por titular, citas |
| Texto / UI | **Inter** | 300, 400, 500, 600, 700 | Párrafos, navegación, botones, metadatos |

### Escala

- **H1:** `clamp(4rem, 8.6vw, 8.6rem)` · line-height `0.86` · uppercase.
- **H2 de sección:** `clamp(2.4rem, 4.4vw, 4rem)` · line-height `0.92`.
- **H2 destacado:** `clamp(2.2rem, 3.8vw, 3.6rem)` · line-height `0.94`.
- **H3 tarjeta:** `1.5rem` · line-height `1.02`.
- **Cuerpo:** `0.9–1.02rem` · line-height `1.7–1.8` · peso 300.
- **Micro/eyebrow:** `0.52–0.66rem` · tracking `0.16–0.24em` · uppercase.

### Reglas tipográficas

- **Una sola palabra en serif itálica por titular.** Es el gesto de marca.
  Ejemplo: `El <em>instante</em> que lo cambió todo.`
- Anton siempre en mayúsculas; la palabra en serif siempre en minúsculas.
- Nunca partir una palabra en serif en dos líneas.
- Los párrafos no se justifican ni se centran: ancho máximo 540 px.
- El tracking amplio es para etiquetas y navegación, nunca para párrafos.
- No usar más de dos familias visibles en una misma sección.

---

## 7. Layout y retícula

### Contenedores (unidades absolutas)

| Token | Ancho | Uso |
|---|---|---|
| `--w-narrow` | `1000px` | Bloques de lectura y formularios |
| `--w-base` | `1280px` | Contenedor por defecto |
| `--w-wide` | `1600px` | Secciones editoriales |
| `--w-hero` | `1760px` | Hero |
| Límite | `2000px` | Nunca superar |

Todos los contenedores usan `max-width: calc(100% - 80px)` para no tocar los
bordes en pantallas medianas. En móvil el margen baja a 40 px y luego a 32 px.

### Flexbox como pilar

- **Header:** `display:flex; justify-content:space-between`.
- **Hero:** dos columnas flex (54 % / 46 %).
- **Cifras:** cuatro items `flex:1 1 200px`.
- **Destacado + aside:** `flex` con aside `flex:0 0 300px` y `position:sticky`.
- **Archivo:** tarjetas con `flex-wrap` y `flex:1 1 calc(33.333% - 1.334rem)`.
- **Timeline, principios y footer:** flex wrap.
- No se usa CSS Grid en la primera capa: la consigna del proyecto es flexbox.

### Unidades

- **Diseño general:** px (anchos, alturas, paddings, gaps, bordes, sombras).
- **Elementos específicos:** rem/em (tipografía, iconos), % (columnas flex),
  `vh/dvh` (menú móvil) y `aspect-ratio` (medios).

### Ritmo vertical

Escala de espacio: `8 · 12 · 16 · 20 · 24 · 32 · 40 · 56 · 80 · 104` px.
Secciones: `104px` de padding vertical (`68px` en móvil).

### Breakpoints

| Ancho | Cambio |
|---|---|
| `1360px` | Márgenes de 64 px, sidebar a 280 px |
| `1180px` | Sidebar pasa debajo del destacado |
| `1120px` | Menú móvil (hamburguesa CSS) |
| `960px` | Hero a una columna, tarjetas a 2, timeline a 3 |
| `760px` | Destacado a una columna, tarjetas a 1, footer 2 columnas |
| `520px` | Ajustes finos de tipografía y espacios |

---

## 8. Componentes

### 8.1 Header y menú

- Sticky, 84 px de alto, fondo `rgba(8,8,10,.86)` con `backdrop-filter: blur(20px)`.
- Logo: cuadrado papel con «K» y un punto rojo desplazado 5 px arriba-derecha.
- Navegación en mayúsculas, 0.66 rem, tracking 0.16 em.
- **Dropdown CSS puro** inspirado en *css3-menu-generator*: se abre con `:hover`
  y `:focus-within`, panel de 340 px, borde superior rojo de 2 px, sombra profunda.
- En móvil: checkbox oculto + label hamburguesa. El panel ocupa
  `calc(100dvh - 84px)`, bloquea el scroll del body con `:has()` y muestra los
  submenús como listas estáticas.
- El enlace activo se marca con una línea roja que crece desde la izquierda.

### 8.2 Hero

- Fondo negro con halo bermellón al 12 % en la esquina superior derecha.
- Titular gigante a 3–4 líneas; palabra en serif itálica roja.
- Dos láminas superpuestas con marcos de papel, rotadas −7° y +4°.
- Sello circular rojo «KOMA / 週刊 · 2026» con flotación suave.
- Kanji vertical «漫画» al 6 % de opacidad como marca de agua.
- Datos rápidos separados por una regla de 1 px.

### 8.3 Cinta tipográfica

- Banda de papel entre dos reglas negras.
- Nombres de obras en Anton 1.2 rem, separados por estrellas rojas.
- Marquesina infinita de 42 s; se pausa al hover.
- El contenido se duplica para que el bucle sea continuo (`translateX(-50%)`).

### 8.4 Cifras

- Cuatro columnas separadas por reglas verticales.
- Número en Anton 2.9 rem + superíndice rojo (`+`, `K`).
- Etiqueta en micro-mayúsculas gris.

### 8.5 Panel de la semana

- Sección **papel** que rompe el ritmo oscuro; texto en tinta.
- Imagen con marco negro de 8 px y sombra dura roja de 16 px.
- Badge negro «01» en la esquina superior izquierda.
- Ficha técnica en `<dl>` a dos columnas con reglas de 1 px.
- Cita en serif itálica con barra roja a la izquierda.

### 8.6 Aside

- 300 px, sticky a 32 px del header.
- Bloques con borde de 1 px, fondo apenas tintado.
- Top 5 con numerales Anton rojos; glosario en `<dl>`; nota con enlace subrayado.
- En móvil, los bloques pasan a fila y luego a columna.

### 8.7 Archivo y tarjetas

- Filtros CSS puros: `input[type=radio]` + `label` + `:has()`; sin JavaScript.
- Contador dinámico con spans que se muestran/ocultan según el filtro.
- Tarjeta: imagen 4:5, etiqueta de género en papel, overlay al hover, flecha roja.
- Título Anton 1.5 rem; extracto 0.83 rem; pie con obra, año y minutos.
- Hover: zoom de imagen al 104.5 %, título en rojo, flecha que sube.

### 8.8 Timeline

- Seis hitos en fila, cada uno con regla superior y punto rojo de 7 px.
- Año en Anton 2 rem; texto 0.76 rem.
- En móvil: 3 → 2 → 1 columnas.

### 8.9 Principios

- Tres tarjetas con numeral Anton hueco (`-webkit-text-stroke`).
- Línea roja superior que se dibuja al hover; elevación de 4 px.

### 8.10 Newsletter

- Banda roja completa con trama de puntos negra al 22 %.
- Titular Anton + palabra en serif itálica.
- Input negro, botón papel; nota con candado.
- Es la única sección con fondo rojo saturado: debe sentirse como un sello.

### 8.11 Footer

- Cuatro columnas: marca, explorar, recursos, redes.
- Iconos de redes en cajas de 40 px con hover rojo y elevación.
- Wordmark «KOMA» gigante en outline (`text-stroke`) al 16 % de opacidad.
- Barra inferior con copyright, crédito y enlaces legales.

### 8.12 Elemento fijo

- Botón «TOP» de 54 px, `position: fixed; right: 24px; bottom: 24px`.
- Fondo rojo, borde interior negro, icono `fa-arrow-up` + etiqueta.
- Es el único elemento fijo de la página; no añadir chats o burbujas extra.

---

## 9. Imagen e ilustración

- Las imágenes son **paneles e ilustraciones reales** de las obras citadas,
  aportadas en `imagenes/` y optimizadas en `assets/img/panels/`.
- Se usan con fines educativos y sin ánimo de lucro. Toda ficha cita obra y autor;
  antes de publicar, sustituir por material licenciado o pedir permiso.
- Lenguaje visual: imagen protagonista, marco de papel de 10 px, pie de figura y
  un único acento bermellón. No aplicar filtros que alteren el original.
- En tarjetas se recortan a 4:5 con `object-fit: cover`; el hero y el destacado
  conservan la proporción de origen. Evitar fuentes de menos de 400 px.
- **Toda imagen lleva `alt` descriptivo** (personaje + obra + gesto), `width` y
  `height` para evitar saltos de layout. Las decorativas van con `aria-hidden`.
- Evitar: fotos de stock genéricas, imágenes sin crédito, capturas de baja
  resolución, marcos redondeados o sombras difusas grandes.

### Alternativa: prompt para una lámina original

Solo si se decide sustituir una imagen real por arte propio, mantener este lenguaje:

```
Lámina de manga en blanco y negro con un único acento bermellón (#FF4A2F),
composición vertical 3:4, silueta plana, trama de puntos (screentone),
líneas de velocidad, marco negro de 10 px y pie de figura.
Escena: [DESCRIPCIÓN]. Estilo: tinta editorial, alto contraste, sin texto
legible, sin degradados suaves, sin 3D.
```

---

## 10. Iconografía

- **Font Awesome 6.5.2** vía CDN (cdnjs).
- Tamaños: 0.48–0.9 rem dentro de texto; 0.85 rem en botones circulares.
- Iconos de interfaz: chevron, flecha, lupa, candado, info, fuego, libro, código.
- Iconos de marca: X, Instagram, YouTube, Pinterest, Discord.
- Siempre `aria-hidden="true"` si el enlace ya tiene texto o `aria-label`.
- No mezclar con Material Symbols en la misma vista.

---

## 11. Movimiento

| Animación | Duración | Uso |
|---|---|---|
| `rise` | 0.85–1.1 s | Entrada del hero (opacidad + 26 px) |
| `marquee` | 42 s lineal | Cinta tipográfica |
| `float` | 6 s | Sello del hero (±10 px) |
| Hover | 0.2–0.4 s | Color, elevación, zoom, flechas |

- Curva estándar: `cubic-bezier(.2,.7,.2,1)`.
- Nada de parallax, autoplay de vídeo ni animaciones de scroll.
- Respetar `prefers-reduced-motion`: desactivar animaciones y scroll suave.

---

## 12. Accesibilidad

- Un solo `<h1>`; jerarquía de encabezados sin saltos.
- Skip link visible al foco.
- Foco visible rojo de 2 px con offset de 3 px.
- Contraste mínimo AA en texto; el rojo profundo se usa sobre papel.
- Menú operable con teclado (`:focus-within`) y cierre con Escape.
- Filtros con radios reales y labels asociados.
- Formulario con label oculto, `autocomplete` y `required`.
- Imágenes con alt; iconos decorativos ocultos.
- `lang="es"`, metas sociales y datos estructurados.

---

## 13. Voz y contenido

- Español neutro, frases cortas, sin hype.
- Hablar de **composición, pausa, tinta, ritmo, vacío**, no de «increíble» o
  «épico».
- Los títulos pueden ser poéticos; los extractos deben explicar *por qué*
  funciona la viñeta.
- Citar siempre obra y autor en la ficha; aclarar que la imagen se usa con fines
  educativos y pertenece a sus creadores.
- Microcopy: «Sin ruido. Sin spoilers.», «Curado a mano», «Hecho con tinta y flexbox».

---

## 14. Reglas para agentes IA

**Hacer**

- Reutilizar los tokens de `:root`; no inventar hex nuevos.
- Mantener la alternancia oscuro → papel → oscuro → rojo → oscuro.
- Usar flexbox para la primera capa y `gap` para el ritmo.
- Reservar el rojo para un CTA, un acento o un estado de foco por vista.
- Escribir titulares de 2–5 palabras y un extracto de 1–2 líneas.
- Añadir `alt`, `width`, `height`, `loading="lazy"` en imágenes nuevas.
- Probar a 1600, 1280, 960, 768 y 390 px.

**No hacer**

- No añadir sombras difusas, glassmorphism ni bordes redondeados > 2 px.
- No usar más de una palabra en serif por titular.
- No poner texto centrado en párrafos.
- No usar emojis como iconos.
- No introducir un segundo color de acento.
- No usar imágenes sin crédito ni fuera del ámbito educativo; respetar los
  derechos de autor y sustituirlas antes de un uso comercial.
- No añadir JavaScript para lo que CSS ya resuelve.

---

## 15. Prompt base para nuevas secciones

```
Actúa como director de arte de KOMA. Diseña una sección [NOMBRE] para
index.html usando css/style.css y los tokens existentes. Requisitos:
- Contenedor de 1280/1600 px y layout flexbox.
- Fondo [ink/paper/red] con reglas de 1 px.
- Titular Anton uppercase + una palabra en Instrument Serif itálica.
- Eyebrow en micro-mayúsculas rojas con línea de 26 px.
- Espaciado vertical de 104 px y gap de 32 px.
- Máximo un acento rojo; sin sombras difusas ni radios > 2 px.
- Accesibilidad: heading correcto, alt en imágenes, foco visible.
- Responsive a 960/760/520 px.
Entrega HTML semántico y CSS comentado, sin dependencias nuevas.
```

---

## 16. Checklist de aceptación

- [x] Un `index.html` y un `style.css` propios (+ reset propio).
- [x] Estructura semántica: header, nav, main, section, article, aside, footer.
- [x] Metas principales, Open Graph, Twitter Card y JSON-LD.
- [x] Contenedores de 1000–1760 px (límite 2000).
- [x] Flexbox como pilar del layout.
- [x] Variables globales en `:root`.
- [x] Google Fonts + Font Awesome por CDN.
- [x] Todas las imágenes con `alt`.
- [x] Menú desplegable CSS con hover, focus y versión móvil.
- [x] Filtros CSS con `:has()`.
- [x] Elemento fijo en la esquina inferior derecha.
- [x] Footer con iconos sociales.
- [x] Contenido propio y artículos repetidos.
- [x] `design.md` con la especificación estética.
- [x] Responsive y `prefers-reduced-motion`.

---

## 17. Archivos

```
index.html                  Documento principal
css/reset.css               Reset propio
css/style.css               Diseño y componentes
design.md                   Esta especificación
README.md                   Guía de uso y checklist
assets/img/panels/*.jpg     Imágenes reales optimizadas
assets/img/panel-01…08.svg  Láminas SVG originales (legado)
assets/img/og-cover.png     Imagen social 1200×630
assets/img/favicon.svg      Favicon
imagenes/                   Carpeta original aportada por el usuario
tools/generate-panels.ps1   Generador de láminas SVG
tools/og-cover.html         Fuente de la portada social
```

**Regla final:** si una decisión no puede explicarse con «tinta, papel, pausa»,
no pertenece a KOMA.
