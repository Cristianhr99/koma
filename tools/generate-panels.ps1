# ============================================================
#  KOMA - Generador de paneles SVG (homenajes originales)
#  Uso:  powershell -ExecutionPolicy Bypass -File tools/generate-panels.ps1
# ============================================================
$ErrorActionPreference = "Stop"

$root = Split-Path -Parent $PSScriptRoot
$outDir = Join-Path $root "assets\img"
New-Item -ItemType Directory -Force -Path $outDir | Out-Null

$enc = New-Object System.Text.UTF8Encoding($false)
function Save-Svg([string]$name, [string]$content) {
    [System.IO.File]::WriteAllText((Join-Path $outDir $name), $content, $enc)
    Write-Host "  + $name"
}

# ---------- helpers ----------
function New-Rays {
    param($cx, $cy, $count, $r1, $r2, $stroke, $opacity, $width)
    $parts = for ($i = 0; $i -lt $count; $i++) {
        $a = 2 * [math]::PI * $i / $count
        $x1 = [math]::Round($cx + $r1 * [math]::Cos($a), 1)
        $y1 = [math]::Round($cy + $r1 * [math]::Sin($a), 1)
        $x2 = [math]::Round($cx + $r2 * [math]::Cos($a), 1)
        $y2 = [math]::Round($cy + $r2 * [math]::Sin($a), 1)
        '<line x1="{0}" y1="{1}" x2="{2}" y2="{3}" stroke="{4}" stroke-width="{5}" opacity="{6}"/>' -f $x1, $y1, $x2, $y2, $stroke, $width, $opacity
    }
    return ($parts -join "`n  ")
}

function New-Rain {
    param($count, $stroke, $opacity)
    $parts = for ($i = 0; $i -lt $count; $i++) {
        $x = (($i * 149) % 1080) - 120
        $y = ($i * 233) % 1180
        $len = 50 + (($i * 37) % 110)
        '<line x1="{0}" y1="{1}" x2="{2}" y2="{3}" stroke="{4}" stroke-width="2.4" opacity="{5}"/>' -f $x, $y, ($x - 34), ($y + $len), $stroke, $opacity
    }
    return ($parts -join "`n  ")
}

function New-Star {
    param($cx, $cy, $r1, $r2, $points)
    $pts = for ($i = 0; $i -lt ($points * 2); $i++) {
        $a = [math]::PI * $i / $points - [math]::PI / 2
        $r = if ($i % 2 -eq 0) { $r1 } else { $r2 }
        '{0},{1}' -f [math]::Round($cx + $r * [math]::Cos($a), 1), [math]::Round($cy + $r * [math]::Sin($a), 1)
    }
    return ($pts -join " ")
}

function New-City {
    $buildings = @(
        @{ x = -20;  y = 800; w = 120; h = 400; cols = 3; rows = 7 },
        @{ x = 95;   y = 660; w = 105; h = 540; cols = 3; rows = 10 },
        @{ x = 190;  y = 760; w = 140; h = 440; cols = 4; rows = 8 },
        @{ x = 320;  y = 560; w = 95;  h = 640; cols = 2; rows = 12 },
        @{ x = 405;  y = 700; w = 130; h = 500; cols = 4; rows = 9 },
        @{ x = 525;  y = 610; w = 110; h = 590; cols = 3; rows = 11 },
        @{ x = 625;  y = 780; w = 150; h = 420; cols = 4; rows = 8 },
        @{ x = 760;  y = 650; w = 160; h = 550; cols = 4; rows = 10 }
    )
    $parts = New-Object System.Collections.Generic.List[string]
    foreach ($b in $buildings) {
        $parts.Add(('<rect x="{0}" y="{1}" width="{2}" height="{3}" fill="#0A0A0C"/>' -f $b.x, $b.y, $b.w, $b.h))
        for ($r = 0; $r -lt $b.rows; $r++) {
            for ($c = 0; $c -lt $b.cols; $c++) {
                $wx = $b.x + 18 + $c * (($b.w - 30) / $b.cols)
                $wy = $b.y + 26 + $r * (($b.h - 50) / $b.rows)
                if ((($r * 7 + $c * 3 + $b.x) % 5) -ne 0) {
                    $fill = if ((($r + $c) % 11) -eq 0) { "#FF4A2F" } else { "#F2ECE1" }
                    $parts.Add(('<rect x="{0}" y="{1}" width="9" height="13" fill="{2}" opacity="0.9"/>' -f [math]::Round($wx, 1), [math]::Round($wy, 1), $fill))
                }
            }
        }
    }
    return ($parts -join "`n  ")
}

