### formula

```ets
/*
* 通过文本参数生成数学公式图片数组数据
*
* 参数 - latexMathTextString 数学公式文本内容
* 参数 - latexMathTextSize 数学公式文字大小 - 单位px
* 参数 - latexMathTextColor 数学公式文字颜色
* 参数 - latexMathBackGroupColor 数学公式背景颜色
* 参数 - latexMathColorFormat 数学公式图片格式
* 参数 - resPath 字体资源路径。 默认"/data/storage/el1/bundle/entry/resources/resfile/res"
*
* 返回值 - Promise<ArrayBuffer> 图片数组数据
*/
latexStringToImage(latexMathTextString: string, latexMathTextSize: number, latexMathTextColor: number, latexMathBackGroupColor: number, latexMathColorFormat: LatexMathColorFormat, resPath?: string): Promise<ArrayBuffer>

/**
 * 图片格式枚举
 */
enum LatexMathColorFormat {
  COLOR_FORMAT_RGB_565, // RGB_565
  COLOR_FORMAT_BGRA_8888 // BGRA_8888
}
```
