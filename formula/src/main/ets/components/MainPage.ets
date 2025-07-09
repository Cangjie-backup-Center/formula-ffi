/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
import { requireCJLib } from "libark_interop_loader.so";

export declare interface CustomLib {
  latexStringToImage(latexMathTextString: string, latexMathTextSize: number, latexMathTextLineSpacing: number, latexMathTextColor: number, latexMathBackGroupColor: number, latexMathColorFormat: number): Promise<ArrayBuffer>
}

let lib = requireCJLib("libformula.so") as CustomLib

/**
 * 数学公式文本转换图片数组数据
 *
 * @param latexMathTextString 数学公式文本
 * @param latexMathTextSize 文本大小
 * @param latexMathTextLineSpacing 文本间距
 * @param latexMathTextColor 文本颜色
 * @param latexMathBackGroupColor 背景色
 * @param latexMathColorFormat 图片格式
 * @returns 图片数组数据
 */
export function latexStringToImage(latexMathTextString: string, latexMathTextSize: number, latexMathTextColor: number, latexMathBackGroupColor: number, latexMathColorFormat: LatexMathColorFormat): Promise<ArrayBuffer> {
  let colorFormat = 5
  if (latexMathColorFormat == LatexMathColorFormat.COLOR_FORMAT_RGB_565) {
    colorFormat = 2
  } else {
    colorFormat = 5
  }
  return lib.latexStringToImage(latexMathTextString, latexMathTextSize, 10, latexMathTextColor, latexMathBackGroupColor, colorFormat)
}

/**
 * 图片格式枚举
 */
export enum LatexMathColorFormat {
  COLOR_FORMAT_RGB_565, // RGB_565
  COLOR_FORMAT_BGRA_8888 // BGRA_8888
}