/* This is a forward compatability header for GLFW // GLFW3 */
#ifndef GLFW_FORWARD_H
#define GLFW_FORWARD_H

#include <stdbool.h>

#define USING_GLFW3 true
#include <GLFW/glfw3.h>
//#include <GL/glfw.h>

#ifdef USING_GLFW3
#  define GLFWwindow_fw GLFWwindow
#  define GLFWcursorposfun_fw GLFWcursorposfun
#  define GLFW_FW_FUNC_NA(name) name(GLFWwindow_fw* window)
#  define GLFW_FW_FUNC(name, ...) name(GLFWwindow_fw* window, __VA_ARGS__)
#else
#  define GLFWwindow_fw void
#  define GLFWcursorposfun_fw GLFWmouseposfun
#  define GLFW_FW_FUNC_NA(name) name
#  define GLFW_FW_FUNC(name, ...) name(__VA_ARGS__)
#endif

inline static void
glfwSwapBuffers_fw(GLFWwindow_fw *window) {
#ifdef USING_GLFW3
  glfwSwapBuffers(window);
#else
  glfwSwapBuffers();
#endif
}

inline static GLFWwindow_fw*
glfwCreateWindow_fw(int width, int height, const char *title) {
#ifdef USING_GLFW3
  GLFWwindow_fw* window = glfwCreateWindow(width, height, title, NULL, NULL);
  glfwMakeContextCurrent(window);
  return window;
#else
  int status = glfwOpenWindow(width, height, 8, 8, 8, 8, 0, 0, GLFW_WINDOW);
  glfwSetWindowTitle(title);
  return status;
#endif
}

inline static void
glfwSetWindowTitle_fw(GLFWwindow_fw* window, const char *title) {
#ifdef USING_GLFW3
  glfwSetWindowTitle(window, title);
#else
  glfwSetWindowTitle(title);
#endif
}

inline static void
glfwGetWindowSize_fw(GLFWwindow_fw* window, int *width, int *height) {
#ifdef USING_GLFW3
  glfwGetWindowSize(window, width, height);
#else
  glfwGetWindowSize(width, height);
#endif
}

inline static void
glfwSetWindowSizeCallback_fw(GLFWwindow_fw* window, GLFWwindowsizefun func) {
#ifdef USING_GLFW3
  glfwSetWindowSizeCallback(window, func);
#else
  glfwSetWindowSizeCallback(func);
#endif
}

inline static void
glfwSetWindowCloseCallback_fw(GLFWwindow_fw* window, GLFWwindowclosefun func) {
#ifdef USING_GLFW3
  glfwSetWindowCloseCallback(window, func);
#else
  glfwSetWindowCloseCallback(func);
#endif
}

inline static void
glfwSetCharCallback_fw(GLFWwindow_fw* window, GLFWcharfun func) {
#ifdef USING_GLFW3
  glfwSetCharCallback(window, func);
#else
  glfwSetCharCallback(func);
#endif
}

inline static void
glfwSetKeyCallback_fw(GLFWwindow_fw* window, GLFWkeyfun func) {
#ifdef USING_GLFW3
  glfwSetKeyCallback(window, func);
#else
  glfwSetKeyCallback(func);
#endif
}

inline static void
glfwSetMousePosCallback_fw(GLFWwindow_fw* window, GLFWcursorposfun_fw func) {
#ifdef USING_GLFW3
  glfwSetCursorPosCallback(window, func);
#else
  glfwSetMousePosCallback(func);
#endif
}

inline static void
glfwSetMouseButtonCallback_fw(GLFWwindow_fw* window, GLFWmousebuttonfun func) {
#ifdef USING_GLFW3
  glfwSetMouseButtonCallback(window, func);
#else
  glfwSetMouseButtonCallback(func);
#endif
}

#endif