Write-Host "Generando paneles KOMA..."

# ============================================================
#  PANEL 01 - EL GRITO
# ============================================================
$rays1 = New-Rays -cx 450 -cy 520 -count 72 -r1 300 -r2 1050 -stroke "#F2ECE1" -opacity 0.22 -width 3
$rays1b = New-Rays -cx 450 -cy 520 -count 24 -r1 320 -r2 780 -stroke "#FF4A2F" -opacity 0.5 -width 6
$p1 = @'
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 900 1200" width="900" height="1200" role="img" aria-labelledby="p1t p1d">
  <title id="p1t">El grito, recreacion de un panel de manga</title>
  <desc id="p1d">Rostro gritando en blanco sobre fondo negro, atravesado por lineas de velocidad y un acento rojo.</desc>
  <defs>
    <pattern id="p1ht" width="8" height="8" patternUnits="userSpaceOnUse" patternTransform="rotate(18)">
      <circle cx="2" cy="2" r="1.4" fill="#0A0A0C"/>
    </pattern>
  </defs>
  <rect width="900" height="1200" fill="#0A0A0C"/>
  {{RAYS}}
  {{RAYSB}}
  <circle cx="450" cy="520" r="300" fill="#FF4A2F"/>
  <circle cx="450" cy="520" r="300" fill="url(#p1ht)" opacity="0.18"/>
  <path d="M285 780 C265 620 300 430 450 405 C600 430 635 620 615 780 C560 820 340 820 285 780 Z" fill="#F2ECE1"/>
  <path d="M300 590 L225 500 L305 520 L285 420 L365 485 L355 390 L425 465 L440 365 L500 450 L535 380 L560 470 L625 415 L610 505 L680 490 L625 590 Z" fill="#0A0A0C"/>
  <path d="M330 620 L415 600 L405 645 Z" fill="#0A0A0C"/>
  <path d="M570 620 L485 600 L495 645 Z" fill="#0A0A0C"/>
  <ellipse cx="450" cy="735" rx="112" ry="82" fill="#0A0A0C"/>
  <path d="M405 715 Q450 775 495 715 Q485 800 450 805 Q415 800 405 715 Z" fill="#FF4A2F"/>
  <path d="M330 660 L300 700 M570 660 L600 700" stroke="#0A0A0C" stroke-width="5"/>
  <g transform="rotate(-7 705 210)">
    <rect x="575" y="125" width="250" height="128" fill="#F2ECE1" stroke="#0A0A0C" stroke-width="6"/>
    <text x="700" y="192" text-anchor="middle" font-family="Arial Black, Arial, sans-serif" font-size="54" fill="#0A0A0C">!</text>
    <text x="700" y="228" text-anchor="middle" font-family="Arial, sans-serif" font-size="13" letter-spacing="4" fill="#0A0A0C">KOMA 001</text>
  </g>
  <rect x="40" y="1030" width="820" height="110" fill="#0A0A0C" stroke="#F2ECE1" stroke-width="4"/>
  <text x="72" y="1078" font-family="Arial Black, Arial, sans-serif" font-size="26" letter-spacing="3" fill="#F2ECE1">EL GRITO</text>
  <text x="72" y="1112" font-family="Arial, sans-serif" font-size="14" letter-spacing="4" fill="#FF4A2F">ARCHIVO KOMA / 1968</text>
  <text x="826" y="1110" text-anchor="end" font-family="Arial, sans-serif" font-size="48" fill="#F2ECE1">叫</text>
  <rect x="0" y="0" width="900" height="1200" fill="none" stroke="#F2ECE1" stroke-width="10"/>
