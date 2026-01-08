/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2026. All rights reserved.
 */
import { latexStringToImageCJ} from "libformula.so";

/**
 * 数学公式文本转换图片数组数据
 *
 * @param latexMathTextString 数学公式文本
 * @param latexMathTextSize 文本大小
 * @param latexMathTextColor 文本颜色
 * @param latexMathBackGroupColor 背景色
 * @param latexMathColorFormat 图片格式
 * @param resPath 字体资源路径
 * @returns 图片数组数据
 */
export function latexStringToImage(latexMathTextString: string, latexMathTextSize: number, latexMathTextColor: number, latexMathBackGroupColor: number, latexMathColorFormat: LatexMathColorFormat, resPath: string = "/data/storage/el1/bundle/entry/resources/resfile/res"): Promise<ArrayBuffer> {
  let colorFormat = 5
  if (latexMathColorFormat == LatexMathColorFormat.COLOR_FORMAT_RGB_565) {
    colorFormat = 2
  } else {
    colorFormat = 5
  }
  return latexStringToImageCJ(latexMathTextString, latexMathTextSize, latexMathTextColor, latexMathBackGroupColor, colorFormat, resPath)
}

/**
 * 图片格式枚举
 */
export enum LatexMathColorFormat {
  COLOR_FORMAT_RGB_565, // RGB_565
  COLOR_FORMAT_BGRA_8888 // BGRA_8888
}