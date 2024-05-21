/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2023-2023. All rights reserved.
 */

package formula

public class Graphic2D {
    var g2: CPointer<UInt8>
    var h: UInt32
    var w: UInt32

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

    public init(render: Render) {
        var w = render.getWidth()
        var h = render.getHeight()
        var textSize = render.getTextSize()
        this.w = w
        this.h = h + UInt32(textSize / 9.0) + 1
        g2 = unsafe { initGraphics2D_ffi(w, this.h) }
    }

    public func getG2(): CPointer<UInt8> {
        return g2
    }
}