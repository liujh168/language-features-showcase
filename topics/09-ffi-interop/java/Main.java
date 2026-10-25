// 主题 09：FFI 与互操作 —— Java 版（JNI，最繁琐路线）
// JNI 是 Java 的官方 FFI：javac -h 生成头文件 → 写 C 实现 → 编译成 DLL → 加载调用。
// 五步全手工，和 Python 的一行 ctypes 形成戏剧性对比——这也是 JNA/Panama 存在的原因。
public class Main {
    static native long strlen(String s); // native 方法：实现在 C 里

    static {
        System.loadLibrary("main"); // 加载 main.dll（本目录，见 build.bat）
    }

    public static void main(String[] args) {
        for (String s : new String[]{"hello", "modern languages"}) {
            System.out.println("strlen(\"" + s + "\") = " + strlen(s));
        }
    }
}
