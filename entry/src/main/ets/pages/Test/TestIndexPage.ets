import { router } from '@kit.ArkUI'

@Entry
@Component
struct TestIndexPage {

  build() {
    Navigation() {
      Column({ space: 10 }) {
        Button('/')
          .onClick(() => {
            router.pushUrl({ url: '/' })
          })
      }
    }
    .title('测试页入口')
    .titleMode(NavigationTitleMode.Mini)
    .mode(NavigationMode.Stack)
  }
}