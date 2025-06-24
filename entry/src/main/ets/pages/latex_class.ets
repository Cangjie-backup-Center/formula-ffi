import { LatexMathColorFormat } from '@cangjie-tpc/formula';

export class LatexClass {
  latexMathTextString: string = ""
  latexMathTextSize: number = 0
  latexMathTextLineSpacing: number = 0
  latexMathTextColor: number = 0
  latexMathBackGroupColor: number = 0
  latexMathColorFormat: LatexMathColorFormat = LatexMathColorFormat.COLOR_FORMAT_BGRA_8888

  constructor(latexMathTextString: string, latexMathTextSize: number,
    latexMathTextLineSpacing: number, latexMathTextColor: number, latexMathBackGroupColor: number,
    latexMathColorFormat: LatexMathColorFormat) {
    this.latexMathTextString = latexMathTextString
    this.latexMathTextSize = latexMathTextSize
    this.latexMathTextLineSpacing = latexMathTextLineSpacing
    this.latexMathTextColor = latexMathTextColor
    this.latexMathBackGroupColor = latexMathBackGroupColor
    this.latexMathColorFormat = latexMathColorFormat
  }
}