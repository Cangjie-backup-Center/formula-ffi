/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2023-2023. All rights reserved.
 */

package formula

public class Graphic2D {
    var g2: CPointer<UInt8>

    public init(render: Render) {
        var w = render.getWidth()
        var h = render.getHeight()
        var textSize = render.getTextSize()
        g2 = unsafe { initGraphics2D_ffi(w, h + UInt32(textSize / 9.0) + 1) }
    }

    public func getG2(): CPointer<UInt8> {
        return g2
    }
}