</svg>
'@
$p1 = $p1.Replace('{{RAYS}}', $rays1).Replace('{{RAYSB}}', $rays1b)
Save-Svg "panel-01.svg" $p1

# ============================================================
#  PANEL 02 - LA LLUVIA
# ============================================================
$rain2 = New-Rain -count 90 -stroke "#0A0A0C" -opacity 0.45
$p2 = @'
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 900 1200" width="900" height="1200" role="img" aria-labelledby="p2t p2d">
  <title id="p2t">La lluvia, recreacion de un panel de manga</title>
  <desc id="p2d">Una figura solitaria con paraguas bajo una lluvia diagonal, frente a un sol rojo y un cielo tramado.</desc>
  <defs>
    <pattern id="p2ht" width="9" height="9" patternUnits="userSpaceOnUse" patternTransform="rotate(12)">
      <circle cx="2" cy="2" r="1.5" fill="#0A0A0C"/>
    </pattern>
    <pattern id="p2htw" width="10" height="10" patternUnits="userSpaceOnUse" patternTransform="rotate(-14)">
      <circle cx="2" cy="2" r="1.3" fill="#F2ECE1"/>
    </pattern>
  </defs>
  <rect width="900" height="1200" fill="#F2ECE1"/>
  <rect width="900" height="640" fill="url(#p2ht)" opacity="0.32"/>
  <circle cx="690" cy="235" r="145" fill="#FF4A2F"/>
  <circle cx="690" cy="235" r="145" fill="url(#p2htw)" opacity="0.16"/>
  <g fill="#F2ECE1" stroke="#0A0A0C" stroke-width="5">
    <ellipse cx="205" cy="150" rx="175" ry="54"/>
    <ellipse cx="335" cy="118" rx="120" ry="46"/>
    <ellipse cx="115" cy="215" rx="120" ry="40"/>
  </g>
  {{RAIN}}
  <rect y="980" width="900" height="220" fill="#0A0A0C"/>
  <g>
    <path d="M340 980 L340 730" stroke="#0A0A0C" stroke-width="16"/>
    <path d="M190 730 Q340 555 490 730 Z" fill="#0A0A0C"/>
    <path d="M340 730 Q340 690 340 640" stroke="#0A0A0C" stroke-width="10"/>
    <path d="M340 700 Q300 692 288 660" stroke="#0A0A0C" stroke-width="8" fill="none"/>
    <circle cx="340" cy="800" r="38" fill="#0A0A0C"/>
    <path d="M300 980 L300 830 Q340 790 380 830 L380 980 Z" fill="#0A0A0C"/>
    <path d="M305 980 L295 1080 L325 1080 L332 980 Z" fill="#0A0A0C"/>
    <path d="M345 980 L375 1075 L405 1065 L368 980 Z" fill="#0A0A0C"/>
  </g>
  <ellipse cx="330" cy="1092" rx="160" ry="14" fill="#F2ECE1" opacity="0.16"/>
  <g transform="rotate(4 700 610)">
    <rect x="600" y="558" width="220" height="100" fill="#F2ECE1" stroke="#0A0A0C" stroke-width="5"/>
    <text x="710" y="622" text-anchor="middle" font-family="Arial, sans-serif" font-size="34" fill="#0A0A0C">. . .</text>
  </g>
  <text x="838" y="930" text-anchor="middle" font-family="Arial, sans-serif" font-size="58" fill="#0A0A0C">雨</text>
  <rect x="0" y="0" width="900" height="1200" fill="none" stroke="#0A0A0C" stroke-width="10"/>
</svg>
'@
$p2 = $p2.Replace('{{RAIN}}', $rain2)
Save-Svg "panel-02.svg" $p2

