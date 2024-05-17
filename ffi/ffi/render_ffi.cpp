#include "config.h"

#ifdef __OS_ohos__

#include "graphic_ohos.h"
#include "latex.h"

using namespace tex;

#ifdef __cplusplus
extern "C" {
#endif

typedef struct {
    uint8_t *data;
    int64_t len;
} UInt8Data;

void TeXRender_draw(TeXRender *r, OH_Drawing_Bitmap *bitmap, int x, int y) {
    Graphics2D_ohos g2(bitmap);
    r->draw(g2, x, y);
}

float TeXRender_getTextSize(TeXRender *r) {
    return r->getTextSize();
}

int TeXRender_getHeight(TeXRender *r) {
    return r->getHeight();
}

int TeXRender_getDepth(TeXRender *r) {
    return r->getDepth();
}

int TeXRender_getWidth(TeXRender *r) {
    return r->getWidth();
}

float TeXRender_getBaseline(TeXRender *r) {
    return r->getBaseline();
}

void TeXRender_setTextSize(TeXRender *r, float size) {
    r->setTextSize(size);
}

void TeXRender_setForeground(TeXRender *r, int c) {
    r->setForeground((color)c);
}

void TeXRender_setWidth(TeXRender *r, int width, int align) {
    r->setWidth(width, align);
}

void TeXRender_setHeight(TeXRender *r, int height, int align) {
    r->setHeight(height, align);
}

void TeXRender_finalize(TeXRender *r) {
    delete r;
}

UInt8Data TeXRender_toBitmap(TeXRender *r, OH_Drawing_Bitmap *bitmap) {
    uint32_t w = OH_Drawing_BitmapGetWidth(bitmap);
    uint32_t h = OH_Drawing_BitmapGetHeight(bitmap);
    int32_t *bitmapAddr = (int32_t *)OH_Drawing_BitmapGetPixels(bitmap);
    int size = 54 + h * w * 4;
    uint8_t *data = (uint8_t *)malloc(size);
    memset(data, 0, 54);
    *(int16_t *)data = 0x4d42;
    *(int32_t *)(data+2) = size;
    *(data+0xa) = 0x36;
    *(data+0xe) = 0x28;
    *(int32_t *)(data+0x12) = w;
    *(int32_t *)(data+0x16) = h;
    *(int16_t *)(data+0x1a) = 0x1;
    *(int16_t *)(data+0x1c) = 0x20;

    int32_t *start = (int32_t *)(data + 54);
    for (int i = h-1; i >= 0; i--) {
        for (int j = 0; j < w; j++) {
            *start = *(bitmapAddr+i*w+j);
            start++;
        }
    }

    UInt8Data u8data;
    u8data.data = data;
    u8data.len = size;

    return u8data;
}

UInt8Data TeXRender_getMapData(TeXRender *r, OH_Drawing_Bitmap *bitmap) {
    uint32_t w = OH_Drawing_BitmapGetWidth(bitmap);
    uint32_t h = OH_Drawing_BitmapGetHeight(bitmap);
    int size = h * w * 4;
    uint8_t *bitmapAddr = (uint8_t *)OH_Drawing_BitmapGetPixels(bitmap);
    UInt8Data u8data;
    u8data.data = bitmapAddr;
    u8data.len = size;
    return u8data;
}

#ifdef __cplusplus
}
#endif

#endif  // __OS_ohos__
