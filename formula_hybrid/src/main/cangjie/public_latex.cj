/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2026. All rights reserved.
 */
package formula

public func latexStringToImage(latexMathTextString: String, latexMathTextSize: Float64,latexMathTextColor: UInt32, latexMathBackGroupColor: UInt32, latexMathColorFormat: Int64, resPath: String): Array<Byte> {
    try {
        var latex = LaTeX(resPath)
        let latexMathTextNewString = latexStrCallback(latexMathTextString)
        var r = latex.parse(latexMathTextNewString, getLatexmathWidth(latexMathTextNewString), Float32(latexMathTextSize), Float32(10.0), latexMathTextColor)
        var g2 = Graphic2D(r, latexMathColorFormatEnum(latexMathColorFormat))
        r.draw(g2, latexMathBackGroupColor)
        let arr = r.toBitmap(g2)
        latex.release()
        unsafe {
            LibC.free(g2.g2)
            LibC.free(r.nativePtr)
        }
        return arr
    } catch (_: Exception) {
        return Array<Byte>()
    }
}

func getLatexmathWidth(strLatexMath: String): Int32 {
    if (strLatexMath.contains("aligned") || strLatexMath.contains("align") || strLatexMath.contains("flalign") || strLatexMath.contains("gather") || strLatexMath.contains("multline") || strLatexMath.contains("eqnarray")) {
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
    var dataNew = strLatexMath.replace("{aligned*}", "{aligned}")
    dataNew = dataNew.replace("{align*}", "{align}")
    dataNew = dataNew.replace("{flalign*}", "{flalign}")
    dataNew = dataNew.replace("{gather*}", "{gather}")
    dataNew = dataNew.replace("{multline*}", "{multline}")
    dataNew = dataNew.replace("{eqnarray*}", "{eqnarray}")
    return dataNew
}
