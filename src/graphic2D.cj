/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2023-2023. All rights reserved.
 */

package formula

public enum ColorFormat {
    | COLOR_FORMAT_RGB_565 | COLOR_FORMAT_BGRA_8888
}

public class Graphic2D {
    var g2: CPointer<UInt8>
    var h: UInt32
    var w: UInt32
    var cf: Int32

    public prop width: UInt32 {
        get() {
            w
        }
    }

    public prop height: UInt32 {
        get() {
            h
        }
    }

    public init(render: Render, colorFormat: ColorFormat) {
        var w = render.getWidth()
        var h = render.getHeight()
        var textSize = render.getTextSize()
        this.w = w
        this.h = h + UInt32(textSize / 9.0) + 1
        this.cf = match (colorFormat) {
            case COLOR_FORMAT_RGB_565 => 2
            case COLOR_FORMAT_BGRA_8888 => 5
        }
        g2 = unsafe { initGraphics2D_ffi(this.w, this.h, this.cf) }
    }

    public func getG2(): CPointer<UInt8> {
        return g2
    }

    public func getColorFormat(): Int32 {
        return cf
    }
}