# ============================================================
#  PANEL 03 - EL OJO
# ============================================================
$rays3 = New-Rays -cx 450 -cy 600 -count 40 -r1 380 -r2 720 -stroke "#F2ECE1" -opacity 0.12 -width 2
$p3 = @'
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 900 1200" width="900" height="1200" role="img" aria-labelledby="p3t p3d">
  <title id="p3t">El ojo, recreacion de un panel de manga</title>
  <desc id="p3d">Primer plano extremo de un ojo con iris rojo tramado sobre fondo negro y una lagrima roja.</desc>
  <defs>
    <pattern id="p3ht" width="7" height="7" patternUnits="userSpaceOnUse" patternTransform="rotate(22)">
      <circle cx="2" cy="2" r="1.3" fill="#0A0A0C"/>
    </pattern>
    <pattern id="p3htw" width="9" height="9" patternUnits="userSpaceOnUse" patternTransform="rotate(-10)">
      <circle cx="2" cy="2" r="1.2" fill="#F2ECE1"/>
    </pattern>
  </defs>
  <rect width="900" height="1200" fill="#0A0A0C"/>
  {{RAYS}}
  <path d="M40 600 Q450 190 860 600 Q450 1010 40 600 Z" fill="#F2ECE1"/>
  <path d="M40 600 Q450 190 860 600" fill="none" stroke="#0A0A0C" stroke-width="34" stroke-linecap="round"/>
  <path d="M40 600 Q450 1010 860 600" fill="none" stroke="#0A0A0C" stroke-width="14" stroke-linecap="round" opacity="0.75"/>
  <g stroke="#0A0A0C" stroke-width="11" stroke-linecap="round">
    <line x1="150" y1="470" x2="105" y2="395"/>
    <line x1="245" y1="390" x2="215" y2="305"/>
    <line x1="355" y1="330" x2="340" y2="240"/>
    <line x1="475" y1="300" x2="478" y2="208"/>
    <line x1="595" y1="320" x2="615" y2="230"/>
    <line x1="705" y1="380" x2="740" y2="300"/>
    <line x1="790" y1="465" x2="840" y2="400"/>
  </g>
  <circle cx="470" cy="600" r="225" fill="#FF4A2F"/>
  <circle cx="470" cy="600" r="225" fill="url(#p3ht)" opacity="0.3"/>
  <circle cx="470" cy="600" r="110" fill="#0A0A0C"/>
  <circle cx="415" cy="530" r="46" fill="#F2ECE1"/>
  <circle cx="545" cy="670" r="22" fill="#F2ECE1" opacity="0.85"/>
  <path d="M330 800 Q350 900 318 990" stroke="#FF4A2F" stroke-width="14" fill="none" stroke-linecap="round"/>
  <path d="M560 830 Q585 900 570 960" stroke="#0A0A0C" stroke-width="7" fill="none" opacity="0.35"/>
  <rect x="0" y="0" width="900" height="1200" fill="none" stroke="#F2ECE1" stroke-width="10"/>
  <text x="70" y="1120" font-family="Arial Black, Arial, sans-serif" font-size="22" letter-spacing="4" fill="#F2ECE1">EL OJO / 001</text>
</svg>
'@
$p3 = $p3.Replace('{{RAYS}}', $rays3)
Save-Svg "panel-03.svg" $p3

