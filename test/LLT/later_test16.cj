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
    var t = later_test()
    t.later_test016()
    return ret
}

@Test
public class c_test_test {
    @TestCase
    func later_test016(): Unit { //中文问题

        var latex = LaTeX("res")
        var str = ###"
\begin{array}{c}
  \text{若}\left \{a_{n}\right \}、\left \{b_{n}\right \}\text{为等差数列}, \\
  \text{则}\left \{a_{n}+ b_{n}\right \}\text{为等差数列}
\end{array}
"###
        var r = latex.parse(str, 2000000000, 40.0, 10.0, 0)
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
