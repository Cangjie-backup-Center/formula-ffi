/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2023-2023. All rights reserved.
 */

package formula

public class Graphic2D {
    var g2: CPointer<UInt8>

    public init(w: UInt32, h: UInt32) {
        g2 = unsafe { initGraphics2D_ffi(w, h) }
    }

    public func getG2(): CPointer<UInt8> {
        return g2
    }
}