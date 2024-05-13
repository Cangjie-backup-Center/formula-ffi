// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from formula import formula.*
from std import unittest.*
from std import collection.*
from std import fs.*
from std import unittest.*
from std import unittest.testmacro.*

main(): Int64 {
    var ret = 0
    var t = test()
    t.test7()
    return ret
}

@Test
public class test {
    @TestCase
    func test7(): Unit {
        var latex = LaTeX("res")
        var str = ###"
\sideset{^\backprime}{'}
\sum_{x=1}^{\infty} x
\sideset{a_1^2}{}\sum_{x=1}^\infty x_0
\\
\sideset{_\text{left bottom}'''}{_{\text{right bottom}}'''}
\sum_{\text{quite long text}}^\infty x
\\
\sideset{}{'}
\sum_{n<k,\;\text{$n$ odd}} nE_n
\\
\sideset{}{'}
\sum^{n<k,\;\text{$n$ odd}} nE_n
\\
M_x''' M'''_x M^{'''}_x M_x{'''} M^{\prime\backprime}
"###
        var color1: UInt32 = 0xffff0000
        var r = latex.parse(str, 1000000000, 40.0, 10.0, color1) //宽度问题，宽度设置无效果
        var w = r.getWidth()
        var h = r.getHeight()
        println(w)
        println(h)
        var g2 = Graphic2D(r)
        r.draw(g2, 0, 0)

        var arr = r.toBitmap(g2)

        var file: File = File("test.bmp", OpenOption.CreateOrTruncate(false))
        file.write(arr)
        file.close()
    }
}
