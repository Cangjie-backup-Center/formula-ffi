package formula.mhchem

/**
 * 化学公式处理器。
 *
 * 用于处理文本中的化学公式标记（如 \ce{...}），
 * 将其转换为标准 LaTeX 可识别、可渲染的表达形式。
 *
 * 主要职责：
 * - 识别并解析化学公式语法
 * - 按 mhchem 规则进行语义转换
 * - 输出可直接用于渲染的 LaTeX 字符串
 */
protected class Mhchem {

    /**
     * 化学公式预处理入口。
     *
     * 接收包含 \ce{...} 的原始字符串，
     * 并完成从化学语法到 LaTeX 的完整转换流程：
     *
     * 1. 加载化学公式解析规则（mhchem JSON）
     * 2. 解析 \ce{...} 结构并生成语法树（AST）
     * 3. 将 AST 转换为标准 LaTeX 表达式
     *
     * @param input 原始输入字符串（可能包含化学公式）
     * @return 转换后的 LaTeX 字符串
     */
    protected func process(input: String): String {
        MhchemJsonParser.loadJson()
        let ast = MhchemParser().go(input)
        let latex = Texify().go(ast)
        return latex
    }
}
