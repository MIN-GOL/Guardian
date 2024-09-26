import { promptAction } from '@kit.ArkUI'

export function showDevelopingTips() {
  promptAction.showToast({ message: '功能开发中，敬请期待' })
}