# ============================================================
#  PANEL 04 - EL CHOQUE
# ============================================================
$rays4 = New-Rays -cx 450 -cy 620 -count 56 -r1 160 -r2 950 -stroke "#F2ECE1" -opacity 0.16 -width 3
$star4 = New-Star -cx 450 -cy 620 -r1 250 -r2 90 -points 12
$p4 = @'
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 900 1200" width="900" height="1200" role="img" aria-labelledby="p4t p4d">
  <title id="p4t">El choque, recreacion de un panel de manga</title>
  <desc id="p4d">Dos espadas cruzan sus hojas en el centro de una explosion de lineas de impacto y chispas.</desc>
  <rect width="900" height="1200" fill="#0A0A0C"/>
  {{RAYS}}
  <polygon points="{{STAR}}" fill="#FF4A2F"/>
  <polygon points="{{STAR2}}" fill="#F2ECE1" opacity="0.22"/>
  <g transform="rotate(38 450 620)">
    <rect x="424" y="110" width="52" height="480" fill="#F2ECE1" stroke="#0A0A0C" stroke-width="4"/>
    <rect x="424" y="560" width="52" height="30" fill="#FF4A2F"/>
    <rect x="378" y="590" width="144" height="20" fill="#0A0A0C" stroke="#F2ECE1" stroke-width="3"/>
    <rect x="408" y="610" width="84" height="170" fill="#F2ECE1" stroke="#0A0A0C" stroke-width="4"/>
    <path d="M408 650 H492 M408 690 H492 M408 730 H492" stroke="#0A0A0C" stroke-width="5"/>
  </g>
  <g transform="rotate(-38 450 620)">
    <rect x="424" y="110" width="52" height="480" fill="#F2ECE1" stroke="#0A0A0C" stroke-width="4"/>
    <rect x="424" y="560" width="52" height="30" fill="#FF4A2F"/>
    <rect x="378" y="590" width="144" height="20" fill="#0A0A0C" stroke="#F2ECE1" stroke-width="3"/>
    <rect x="408" y="610" width="84" height="170" fill="#F2ECE1" stroke="#0A0A0C" stroke-width="4"/>
    <path d="M408 650 H492 M408 690 H492 M408 730 H492" stroke="#0A0A0C" stroke-width="5"/>
  </g>
  <circle cx="450" cy="620" r="46" fill="#FF4A2F"/>
  <circle cx="450" cy="620" r="16" fill="#F2ECE1"/>
  <g fill="#FF4A2F">
    <circle cx="250" cy="420" r="7"/><circle cx="650" cy="410" r="9"/><circle cx="690" cy="790" r="6"/>
    <circle cx="205" cy="780" r="8"/><circle cx="600" cy="260" r="5"/><circle cx="310" cy="900" r="6"/>
  </g>
  <rect x="40" y="1040" width="820" height="100" fill="#0A0A0C" stroke="#F2ECE1" stroke-width="4"/>
  <text x="70" y="1085" font-family="Arial Black, Arial, sans-serif" font-size="25" letter-spacing="3" fill="#F2ECE1">EL CHOQUE</text>
  <text x="70" y="1117" font-family="Arial, sans-serif" font-size="14" letter-spacing="4" fill="#FF4A2F">ARCHIVO KOMA / 002</text>
  <text x="830" y="1108" text-anchor="end" font-family="Arial, sans-serif" font-size="44" fill="#F2ECE1">斬</text>
  <rect x="0" y="0" width="900" height="1200" fill="none" stroke="#F2ECE1" stroke-width="10"/>
</svg>
'@
$p4 = $p4.Replace('{{RAYS}}', $rays4).Replace('{{STAR}}', $star4).Replace('{{STAR2}}', (New-Star -cx 450 -cy 620 -r1 330 -r2 120 -points 12))
Save-Svg "panel-04.svg" $p4

# ============================================================
#  PANEL 05 - LA CIUDAD
# ============================================================
$city5 = New-City
$p5 = @'
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 900 1200" width="900" height="1200" role="img" aria-labelledby="p5t p5d">
  <title id="p5t">La ciudad, recreacion de un panel de manga</title>
  <desc id="p5d">Skyline nocturno de una metropolis con ventanas encendidas, un sol rojo y aves cruzando el cielo tramado.</desc>
  <defs>
    <pattern id="p5ht" width="8" height="8" patternUnits="userSpaceOnUse" patternTransform="rotate(16)">
      <circle cx="2" cy="2" r="1.4" fill="#0A0A0C"/>
    </pattern>
  </defs>
  <rect width="900" height="1200" fill="#F2ECE1"/>
  <rect width="900" height="700" fill="url(#p5ht)" opacity="0.28"/>
  <circle cx="650" cy="300" r="170" fill="#FF4A2F"/>
  <circle cx="650" cy="300" r="170" fill="url(#p5ht)" opacity="0.15"/>
  <g stroke="#0A0A0C" stroke-width="4" fill="none" stroke-linecap="round">
    <path d="M180 260 q14 -14 28 0 q14 -14 28 0"/>
    <path d="M240 330 q10 -10 20 0 q10 -10 20 0"/>
    <path d="M120 380 q8 -8 16 0 q8 -8 16 0"/>
  </g>
  {{CITY}}
  <rect y="1100" width="900" height="100" fill="#0A0A0C"/>
  <g stroke="#FF4A2F" stroke-width="4" opacity="0.55">
    <line x1="120" y1="1128" x2="260" y2="1128"/>
    <line x1="420" y1="1150" x2="560" y2="1150"/>
    <line x1="660" y1="1122" x2="800" y2="1122"/>
  </g>
  <rect x="0" y="0" width="900" height="1200" fill="none" stroke="#0A0A0C" stroke-width="10"/>
  <rect x="60" y="80" width="290" height="64" fill="#0A0A0C"/>
  <text x="82" y="122" font-family="Arial Black, Arial, sans-serif" font-size="24" letter-spacing="4" fill="#F2ECE1">NEON CITY</text>
