import { deviceInfo } from '@kit.BasicServicesKit'

/**
 * 当前设备是否为模拟器
 * @returns boolean
 */
export function isEmulator() {
  return deviceInfo.marketName === 'emulator'
}