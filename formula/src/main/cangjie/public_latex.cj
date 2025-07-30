/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */

package formula

import ohos.ark_interop.*
import ohos.ark_interop_macro.*
import ohos.ark_interop_helper.*

public func latexStringToImage(latexMathTextString: String, latexMathTextSize: Float64,
    latexMathTextLineSpacing: Float64, latexMathTextColor: UInt32, latexMathBackGroupColor: UInt32,
    latexMathColorFormat: Int64): Array<Byte> {
    try {
        var latex = LaTeX("/data/storage/el1/bundle/entry/resources/resfile/res")
        let latexMathTextNewString = latexStrCallback(latexMathTextString)
        var r = latex.parse(latexMathTextNewString, getLatexmathWidth(latexMathTextNewString),
            Float32(latexMathTextSize), Float32(latexMathTextLineSpacing), latexMathTextColor)
        var g2 = Graphic2D(r, latexMathColorFormatEnum(latexMathColorFormat))
        r.draw(g2, latexMathBackGroupColor)
        return r.toBitmap(g2)
    } catch (_: Exception) {
        return Array<Byte>()
    }
}

func getLatexmathWidth(strLatexMath: String): Int32 {
    if (strLatexMath.contains("aligned") || strLatexMath.contains("align") || strLatexMath.contains("flalign") ||
        strLatexMath.contains("gather") || strLatexMath.contains("multline") || strLatexMath.contains("eqnarray")) {
        Int32(10)
    } else {
        Int32(2000)
    }
}

func latexMathColorFormatEnum(latexMathColorFormat: Int64): ColorFormat {
    return match (latexMathColorFormat) {
        case 2 => ColorFormat.COLOR_FORMAT_RGB_565
        case 5 => ColorFormat.COLOR_FORMAT_BGRA_8888
        case _ => ColorFormat.COLOR_FORMAT_BGRA_8888
    }
}

func latexStrCallback(strLatexMath: String): String {
    var dataNew = strLatexMath
        .replace("\\\\\\\\", "\\\\\\text{ }\\\\")
        .replace("\\\\\\\\", "\\\\\\text{ }\\\\")
    dataNew = dataNew.replace("{aligned*}", "{aligned}")
    dataNew = dataNew.replace("{align*}", "{align}")
    dataNew = dataNew.replace("{flalign*}", "{flalign}")
    dataNew = dataNew.replace("{gather*}", "{gather}")
    dataNew = dataNew.replace("{multline*}", "{multline}")
    dataNew = dataNew.replace("{eqnarray*}", "{eqnarray}")
    return dataNew
}
