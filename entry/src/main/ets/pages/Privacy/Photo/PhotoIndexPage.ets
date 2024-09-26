import { router } from '@kit.ArkUI'
import { EmptyTipsComp } from '../../../common/components'

// 图片和视频文件关键信息
export interface PhotoItem {
  id: number
  media_uri: string // 文件uri
  privacy_uri: string // 沙箱文件uri
  media_type: number // 媒体文件类型
  date_added: number // 添加日期
}

interface RouterParams {
  deleteUris?: string[]
}

interface GroupItem {
  date: string;
  list: PhotoItem[]; // 这里需要根据你的数据结构添加适当的类型
}

@Entry
@Component
struct PhotoIndexPage {
  @State isEditing: boolean = false
  @State list: PhotoItem[] = []
  @State groupList: GroupItem[] = []
  @State selectedName: string[] = []
  // 路由参数
  @State routerParams: RouterParams = {}
  @State isShowDelete: boolean = false
  private selectedList: PhotoItem[] = []

  @Builder
  NavigationMenus() {
    Row() {
      Text(this.isEditing ? '完成' : '编辑')
        .fontSize(16)
        .fontColor($r('app.color.font'))
        .onClick(() => {
          this.isEditing = !this.isEditing
        })
    }
    .height('100%')
    .padding({ right: 25 })
  }

  @Builder
  itemHead(text: string) {
    Row() {
      Checkbox()
        .shape(CheckBoxShape.CIRCLE)
        .selectedColor($r('app.color.brand'))
        .visibility(this.isEditing ? Visibility.Visible : Visibility.None)
      Text(text)
        .fontSize(14)
        .fontColor($r('app.color.font2'))
    }
    .backgroundColor($r('app.color.white'))
    .width("100%")
    .height(44)
  }

  @Builder
  ListHeader(title: string) {
    Row() {
      Text(title)
        .fontSize(14)
        .fontWeight(500)
        .fontColor($r('app.color.font_sub'))
    }
    .width('100%')
    .height(40)
    .backgroundColor($r('app.color.white'))
  }

  build() {
    Navigation() {
      Stack({ alignContent: Alignment.Bottom }) {
        if (this.groupList.length) {
          Column({ space: 10 }) {
            if (this.isShowDelete) {
              Row() {
                Text('系统相册里仍保留本次导入的照片原图')
                  .fontSize(14)
                  .fontColor($r('app.color.font2'))
                Text('点击删除>')
                  .fontSize(14)
                  .fontColor($r('app.color.brand'))
                  .decoration({ type: TextDecorationType.Underline, color: $r('app.color.brand') })
                  .onClick(() => {
                    // TODO：点击删除
                  })
              }
              .width('100%')
              .height(40)
              .justifyContent(FlexAlign.SpaceBetween)
              .padding({ left: 20, right: 20 })
              .backgroundColor($r('app.color.background'))
            }

            List() {
              ForEach(this.groupList, (item: GroupItem) => {
                ListItemGroup({ header: this.ListHeader(item.date) }) {
                  ListItem() {
                    GridRow({ gutter: 2, columns: 4 }) {
                      ForEach(item.list, (item: PhotoItem) => {
                        GridCol() {
                          Stack({ alignContent: Alignment.TopStart }) {
                            // TODO: 共享元素转场
                            Image(item.privacy_uri)
                              .width('100%')
                              .height('100%')
                              .objectFit(ImageFit.Cover)
                              .autoResize(true)
                              .interpolation(ImageInterpolation.Medium)
                              .sharedTransition(item.privacy_uri, { duration: 400, curve: Curve.Linear })
                              .onClick(() => {
                                // TODO：预览图片
                              })
                            Checkbox({ name: item.privacy_uri })
                              .selectedColor($r('app.color.brand'))
                              .margin({ left: 4, top: 4 })
                              .visibility(this.isEditing ? Visibility.Visible : Visibility.None)
                          }
                          .width('100%')
                          .aspectRatio(1)
                        }
                      })
                    }
                  }
                }
              })
              ListItem()
                .height(120)
            }
            .width('100%')
            .height('100%')
            .padding({ left: 10, right: 10 })
            .sticky(StickyStyle.Header) // 固定分组标题
          }
        } else {
          EmptyTipsComp({ title: '您还没有视频或照片哦' })
        }
        // 底部固定区域
        Stack({ alignContent: Alignment.Bottom }) {
          // 普通状态，添加按钮
          Column() {
            Image($r('app.media.ic_circle_add'))
              .width(56)
              .aspectRatio(1)
              .onClick(() => {
                router.pushUrl({ url: 'pages/Privacy/Photo/PhotoAddPage' })
              })
          }
          .padding({ top: 30, bottom: 30 })
          .visibility(!this.isEditing ? Visibility.Visible : Visibility.None)

          // 编辑中
          Row({ space: 15 }) {
            Column() {
              CheckboxGroup()
                .selectedColor($r('app.color.brand'))
                .onChange((value) => {
                  this.selectedName = value.name
                })
              Text('全选')
                .fontSize(14)
                .fontColor($r('app.color.font2'))
            }

            Button('复制到相册')
              .type(ButtonType.Normal)
              .borderRadius(10)
              .backgroundColor($r('app.color.brand'))
              .layoutWeight(1)
              .enabled(this.selectedName.length > 0)
              .onClick(() => {
                // TODO：复制到相册
              })

            Button('删除')
              .type(ButtonType.Normal)
              .borderRadius(10)
              .backgroundColor($r('app.color.danger'))
              .layoutWeight(1)
              .enabled(this.selectedName.length > 0)
              .onClick(() => {
                // TODO：删除
              })
          }
          .width('100%')
          .height(76)
          .backgroundColor($r('app.color.white'))
          .padding({ left: 20, right: 20 })
          .border({ width: { top: 1 }, color: $r('app.color.border') })
          .visibility(this.isEditing ? Visibility.Visible : Visibility.None)
        }
        .width('100%')
        .height(120)
      }
      .height('100%')
    }
    .title('我的相册')
    .titleMode(NavigationTitleMode.Mini)
    .mode(NavigationMode.Stack)
    .menus(this.NavigationMenus)
  }
}