</svg>
'@
$p5 = $p5.Replace('{{CITY}}', $city5)
Save-Svg "panel-05.svg" $p5

# ============================================================
#  PANEL 06 - EL SALTO
# ============================================================
$speed6 = for ($i = 0; $i -lt 14; $i++) {
    $x = 40 + $i * 22
    '<line x1="{0}" y1="120" x2="{1}" y2="760" stroke="#0A0A0C" stroke-width="3" opacity="0.35"/>' -f $x, ($x - 130)
}
$p6 = @'
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 900 1200" width="900" height="1200" role="img" aria-labelledby="p6t p6d">
  <title id="p6t">El salto, recreacion de un panel de manga</title>
  <desc id="p6d">Un jugador de baloncesto en el aire, a punto de machacar el aro, con lineas de movimiento y una trama de puntos.</desc>
  <defs>
    <pattern id="p6ht" width="9" height="9" patternUnits="userSpaceOnUse" patternTransform="rotate(20)">
      <circle cx="2" cy="2" r="1.5" fill="#0A0A0C"/>
    </pattern>
  </defs>
  <rect width="900" height="1200" fill="#F2ECE1"/>
  <circle cx="215" cy="300" r="270" fill="url(#p6ht)" opacity="0.35"/>
  {{SPEED}}
  <g>
    <rect x="672" y="150" width="190" height="128" fill="#F2ECE1" stroke="#0A0A0C" stroke-width="8"/>
    <rect x="712" y="192" width="110" height="56" fill="none" stroke="#0A0A0C" stroke-width="5"/>
    <line x1="700" y1="300" x2="850" y2="300" stroke="#FF4A2F" stroke-width="12" stroke-linecap="round"/>
    <path d="M710 302 L700 400 M750 302 L745 405 M795 302 L800 405 M840 302 L850 400" stroke="#0A0A0C" stroke-width="4"/>
    <path d="M700 400 L745 405 L800 405 L850 400 M720 350 L745 405 M780 350 L800 405" stroke="#0A0A0C" stroke-width="4" fill="none"/>
  </g>
  <g stroke="#0A0A0C" stroke-width="38" stroke-linecap="round" fill="none">
    <path d="M420 560 L420 720"/>
    <path d="M420 590 L330 500"/>
    <path d="M420 590 L525 455"/>
    <path d="M420 720 L350 840 L378 950"/>
    <path d="M420 720 L505 820 L545 930"/>
  </g>
  <circle cx="420" cy="500" r="44" fill="#0A0A0C"/>
  <path d="M386 552 L454 552 L470 700 L370 700 Z" fill="#0A0A0C"/>
  <text x="420" y="650" text-anchor="middle" font-family="Arial Black, Arial, sans-serif" font-size="40" fill="#F2ECE1">10</text>
  <circle cx="570" cy="405" r="52" fill="#FF4A2F" stroke="#0A0A0C" stroke-width="6"/>
  <path d="M520 405 H620 M570 355 V455 M535 370 Q570 405 605 440 M605 370 Q570 405 535 440" stroke="#0A0A0C" stroke-width="5" fill="none"/>
  <rect x="40" y="1030" width="820" height="110" fill="#0A0A0C"/>
  <text x="72" y="1078" font-family="Arial Black, Arial, sans-serif" font-size="26" letter-spacing="3" fill="#F2ECE1">DIEZ SEGUNDOS</text>
  <text x="72" y="1112" font-family="Arial, sans-serif" font-size="14" letter-spacing="4" fill="#FF4A2F">ARCHIVO KOMA / 003</text>
  <text x="826" y="1105" text-anchor="end" font-family="Arial, sans-serif" font-size="46" fill="#F2ECE1">跳</text>
  <rect x="0" y="0" width="900" height="1200" fill="none" stroke="#0A0A0C" stroke-width="10"/>
