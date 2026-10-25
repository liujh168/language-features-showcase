"""主题 09：FFI 与互操作 —— Python 版
ctypes：纯 Python 直接调用 DLL/共享库，无需写 C、无需编译。
适合调系统 API 和 C 库；追求性能时用 Cython / cffi / pybind11。
"""

import ctypes

# 加载 C 标准库（Windows 上在 ucrtbase.dll）
ucrt = ctypes.CDLL("ucrtbase.dll")
ucrt.strlen.restype = ctypes.c_size_t      # 显式声明返回类型
ucrt.strlen.argtypes = [ctypes.c_char_p]   # 和参数类型——ctypes 不做类型推断

if __name__ == "__main__":
    for s in ["hello", "modern languages"]:
        n = ucrt.strlen(s.encode("utf-8"))  # 字节串自带 NUL 结尾语义
        print(f'strlen("{s}") = {n}')
