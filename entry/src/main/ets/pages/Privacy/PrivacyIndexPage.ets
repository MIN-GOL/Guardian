import { router } from '@kit.ArkUI'
import { showDevelopingTips } from '../../common/dev'

interface Item {
  image: ResourceStr
  name: string
  count: number
}

@Entry
@Component
struct PrivacyIndexPage {
  @State count: number = 0
  // 列表
  @State list: Item[] = [
    { name: '我的相册', image: '', count: 0 },
  ]

  // 导航左侧返回按钮
  @Builder
  NavigationTitle() {
    Row({ space: 14 }) {
      Image($r('app.media.ic_public_back'))
        .width(24)
        .aspectRatio(1)
        .onClick(() => {
          // 返回到首页，中间页面全部不需要
          router.back({ url: 'pages/Index' })
        })
      Text('隐私空间')
        .fontSize(20)
        .fontWeight(500)
    }
    .height('100%')
    .padding({ left: 25 })
  }

  // 修复侧滑返回问题
  onBackPress() {
    router.back({ url: 'pages/Index' })
    return true
  }

  // 导航右侧自定义菜单
  @Builder
  NavigationMenus() {
    Row() {
      Image($r("app.media.ic_public_settings"))
        .width(22)
        .aspectRatio(1)
        .fillColor($r('app.color.font'))
        .onClick(() => {
          router.pushUrl({ url: 'pages/Privacy/PrivacySettingsPage' })
        })
    }
    .height('100%')
    .padding({ right: 25 })
  }

  build() {
    Navigation() {
      Stack({ alignContent: Alignment.Bottom }) {
        Column() {
          // 列表区域
          List() {
            ListItem() {
              Row() {
                Image($r('app.media.ic_public_photo_new'))
                  .height('100%')
                  .aspectRatio(1)

                Row() {
                  Column() {
                    Text('新建相册')
                      .fontSize(16)
                      .fontColor($r('app.color.font'))
                  }
                  .alignItems(HorizontalAlign.Start)

                  Image($r('app.media.ic_arrow_right_large'))
                    .width(20)
                    .aspectRatio(1)
                }
                .height('100%')
                .layoutWeight(1)
                .justifyContent(FlexAlign.SpaceBetween)
                .margin({ left: 15, right: 15 })
                .onClick(() => {
                  showDevelopingTips()
                })
              }
              .height(84)
            }

            ForEach(this.list, (item: Item) => {
              ListItem() {
                Row() {
                  Image(item.image || $r('app.media.ic_public_photo_empty'))
                    .height('100%')
                    .aspectRatio(1)

                  Row() {
                    Column({ space: 5 }) {
                      Text(item.name)
                        .fontSize(16)
                        .fontColor($r('app.color.font'))
                      Text(item.count.toString())
                        .fontSize(16)
                        .fontColor($r('app.color.font_sub'))
                    }
                    .alignItems(HorizontalAlign.Start)

                    Image($r('app.media.ic_arrow_right_small'))
                      .width(20)
                      .aspectRatio(1)
                  }
                  .height('100%')
                  .layoutWeight(1)
                  .justifyContent(FlexAlign.SpaceBetween)
                  .margin({ left: 15, right: 15 })
                }
                .height(84)
                .onClick(() => {
                  router.pushUrl({ url: 'pages/Privacy/Photo/PhotoIndexPage' })
                })
              }
            })
            // 空白占位盒子
            ListItem() {
              Text('长按首页隐私空间入口，即可隐藏入口')
                .fontSize(12)
                .fontColor($r('app.color.font_sub'))
                .lineHeight(30)
                .textAlign(TextAlign.Center)
                .width('100%')
            }
            .padding({ bottom: 100 })
          }
          .divider({ strokeWidth: 1, color: $r('app.color.border'), startMargin: 84 + 15 })
          .height('100%')
          .width('100%')

        }

        // 底部固定区域
        Column() {
          // 新建相册
          Image($r('app.media.ic_circle_add'))
            .width(56)
            .aspectRatio(1)
            .onClick(() => {
              router.pushUrl({ url: 'pages/Privacy/Photo/PhotoAddPage' })
            })
        }
        .height(100)
        .justifyContent(FlexAlign.Center)
        .width('100%')
      }
      .height('100%')
    }
    .title(this.NavigationTitle())
    .titleMode(NavigationTitleMode.Mini)
    .mode(NavigationMode.Stack)
    .hideBackButton(true)
    .menus(this.NavigationMenus)
  }
}