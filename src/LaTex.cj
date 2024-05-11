/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2023-2023. All rights reserved.
 */

package formula

public class LaTeX {
    public init(rootDir: String) {
        unsafe {
            var cstr =  LibC.mallocCString(rootDir)
            LaTeX_init(cstr)
        }
    }

    public func release(): Unit {
        unsafe { LaTeX_release() }
    }

    public func parse(ltx: String, width: Int32, textSize: Float32, lineSpace: Float32, foreground: UInt32): Render {
        unsafe {
            var cstr =  LibC.mallocCString(ltx)
            var ptr = LaTeX_parse(cstr, width, textSize, lineSpace, foreground)
            LibC.free(cstr)
            Render(ptr)
        }
    }
}