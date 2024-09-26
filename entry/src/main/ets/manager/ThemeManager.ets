/**
 * ThemeManager 类处理主题设置，包括：
 * 1. 颜色模式设置
 * 2. 沉浸式模式设置
 * 3. 通知栏设置
 */
import { ConfigurationConstant } from '@kit.AbilityKit'
import { window } from '@kit.ArkUI'

class ThemeManager {
  windowStage: window.Window | null = null

  /** 异步获取 WindowStage */
  async getWindowStage() {
    if (this.windowStage) {
      return this.windowStage
    } else {
      return await window.getLastWindow(getContext())
    }
  }

  /** 初始化主题设置 */
  initThemeSetting() {
    const app = getContext()
      .getApplicationContext()
    app.on('environment', {
      onConfigurationUpdated: (config) => {
        AppStorage.set('colorMode', config.colorMode)
        if (config.colorMode === ConfigurationConstant.ColorMode.COLOR_MODE_LIGHT) {
          this.settingStatusBarBlack()
        }
        if (config.colorMode === ConfigurationConstant.ColorMode.COLOR_MODE_DARK) {
          this.settingStatusBarWhite()
        }
        if (config.colorMode === ConfigurationConstant.ColorMode.COLOR_MODE_NOT_SET) {
          // TODO: 处理未设置颜色模式
        }
      },
      onMemoryLevel: (_level) => {
        // TODO: 处理内存级别变化
      }
    })
    // 默认为浅色模式
    const initColorMode = AppStorage.get<ConfigurationConstant.ColorMode>('initColorMode')
    PersistentStorage.persistProp('colorMode', initColorMode)
    const currentColorMode = AppStorage.get<ConfigurationConstant.ColorMode>('colorMode')
    app.setColorMode(currentColorMode)
  }

  /** 设置状态栏为白色 */
  settingStatusBarWhite() {
    this.settingStatusBar({ statusBarContentColor: '#FFFFFF' })
  }

  /** 设置状态栏为黑色 */
  settingStatusBarBlack() {
    this.settingStatusBar({ statusBarContentColor: '#000000' })
  }

  /**
   * 设置状态栏。
   * @param {window.SystemBarProperties} config 窗口系统栏属性配置。
   */
  settingStatusBar(config: window.SystemBarProperties) {
    this.getWindowStage()
      .then((windowStage: window.Window) => {
        windowStage.setWindowSystemBarProperties(config)
      })
  }

  /** 启用全屏模式 */
  enableFullScreen() {
    this.getWindowStage()
      .then((windowStage: window.Window) => {
        windowStage.setWindowLayoutFullScreen(true)
        const topArea = windowStage.getWindowAvoidArea(window.AvoidAreaType.TYPE_SYSTEM)
        AppStorage.setOrCreate('topHeight', px2vp(topArea.topRect.height))
        const bottomArea = windowStage.getWindowAvoidArea(window.AvoidAreaType.TYPE_NAVIGATION_INDICATOR)
        AppStorage.setOrCreate('bottomHeight', px2vp(bottomArea.bottomRect.height))
      })
  }

  /** 禁用全屏模式 */
  disableFullScreen() {
    this.getWindowStage()
      .then((windowStage: window.Window) => {
        windowStage.setWindowLayoutFullScreen(false)
        AppStorage.setOrCreate('topHeight', 0)
        AppStorage.setOrCreate('bottomHeight', 0)
      })
  }
}

export const themeManager = new ThemeManager()
