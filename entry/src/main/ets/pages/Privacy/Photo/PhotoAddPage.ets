import { NavigationTitleBuilder } from '../../../common/builders'

// 图片和视频文件关键信息。(PhotoKeys)
export interface PhotoInfo {
  uri: string
  media_type: number
  date_added: number
}

// 用户相册
export interface UserAlbum {
  imageCount?: number
  albumName: string
  coverUri: string
}

interface tabItem {
  id: number
  title: string
}

@Entry
@Component
struct PhotoAddPage {
  @State currentIndex: number = 0
  @State selectUris: string[] = []
  @State tabList: tabItem[] = [{ id: 0, title: '默认相册' }, { id: 1, title: '其他相册' },]
  @State photos: PhotoInfo[] = [] // 图片数组
  @State albums: UserAlbum[] = [] // 相册数组
  @State albumPhotos: PhotoInfo[] = [] // 相册图片数组
  @State isEncrypting: boolean = false
  @State isShowUserAlbumPhoto: boolean = false
  @State completeCount: number = 0

  // 导航右侧自定义菜单
  @Builder
  NavigationMenus() {
    Row() {
      Image($r("app.media.ic_public_camera"))
        .width(20)
        .aspectRatio(1)
        .onClick(() => {
          // TODO：拍照
        })
    }
    .height('100%')
    .padding({ right: 25 })
  }

