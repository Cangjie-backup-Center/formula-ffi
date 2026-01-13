/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2026. All rights reserved.
 */
package formula

import ohos.ark_interop.JSModule
import ohos.ark_interop.JSCallInfo
import ohos.ark_interop.JSValue
import ohos.ark_interop.JSContext
import std.sync.Mutex

let latexReentrantMutex: Mutex = Mutex()

func latexStringToImage(runtime: JSContext, callInfo: JSCallInfo): JSValue {
    let value0 = callInfo[0].toString(runtime)
    let value1 = callInfo[1].toNumber()
    let value2 = callInfo[2].toNumber()
    let value3 = callInfo[3].toNumber()
    let value4 = callInfo[4].toNumber()
    let value5 = callInfo[5].toString()
    // 创建PromiseCapability对象
    let promise = runtime.promiseCapability()
    // 创建新线程
    spawn {
        synchronized(latexReentrantMutex) {
            let result = latexStringToImage(value0, value1, UInt32(value2), UInt32(value3), Int64(value4), value5)
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
