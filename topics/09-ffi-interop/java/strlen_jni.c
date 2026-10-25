// JNI 实现：Java_Main_strlen
// javac -h 生成的头文件要求函数名格式为 Java_类名_方法名
#include <jni.h>
#include <string.h>

JNIEXPORT jlong JNICALL Java_Main_strlen(JNIEnv *env, jclass cls, jstring s) {
    // Java 字符串 → UTF-8 C 字符串（用完后必须释放，JNI 的“手动内存”）
    const char *cs = (*env)->GetStringUTFChars(env, s, NULL);
    jlong n = (jlong)strlen(cs);
    (*env)->ReleaseStringUTFChars(env, s, cs);
    return n;
}
