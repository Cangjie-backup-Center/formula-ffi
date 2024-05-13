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
    t.test9()
    return ret
}

@Test
public class test {
    @TestCase
    func test9(): Unit {
        var latex = LaTeX("res")
        var str = ###"
"###
        var color1: UInt32 = 0xffff0000
        var r = latex.parse(str, 10, 40.0, 10.0, color1) //宽度问题，宽度设置无效果
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
