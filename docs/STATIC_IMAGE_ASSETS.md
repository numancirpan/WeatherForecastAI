# Static Weather Image Assets

For the free first version, the app uses local PNG files before trying any backend image generation. Add generated images to:

```text
assets/images/
```

## Naming

Use this format:

```text
{city}_{condition}.png
```

Supported city slugs:

- `kocaeli`
- `istanbul`
- `ankara`
- `izmir`
- `bursa`

Supported condition slugs:

- `clear`
- `clouds`
- `rain`
- `snow`
- `fog`

Examples:

```text
assets/images/kocaeli_clouds.png
assets/images/istanbul_clear.png
assets/images/ankara_rain.png
```

## First Asset Set

Start with these 15 images:

```text
kocaeli_clear.png
kocaeli_clouds.png
kocaeli_rain.png
istanbul_clear.png
istanbul_clouds.png
istanbul_rain.png
ankara_clear.png
ankara_clouds.png
ankara_rain.png
izmir_clear.png
izmir_clouds.png
izmir_rain.png
bursa_clear.png
bursa_clouds.png
bursa_rain.png
```

## Prompt Template

```text
Create a vertical 9:16 mobile weather app hero illustration for the city of {CITY_NAME}.

Use a clear 45-degree top-down isometric miniature 3D cartoon style. Show iconic and recognizable landmarks of {CITY_NAME}. Integrate a {WEATHER_CONDITION} atmosphere into the city architecture and sky.

Visual style:
- Soft, refined textures.
- Realistic PBR-like materials.
- Gentle realistic lighting and soft shadows.
- Fresh, calming, minimalist aesthetic.
- Smooth flat-color background.
- Clean unified composition.
- High-detail miniature city modeling.
- No clutter.
- No text, numbers, labels, logos, watermark, or UI typography in the image.
- Leave clean empty space at the top for Flutter UI overlay.
```

## Important

Do not put city names, dates, temperatures, or weather text inside the generated image. Flutter renders all text on top of the image.