</svg>
'@
$p6 = $p6.Replace('{{SPEED}}', ($speed6 -join "`n  "))
Save-Svg "panel-06.svg" $p6

# ============================================================
#  PANEL 07 - EL TAZON
# ============================================================
$p7 = @'
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 900 1200" width="900" height="1200" role="img" aria-labelledby="p7t p7d">
  <title id="p7t">El tazon, recreacion de un panel de manga</title>
  <desc id="p7d">Un tazon humeante de ramen visto desde arriba, con huevo, alga nori y palillos, sobre fondo de papel.</desc>
  <defs>
    <pattern id="p7ht" width="10" height="10" patternUnits="userSpaceOnUse" patternTransform="rotate(24)">
      <circle cx="2" cy="2" r="1.6" fill="#0A0A0C"/>
    </pattern>
    <pattern id="p7htw" width="9" height="9" patternUnits="userSpaceOnUse" patternTransform="rotate(-18)">
      <circle cx="2" cy="2" r="1.3" fill="#F2ECE1"/>
    </pattern>
  </defs>
  <rect width="900" height="1200" fill="#F2ECE1"/>
  <circle cx="450" cy="620" r="400" fill="url(#p7ht)" opacity="0.22"/>
  <g stroke="#0A0A0C" stroke-width="7" fill="none" stroke-linecap="round" opacity="0.7">
    <path d="M300 300 q-30 -50 0 -95 q30 -45 0 -90"/>
    <path d="M450 270 q-30 -50 0 -95 q30 -45 0 -90"/>
    <path d="M600 300 q-30 -50 0 -95 q30 -45 0 -90"/>
  </g>
  <path d="M170 620 Q450 1030 730 620 Z" fill="#0A0A0C"/>
  <ellipse cx="450" cy="620" rx="280" ry="66" fill="#F2ECE1" stroke="#0A0A0C" stroke-width="10"/>
  <ellipse cx="450" cy="622" rx="248" ry="48" fill="#F2ECE1" stroke="#0A0A0C" stroke-width="4"/>
  <g stroke="#0A0A0C" stroke-width="7" fill="none" stroke-linecap="round">
    <path d="M250 620 q40 -30 80 0 q40 30 80 0 q40 -30 80 0 q40 30 80 0 q40 -30 80 0"/>
    <path d="M280 645 q40 -26 80 0 q40 26 80 0 q40 -26 80 0 q40 26 80 0"/>
    <path d="M320 600 q40 -24 80 0 q40 24 80 0 q40 -24 80 0"/>
  </g>
  <circle cx="355" cy="612" r="58" fill="#F2ECE1" stroke="#0A0A0C" stroke-width="5"/>
  <circle cx="355" cy="612" r="26" fill="#FF4A2F"/>
  <rect x="500" y="560" width="78" height="96" rx="3" fill="#0A0A0C" transform="rotate(12 539 608)"/>
  <path d="M515 585 H565 M515 605 H565 M515 625 H565" stroke="#F2ECE1" stroke-width="3" opacity="0.5" transform="rotate(12 539 608)"/>
  <g transform="rotate(-18 450 520)">
    <rect x="180" y="500" width="470" height="14" fill="#0A0A0C"/>
    <rect x="180" y="530" width="470" height="14" fill="#0A0A0C"/>
    <rect x="640" y="494" width="120" height="26" fill="#FF4A2F"/>
    <rect x="640" y="524" width="120" height="26" fill="#FF4A2F"/>
  </g>
  <circle cx="730" cy="240" r="90" fill="#FF4A2F"/>
  <circle cx="730" cy="240" r="90" fill="url(#p7htw)" opacity="0.15"/>
  <text x="730" y="262" text-anchor="middle" font-family="Arial, sans-serif" font-size="58" fill="#F2ECE1">麺</text>
  <rect x="40" y="1030" width="820" height="110" fill="#0A0A0C"/>
  <text x="72" y="1078" font-family="Arial Black, Arial, sans-serif" font-size="26" letter-spacing="3" fill="#F2ECE1">UN TAZON ANTES DEL FINAL</text>
  <text x="72" y="1112" font-family="Arial, sans-serif" font-size="14" letter-spacing="4" fill="#FF4A2F">ARCHIVO KOMA / 004</text>
  <rect x="0" y="0" width="900" height="1200" fill="none" stroke="#0A0A0C" stroke-width="10"/>
