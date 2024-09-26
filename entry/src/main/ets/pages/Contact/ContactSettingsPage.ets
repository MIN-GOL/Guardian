import { CellRowArrowComp, CellRowSwitchComp, DividerComp } from '../../common/components'

@Entry
@Component
struct ContactSettingsPage {
  @State autoBackup: boolean = false
  @State onlyWifiBackup: boolean = false

  build() {
    Navigation() {
      CellRowSwitchComp({ title: '通讯录自动备份', isOn: this.autoBackup })
      CellRowSwitchComp({ title: '仅用WiFI网络备份', isOn: this.onlyWifiBackup })
        .visibility(this.autoBackup ? Visibility.Visible : Visibility.None)
      DividerComp()
      CellRowArrowComp({ title: '清空通讯录' })
        .onClick(() => {
          // 清空通讯录
        })
    }
    .title('设置')
    .titleMode(NavigationTitleMode.Mini)
    .mode(NavigationMode.Stack)
  }
}