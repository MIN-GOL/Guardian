/**
 * 注意：国际单位制（SI）中，千表示1000（103）；因此，1千字节表示1000字节。单位符号记为kB（小写k）。
 *  - Mac OS X 发行以来，文件大小均是以十进制前缀记录的。硬盘、U盘、存储卡、DVD亦是。
 *  - Windows 系统中仍在大量使用公制前缀的二进制写法，而世界上90% 的个人电脑在使用win系统。
 *  - 手机一般采用十进制，购买 512G 硬盘容量手机，手机系统设置-> 存储中 看到的就是 512GB
 * */

// KB
export const KILO_BYTE = 1000

// MB
export const MEGA_BYTE = KILO_BYTE * 1000

// GB
export const GIGA_BYTE = MEGA_BYTE * 1000

// 字节转换成 KB/MB/GB
export function formatByteLength(byteLength: number, toFixed = 2) {
  if (byteLength >= GIGA_BYTE) {
    return (byteLength / GIGA_BYTE).toFixed(toFixed) + 'GB';
  } else if (byteLength >= MEGA_BYTE) {
    return (byteLength / MEGA_BYTE).toFixed(toFixed) + 'MB';
  } else {
    return (byteLength / KILO_BYTE).toFixed(toFixed) + 'KB';
  }
}