</svg>
'@
Save-Svg "panel-07.svg" $p7

# ============================================================
#  PANEL 08 - EL VACIO
# ============================================================
$p8 = @'
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 900 1200" width="900" height="1200" role="img" aria-labelledby="p8t p8d">
  <title id="p8t">La figura en el vacio, recreacion de un panel de manga</title>
  <desc id="p8d">Una figura diminuta frente a un horizonte infinito bajo una luna enorme y un cielo negro.</desc>
  <defs>
    <pattern id="p8ht" width="8" height="8" patternUnits="userSpaceOnUse" patternTransform="rotate(14)">
      <circle cx="2" cy="2" r="1.4" fill="#0A0A0C"/>
    </pattern>
  </defs>
  <rect width="900" height="1200" fill="#0A0A0C"/>
  <circle cx="450" cy="430" r="315" fill="#F2ECE1"/>
  <circle cx="450" cy="430" r="315" fill="url(#p8ht)" opacity="0.16"/>
  <g fill="#F2ECE1">
    <circle cx="120" cy="160" r="3"/><circle cx="210" cy="90" r="2"/><circle cx="760" cy="130" r="3"/>
    <circle cx="820" cy="300" r="2"/><circle cx="90" cy="380" r="2"/><circle cx="690" cy="760" r="2"/>
    <circle cx="150" cy="700" r="2.5"/><circle cx="300" cy="220" r="1.8"/><circle cx="810" cy="600" r="2"/>
  </g>
  <circle cx="720" cy="210" r="14" fill="#FF4A2F"/>
  <line x1="0" y1="880" x2="900" y2="880" stroke="#F2ECE1" stroke-width="6"/>
  <g fill="#0A0A0C">
    <circle cx="450" cy="852" r="9"/>
    <path d="M444 862 L456 862 L460 900 L440 900 Z"/>
    <path d="M444 900 L440 930 L448 930 L450 902 L452 930 L460 930 L456 900 Z"/>
    <path d="M444 870 L432 890 M456 870 L468 890" stroke="#0A0A0C" stroke-width="4"/>
  </g>
  <line x1="450" y1="930" x2="450" y2="1050" stroke="#0A0A0C" stroke-width="3" opacity="0.3"/>
  <text x="450" y="1120" text-anchor="middle" font-family="Arial, sans-serif" font-size="15" letter-spacing="8" fill="#F2ECE1">ARCHIVO KOMA / 005</text>
  <rect x="0" y="0" width="900" height="1200" fill="none" stroke="#F2ECE1" stroke-width="10"/>
</svg>
'@
Save-Svg "panel-08.svg" $p8

# ============================================================
#  FAVICON
# ============================================================
$favicon = @'
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 64 64" width="64" height="64" role="img" aria-labelledby="ft">
  <title id="ft">KOMA</title>
  <rect width="64" height="64" fill="#0A0A0C"/>
  <text x="32" y="46" text-anchor="middle" font-family="Arial Black, Arial, sans-serif" font-size="38" fill="#F2ECE1">K</text>
  <rect x="48" y="10" width="10" height="10" fill="#FF4A2F"/>
</svg>
'@
Save-Svg "favicon.svg" $favicon

Write-Host "Listo. Paneles en $outDir"
