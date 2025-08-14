// import { LatexMathColorFormat, latexStringToImage } from 'formulaarkts'
import { LatexMathColorFormat, latexStringToImage } from '@cangjie-tpc/formula_hybrid'
import { image } from '@kit.ImageKit'
import hilog from '@ohos.hilog'

@Component
export struct ImageComponent {
  latexMathTextString: string = ""
  latexMathTextSize: number = 0
  latexMathTextLineSpacing: number = 0
  latexMathTextColor: number = 0
  latexMathBackGroupColor: number = 0
  latexMathColorFormat: LatexMathColorFormat = LatexMathColorFormat.COLOR_FORMAT_RGB_565
  index: number = 0
  @State pixelMap: image.PixelMap = undefined!;
  @State width1: number = 0;
  @State height1: number = 0;

  async aboutToAppear(): Promise<void> {
    let a: ArrayBuffer =
      await latexStringToImage(this.latexMathTextString, this.latexMathTextSize,
        this.latexMathTextColor, this.latexMathBackGroupColor,
        this.latexMathColorFormat)
    try {
      let b = image.createImageSource(a)
      this.pixelMap = b.createPixelMapSync()
      let size: Size = this.pixelMap.getImageInfoSync().size
      this.width1 = px2vp(size.width)
      this.height1 = px2vp(size.height)
    } catch (e) {
      hilog.error(1, "1", `--------------${e}`)
    }
  }

  build() {
    Scroll() {
      Column() {
        Text(`${this.index + 1}`)
          .margin({ top: 5, bottom: 5 })
          .fontColor(Color.Red)
          .fontSize(20)
        Image(this.pixelMap)
          .objectFit(ImageFit.Contain)
          .width(this.width1)
          .height(this.height1)
          .margin({ top: 5, bottom: 5 })
        // .scale({0.9})
        Divider()
          .vertical(false)
          .strokeWidth(1)
          .color(Color.Red)
          .margin({ top: 5, bottom: 5 })
      }
      .alignItems(HorizontalAlign.Start)
    }.scrollable(ScrollDirection.Horizontal)
    .scrollBar(BarState.Off)
    .margin({ left: 10, right: 10 })
  }
}