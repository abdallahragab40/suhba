"""Writes the Android 12+ animated launch icon from the brand mark.

The mark is drawn in Flutter by `paintBrandMark`
(lib/core/design_system/widgets/brand_mark.dart). Android's splash screen
needs it as an animated vector drawable instead, so this script redraws the
same geometry as vector paths: the two arch strokes and the nuqta from the
same numbers, and the name from Amiri Bold's glyph outlines, shaped with
HarfBuzz and placed where Flutter's TextPainter puts them.

The animation (850 ms): the doorway rises from its feet, the nuqta settles
on the crown, then the name appears. It ends on the still mark, which the
app's own opening screen draws in the same place.

Run from the repository root, with fontTools and uharfbuzz installed:

    python3 -m venv /tmp/brand && /tmp/brand/bin/pip install fonttools uharfbuzz
    /tmp/brand/bin/python tool/brand/splash_vector.py

Commit the XML it writes. Rerun it whenever the mark changes.
"""

from pathlib import Path

import uharfbuzz as hb
from fontTools.pens.svgPathPen import SVGPathPen
from fontTools.pens.transformPen import TransformPen
from fontTools.ttLib import TTFont

FONT = Path("assets/fonts/amiri/Amiri-Bold.ttf")
OUT = Path("android/app/src/main/res/drawable/splash_icon_animated.xml")

# The name's layout, measured from Flutter's TextPainter (Amiri Bold, w700,
# height 1) as `paintBrandMark` sizes it: 57 units wide.
NAME_FONT_SIZE = 38.358006499874215
NAME_BOX_HEIGHT = 38.0
NAME_BASELINE = 24.166587829589844
NAME_WIDTH = 57.0
# paintBrandMark's own placement constants.
INK_CENTRE_SHIFT = 0.85
INK_FOOT = 0.87
REST = 79.0

# The adaptive icon's 108-unit canvas; the mark's 100-unit box is scaled to
# 0.53 of it, as BrandMarkLayout.adaptiveForeground does.
VIEWPORT = 108.0
EXTENT = VIEWPORT * 0.53
OFFSET = (VIEWPORT - EXTENT) / 2

GOLD = 0xDDB765  # Palette.goldOnInk
GOLD_DEEP = 0x4A3608  # Palette.goldDeep
WHITE = 0xFFFFFF
PAPER = 0xF8F4EB  # Palette.paper


def lerp(a: int, b: int, t: float) -> str:
    """Color.lerp for opaque colours, as #RRGGBB."""
    out = 0
    for shift in (16, 8, 0):
        ca, cb = (a >> shift) & 0xFF, (b >> shift) & 0xFF
        out |= round(ca + (cb - ca) * t) << shift
    return f"#FF{out:06X}"


def n(v: float) -> str:
    return f"{v:.3f}".rstrip("0").rstrip(".")


def stroke(side: int) -> str:
    """One half of the arch, as `paintBrandMark` draws it."""
    foot, spring, crown = 92.0, 48.0, 14.0
    half_width, broad, gap = 39.0, 6.4, 2.6
    inner = half_width - broad

    def x(v: float) -> str:
        return n(50 + side * v)

    return (
        f"M{x(half_width)},{n(foot)} "
        f"L{x(half_width)},{n(spring)} "
        f"C{x(half_width)},{n(spring - 20)} {x(half_width * 0.36)},{n(crown + 9.5)} "
        f"{x(gap)},{n(crown + 1.5)} "
        f"L{x(gap)},{n(crown + 5.2)} "
        f"C{x(inner * 0.36)},{n(crown + 13)} {x(inner)},{n(spring - 17)} "
        f"{x(inner)},{n(spring)} "
        f"L{x(inner)},{n(foot)} Z"
    )


def nuqta() -> tuple[str, float]:
    dot, dot_y = 5.6, 14.0 - 0.6
    path = (
        f"M50,{n(dot_y - dot)} L{n(50 + dot)},{n(dot_y)} "
        f"L50,{n(dot_y + dot)} L{n(50 - dot)},{n(dot_y)} Z"
    )
    return path, dot_y


