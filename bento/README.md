# KOMA Bento

Segundo proyecto del repositorio: un tablero **Bento** construido con **CSS Grid
anidado**, variables, CSS nesting y modo claro/oscuro automático. Reutiliza los
paneles de `../assets/img/panels` copiados en `img/`.

---

## Cómo abrirlo

No hay build, npm ni frameworks.

```bash
# desde la raíz del repositorio
py -m http.server 8080
```

Y visita `http://localhost:8080/bento/`. También funciona abriendo
`bento/index.html` con doble clic (las tipografías se cargan por CDN, así que la
primera visita necesita conexión).

---

## Estructura

```
bento/
├── index.html          Documento único
├── css/
│   ├── variables.css   Design tokens (se importa con @import)
│   └── style.css       Layout, componentes, animaciones y responsive
└── img/               12 paneles reutilizados del proyecto principal
```

---

## Cómo responde al enunciado

| Requisito | Dónde se resuelve |
| --- | --- |
| Diseño tipo Bento con Grid anidado | `.boards` (primer nivel) y `.board__grid` (segundo nivel) |
| Tres columnas por encima de 700 px | `grid-template-columns: repeat(3, 1fr)` |
| Tres columnas apiladas por debajo de 700 px | `@media (max-width: 700px)` → `grid-template-columns: 1fr` |
| Celdas de una unidad | `.cell--small-a` y `.cell--small-b` |
| Celdas que ocupan toda la fila | `.cell--hero` y `.cell--quote` |
| Celdas que ocupan varias filas | `.cell--tall` (`grid_area: tall` en dos filas) |
| Variables en fichero aparte | `css/variables.css`, importado desde `style.css` |
| CSS anidado | Selectores con `&` en todo `style.css` |
| Modo claro y oscuro | `@media (prefers-color-scheme: dark)` redefine los tokens |
| Animación/transición al pasar el ratón | Elevación, zoom de imagen, brillo diagonal y flecha; `@keyframes rise` al entrar |

### Extras

- **Container queries** (`@container board (max-width: 280px)`) para que la
  tipografía y el contenido de las celdas se adapten al ancho real del tablero
  entre 700 px y ~950 px, donde tres columnas quedan muy estrechas.
- Unidades de contenedor (`cqi`), `clamp()`, `color-mix()` y `text-wrap: balance`.
- `prefers-reduced-motion` para desactivar el movimiento.
- En pantallas táctiles el texto oculto de las celdas se muestra siempre.
