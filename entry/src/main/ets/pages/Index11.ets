import { LatexMathColorFormat, latexStringToImage } from '@cangjie-tpc/formula';
import { image } from '@kit.ImageKit';

@Entry
@Component
struct Index11 {
  str: string = "F(\\omega) = \\int_{-\\infty}^{\\infty} f(t) e^{-i\\omega t} \\, dt"
  @State pixelMap: image.PixelMap = undefined!;
  @State imageWidth: number = 0;
  @State imageHeight: number = 0;

  async aboutToAppear(): Promise<void> {
    // 通过接口解析数学公式获取数学公式图片数组数据
    let buf: ArrayBuffer = await latexStringToImage(this.str, vp2px(16), 0xFF000000, 0xFFFFFFFF,
      LatexMathColorFormat.COLOR_FORMAT_RGB_565)
    let imageSource = image.createImageSource(buf)
    // 图片pixelMap
    let pixelMap = imageSource.createPixelMapSync()
    this.pixelMap = pixelMap
    let size: Size = this.pixelMap.getImageInfoSync().size
    // 图片宽度
    this.imageWidth = px2vp(size.width)
    // 图片高度
    this.imageHeight = px2vp(size.height)
  }

  build() {
    Scroll() {
      Column() {
        Image(this.pixelMap)
          .objectFit(ImageFit.Contain)
          .width(this.imageWidth)
          .height(this.imageHeight)
          .margin({ top: 5, bottom: 5 })
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)
    }
    .scrollBar(BarState.Off)
  }
}

