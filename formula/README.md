<div align="center">
<h1>formula-ffi</h1>
</div>

<p align="center">
<img alt="" src="https://img.shields.io/badge/release-v1.0.2-brightgreen" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/build-pass-brightgreen" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/cjc-v1.0.5-brightgreen" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/cjcov-NA-red" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/project-open-brightgreen" style="display: inline-block;" />
</p>

## 介绍

formula 主要目的是显示用 LaTeX 编写的数学公式。

### 特性

- 🚀 特性1

  提供生成解析数学公式接口

- 🚀 特性2

  提供生成bitmap接口

- 💪 特性3

  提供生成图片资源接口

## 软件架构

### 源码目录

```shell
formula
├─ doc                       # 文档目录
│  ├─ assets
│  ├─ design.md
│  └─ feature_api.md
├── entry                    # 示例代码文件夹
├── formula                  # formula
│    ├─ formula\src\main\resources\resfile\res # 字体相关资源
│    ├─ src/main/cangjie     # 仓颉侧核心代码
│    └─ rc/main/cpp/ffi      # 仓颉ffi核心代码
├─ README.md
└─ test                      # 测试目录 
   ├─ HLT
   └─ LLT

```

### 接口说明

主要类和函数接口说明详见 [API](https://gitcode.com/Cangjie-TPC/formula-ffi/blob/formula-ffi_cangjie-plugin_5.1.1/doc/feature_api.md)

## 使用说明

### 编译构建

直接编译运行DevEco Studio


### 功能示例

#### 生成bitmap功能示例

示例代码如下：

```cangjie
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
```

## 约束与限制

    在下述版本验证通过：    
        IDE: DevEco Studio 5.1.1 Release(Build Version:5.1.1.851)

## 开源协议

本项目基于 [MIT License](./LICENSE)，请自由的享受和参与开源。

## 参与贡献

欢迎给我们提交PR，欢迎给我们提交Issue，欢迎参与任何形式的贡献。
