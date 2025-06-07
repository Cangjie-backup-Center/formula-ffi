/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package formula

import ohos.ark_interop.*
import ohos.ark_interop_macro.*
import ohos.ark_interop_helper.*
import std.sync.ReentrantMutex

let latexReentrantMutex: ReentrantMutex = ReentrantMutex()

func latexStringToImage(runtime: JSContext, callInfo: JSCallInfo): JSValue {
    let value0 = callInfo[0].toString(runtime)
    let value1 = callInfo[1].toNumber()
    let value2 = callInfo[2].toNumber()
    let value3 = callInfo[3].toNumber()
    let value4 = callInfo[4].toNumber()
    let value5 = callInfo[5].toNumber()
    // 创建PromiseCapability对象
    let promise = runtime.promiseCapability()
    // 创建新线程
    spawn {
        synchronized(latexReentrantMutex) {
            let result = latexStringToImage(value0, value1, value2, UInt32(value3), UInt32(value4), Int64(value5))
            // 切换到ArkTS线程
            runtime.postJSTask {
                // 在ArkTS线程执行resolve
                promise.resolve(runtime.arrayBuffer(result).toJSValue())
            }
        }
    }
    // 返回Promise
    promise.toJSValue()
}

let EXPORT_MODULE = JSModule.registerModule {
    runtime, exports => exports["latexStringToImage"] = runtime.function(latexStringToImage).toJSValue()
}
