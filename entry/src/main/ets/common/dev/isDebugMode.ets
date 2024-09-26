import { bundleManager } from '@kit.AbilityKit'

/**
 * 应用是否处于调试模式
 * @returns boolean
 */
export function isDebugMode() {
  const bundleInfo = bundleManager.getBundleInfoForSelfSync(bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_APPLICATION)
  return bundleInfo.appInfo.debug
}