def name_path() -> str:
    font = TTFont(FONT)
    upem = font["head"].unitsPerEm
    blob = hb.Blob.from_file_path(str(FONT))
    hb_font = hb.Font(hb.Face(blob))
    buf = hb.Buffer()
    buf.add_str("صحبة")
    buf.guess_segment_properties()
    hb.shape(hb_font, buf)

    scale = NAME_FONT_SIZE / upem
    advance = sum(p.x_advance for p in buf.glyph_positions) * scale
    assert abs(advance - NAME_WIDTH) < 0.05, f"name is {advance} wide"

    left = 50 - NAME_WIDTH / 2 + INK_CENTRE_SHIFT
    top = REST - NAME_BOX_HEIGHT * INK_FOOT
    baseline = top + NAME_BASELINE

    glyph_set = font.getGlyphSet()
    pen = SVGPathPen(glyph_set, ntos=n)
    x = 0.0
    for info, pos in zip(buf.glyph_infos, buf.glyph_positions):
        glyph = font.getGlyphName(info.codepoint)
        dx = left + (x + pos.x_offset) * scale
        dy = baseline - pos.y_offset * scale
        glyph_set[glyph].draw(TransformPen(pen, (scale, 0, 0, -scale, dx, dy)))
        x += pos.x_advance
    return pen.getCommands()


def main() -> None:
    arch = f"{stroke(-1)} {stroke(1)}"
    dot, dot_y = nuqta()
    name = name_path()
    gradient = (
        '<aapt:attr name="android:fillColor">\n'
        '                    <gradient android:type="linear"\n'
        '                        android:startX="50" android:startY="0"\n'
        '                        android:endX="50" android:endY="100">\n'
        f'                        <item android:offset="0" android:color="{lerp(GOLD, WHITE, 0.25)}" />\n'
        f'                        <item android:offset="0.5" android:color="{lerp(GOLD, GOLD, 0)}" />\n'
        f'                        <item android:offset="1" android:color="{lerp(GOLD, GOLD_DEEP, 0.22)}" />\n'
        "                    </gradient>\n"
        "                </aapt:attr>"
    )
    xml = f"""<?xml version="1.0" encoding="utf-8"?>
<!-- Generated by tool/brand/splash_vector.py from the brand mark; do not
     edit by hand. The Android 12+ launch icon: the doorway rises, the nuqta
     settles on the crown, then the name appears (850 ms). -->
<animated-vector xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:aapt="http://schemas.android.com/aapt">
    <aapt:attr name="android:drawable">
        <vector
            android:width="108dp"
            android:height="108dp"
            android:viewportWidth="{n(VIEWPORT)}"
            android:viewportHeight="{n(VIEWPORT)}">
            <group
                android:translateX="{n(OFFSET)}"
                android:translateY="{n(OFFSET)}"
                android:scaleX="{n(EXTENT / 100)}"
                android:scaleY="{n(EXTENT / 100)}">
                <group android:name="arch">
                    <clip-path
                        android:name="rise"
                        android:pathData="M0,100 L100,100 L100,100 L0,100 Z" />
                    <path android:pathData="{arch}">
                        {gradient}
                    </path>
                </group>
                <group
                    android:name="nuqta"
                    android:pivotX="50"
                    android:pivotY="{n(dot_y)}"
                    android:scaleX="0"
                    android:scaleY="0">
                    <path android:pathData="{dot}">
                        {gradient}
                    </path>
                </group>
                <path
                    android:name="name"
                    android:fillAlpha="0"
                    android:fillColor="{lerp(PAPER, PAPER, 0)}"
                    android:pathData="{name}" />
            </group>
        </vector>
    </aapt:attr>
    <target android:name="rise">
        <aapt:attr name="android:animation">
            <objectAnimator
                android:duration="550"
                android:interpolator="@android:interpolator/fast_out_slow_in"
                android:propertyName="pathData"
                android:valueFrom="M0,100 L100,100 L100,100 L0,100 Z"
                android:valueTo="M0,0 L100,0 L100,100 L0,100 Z"
                android:valueType="pathType" />
        </aapt:attr>
    </target>
    <target android:name="nuqta">
        <aapt:attr name="android:animation">
            <set>
                <objectAnimator
                    android:duration="300"
                    android:interpolator="@android:interpolator/overshoot"
                    android:propertyName="scaleX"
                    android:startOffset="420"
                    android:valueFrom="0"
                    android:valueTo="1" />
                <objectAnimator
                    android:duration="300"
                    android:interpolator="@android:interpolator/overshoot"
                    android:propertyName="scaleY"
                    android:startOffset="420"
                    android:valueFrom="0"
                    android:valueTo="1" />
            </set>
        </aapt:attr>
    </target>
    <target android:name="name">
        <aapt:attr name="android:animation">
            <objectAnimator
                android:duration="400"
                android:interpolator="@android:interpolator/fast_out_slow_in"
                android:propertyName="fillAlpha"
                android:startOffset="450"
                android:valueFrom="0"
                android:valueTo="1" />
        </aapt:attr>
    </target>
</animated-vector>
"""
    OUT.write_text(xml, encoding="utf-8")
    print(f"wrote {OUT} ({len(xml)} bytes)")


if __name__ == "__main__":
    main()
