package ohos_app_cangjie_entry

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*
import ohos.image.PixelMap
import ohos.image.ImageSource
import ohos.image.createImageSource
import formula.*

@Entry
@Component
class EntryView {
    @State
    var imagePixelMap: Option<PixelMap> = Option<PixelMap>.None
    @State
    var loaded: Bool = false
    @State
    var width: Int32 = 0
    @State
    var height: Int32 = 0
    func build() {
        Row {
            Column(10) {
                if (loaded) {
                    Image(imagePixelMap.getOrThrow()).height(Int64(height)).width(Int64(width))
                }
                Button("test")
                    .width(90.percent)
                    .height(50)
                    .shape(ShapeType.Normal)
                    .onClick {
                        evt =>
                            spawn {
                                var latex = LaTeX("/data/storage/el1/bundle/entry/resources/resfile/res")
                                var str = ###"
                                \sideset{^\backprime}{'}\sum_{x=1}^{\infty} x\sideset{a_1^2}{}\sum_{x=1}^\infty x_0
                                \\
                                \sideset{_\text{left bottom}'''}{_{\text{right bottom}}'''}\sum_{\text{quite long text}}^\infty x
                                \\
                                \sideset{}{'}
                                \sum_{n<k,\;\text{$n$ odd}} nE_n
                                \\
                                \sideset{}{'}
                                \sum^{n<k,\;\text{$n$ odd}} nE_n
                                \\
                                M_x''' M'''_x M^{'''}_x M_x{'''} M^{\prime\backprime}
                                "###
                                var r = latex.parse(str, 2000, 40.0, 10.0, 0xFF000000)
                                var g2 = Graphic2D(r, COLOR_FORMAT_RGB_565)
                                r.draw(g2, 0xFFFFFFFF)

                                var arr = r.toBitmap(g2)
                                let imageSourceApi: ImageSource = createImageSource(arr)
                                let pixelMap: Option<PixelMap> = imageSourceApi.createPixelMap()
                                if (let Some(p) <- pixelMap) {
                                    width = p.getImageInfo().size.width
                                    height = p.getImageInfo().size.height
                                    imagePixelMap = p
                                    loaded = true
                                }
                            }
                    }
            }.width(100.percent)
        }.height(100.percent)
    }
}