  build() {
    Stack() {
      Navigation() {
        // 顶部选项卡
        Row() {
          Row() {
            ForEach(this.tabList, (item: tabItem, index: number) => {
              // TODO: 点击滑动动画，area 获取坐标
              Text(item.title)
                .layoutWeight(1)
                .textAlign(TextAlign.Center)
                .fontSize(12)
                .fontWeight(500)
                .height('100%')
                .fontColor($r('app.color.font'))
                .border({ width: 2, color: '#E4E4E6', radius: 10 })
                .backgroundColor(index === this.currentIndex ? $r('app.color.white') : Color.Transparent)
                .onClick(() => {
                  this.currentIndex = index
                })
            })
          }
          .width('100%')
          .height(32)
          .borderRadius(10)
          .backgroundColor('#E4E4E6')
        }
        .width('100%')
        .padding({
          left: 15,
          right: 15,
          top: 20,
          bottom: 20
        })

        // Tabs
        Tabs({ index: this.currentIndex }) {
          // 默认相册
          TabContent() {
            Scroll() {
              Column() {
                GridRow({ gutter: 2, columns: 4 }) {
                  ForEach(this.photos, (item: PhotoInfo) => {
                    GridCol() {
                      Stack({ alignContent: Alignment.TopStart }) {
                        Image(item.uri)
                          .width('100%')
                          .height('100%')
                          .objectFit(ImageFit.Cover)
                          .autoResize(true)
                          .interpolation(ImageInterpolation.Medium)
                        Checkbox({ name: item.uri, group: 'group1' })
                          .margin({ left: 4, top: 4 })
                      }
                      .width('100%')
                      .aspectRatio(1)
                    }
                  })
                }

                // 占剩余高度
                Blank()
                  .layoutWeight(1)
              }
              .justifyContent(FlexAlign.Start)
            }
            .scrollable(ScrollDirection.Vertical)
            .height('100%')
          }

          // 用户相册
          TabContent() {
            Stack() {
              // 相册列表
              List() {
                ForEach(this.albums, (item: UserAlbum) => {
                  ListItem() {
                    Row({ space: 10 }) {
                      Image(item.coverUri)
                        .height(70)
                        .aspectRatio(1)
                      Column({ space: 10 }) {
                        Text(item.albumName)
                          .fontSize(16)
                          .fontColor($r('app.color.font'))
                        Text(item.imageCount?.toString())
                          .fontSize(16)
                          .fontColor($r('app.color.font_sub'))
                      }
                      .alignItems(HorizontalAlign.Start)
                      .layoutWeight(1)

                      Image($r('app.media.ic_public_arrow_right'))
                        .width(20)
                        .height(20)
                        .fillColor($r('app.color.font_sub'))
                    }
                    .padding(10)
                    .onClick(() => {
                      //
                    })
                  }
                })
              }
              .divider({ strokeWidth: 1, color: $r('app.color.border') })
              .width('100%')
              .height('100%')

              Scroll() {
                Column() {
                  GridRow({ gutter: 2, columns: 4 }) {
                    ForEach(this.albumPhotos, (item: PhotoInfo) => {
                      GridCol() {
                        Stack({ alignContent: Alignment.TopStart }) {
                          Image(item.uri)
                            .width('100%')
                            .height('100%')
                            .objectFit(ImageFit.Cover)
                          Checkbox({ name: item.uri, group: 'group2' })
                            .shape(CheckBoxShape.CIRCLE)
                            .margin({ left: 4, top: 4 })
                        }
                        .width('100%')
                        .aspectRatio(1)
                      }
                    }, (item: PhotoInfo) => item.uri)
                  }

                  // 占剩余高度
                  Blank()
                    .layoutWeight(1)
                }
                .justifyContent(FlexAlign.Start)
              }
              .scrollable(ScrollDirection.Vertical)
              .height('100%')
              .backgroundColor($r('app.color.white'))
              .visibility(this.isShowUserAlbumPhoto ? Visibility.Visible : Visibility.None)
            }
          }
        }
        .barHeight(0)
        .layoutWeight(1)
        .scrollable(false)

        // 操作栏
        Column() {
          Row() {
            Text('加密到相册：')
              .fontSize(14)
              .fontColor($r('app.color.font2'))
            Row() {
              Text('我的相册')
                .fontSize(14)
                .fontColor($r('app.color.brand'))
              Image($r('app.media.ic_arrow_right_large'))
                .width(20)
                .aspectRatio(1)
            }
          }
          .justifyContent(FlexAlign.SpaceBetween)
          .width('100%')
          .padding({ top: 15, bottom: 15 })
          .border({ width: { bottom: 1 }, color: $r('app.color.border') })

          Row({ space: 15 }) {
            Column() {
              if (this.currentIndex === 0) {
                CheckboxGroup({ group: 'group1' })
                  .onChange((value) => {
                    this.selectUris = value.name
                  })
              } else {
                CheckboxGroup({ group: 'group2' })
                  .onChange((value) => {
                    this.selectUris = value.name
                  })
              }
              Text('全选')
                .fontSize(14)
                .fontColor($r('app.color.font2'))
            }

            Button('下一步')
              .type(ButtonType.Normal)
              .borderRadius(10)
              .backgroundColor($r('app.color.brand'))
              .layoutWeight(1)
              .enabled(this.selectUris.length > 0)
              .onClick(() => {
                // TODO：选中后下一步, 加密照片
              })
          }
          .layoutWeight(1)
          .alignItems(VerticalAlign.Center)
        }
        .height(126)
        .padding({ left: 15, right: 15 })
        .backgroundColor($r('app.color.white'))
      }
      .title('添加照片 ' + (this.selectUris.length > 0 ? `(${this.selectUris.length}张)` : ''))
      .titleMode(NavigationTitleMode.Mini)
      .mode(NavigationMode.Stack)
      .menus(this.NavigationMenus())

      // 加密结果页
      Navigation() {
        Stack({ alignContent: Alignment.Bottom }) {
          Column() {
            // 内容
            Column({ space: 20 }) {
              Image($r('app.media.ic_privacy_done'))
                .height(120)
                .fillColor($r('app.color.white'))
              Text(this.completeCount.toString() + '/' + this.selectUris.length + ' 张 照片/视频 已加密')
                .fontSize(16)
                .fontColor($r('app.color.white'))
            }
            .margin({ top: 200 })
          }
          .height('100%')

          Column({ space: 10 }) {
            Button('删除照片原图')
              .type(ButtonType.Normal)
              .borderRadius(10)
              .backgroundColor($r('app.color.white'))
              .fontColor($r('app.color.danger'))
              .width('100%')
              .onClick(() => {
                // TODO：删除照片原图
              })
            Button('完成')
              .type(ButtonType.Normal)
              .borderRadius(10)
              .backgroundColor($r('app.color.white'))
              .fontColor($r('app.color.brand'))
              .width('100%')
              .onClick(() => {
                // TODO：关闭加密界面
              })
          }
          .margin({ left: 20, right: 20, bottom: 20 })
        }
        .height('100%')
      }
      .title(NavigationTitleBuilder('隐私空间'))
      .hideBackButton(true)
      .titleMode(NavigationTitleMode.Mini)
      .mode(NavigationMode.Stack)
      .linearGradient({
        angle: 213,
        colors: [[$r('app.color.brand'), 0], [$r('app.color.brand_light'), 1]]
      })
      .visibility(this.isEncrypting ? Visibility.Visible : Visibility.None)
    }
  }
}