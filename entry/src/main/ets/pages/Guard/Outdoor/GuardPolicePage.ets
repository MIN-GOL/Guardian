import { router } from '@kit.ArkUI';
import { AsyncCallback } from '@kit.BasicServicesKit';
import { map, mapCommon, MapComponent, site } from '@kit.MapKit';
import { call } from '@kit.TelephonyKit';
import { themeManager } from '../../../manager';

@Entry
@Component
struct GuardPolicePage {
  @State
  showMap: boolean = false
  @State
  addressList: Array<site.Site> = []
  // 定位
  private mapOption?: mapCommon.MapOptions;
  private callback?: AsyncCallback<map.MapComponentController>;
  private mapController?: map.MapComponentController;

  onPageShow() {
    // 开启沉浸式
    themeManager.enableFullScreen()
  }

  onPageHide() {
    // 关闭沉浸式
    themeManager.disableFullScreen()
  }

  build() {
    Column() {
      Column() {
        if (this.showMap) {
          MapComponent({ mapOptions: this.mapOption, mapCallback: this.callback })
            .width('100%')
            .height('100%')
        }
      }
      .layoutWeight(1)

      Column() {
        // 标题
        Row() {
          Text('附近5公里内派出所')
            .fontSize(14)
            .fontWeight(500)
            .fontColor($r('app.color.font'))
          Image($r('app.media.ic_close_filled'))
            .width(20)
            .aspectRatio(1)
            .onClick(() => {
              router.back()
            })
        }
        .height(60)
        .padding({ left: 20, right: 20 })
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)

        // 列表
        List() {
          ForEach(this.addressList, (item: site.Site) => {
            ListItem() {
              Row() {
                Column({ space: 5 }) {
                  Text(item.name)
                    .fontSize(16)
                    .fontColor($r('app.color.font'))
                  Text() {
                    Span(((item.distance || 0) / 1000).toFixed(1) + '公里')
                      .fontSize(12)
                      .fontColor($r('app.color.font'))
                    Span(' ')
                    Span(item.formatAddress)
                      .fontSize(12)
                      .fontColor($r('app.color.font_sub'))
                  }
                }
                .alignItems(HorizontalAlign.Start)
                .layoutWeight(1)

                Row({ space: 20 }) {
                  Column({ space: 5 }) {
                    Image($r('app.media.ic_guard_pcs_dh'))
                      .width(26)
                      .aspectRatio(1)
                    Text('电话')
                      .fontSize(12)
                      .fontColor($r('app.color.font_sub'))
                  }
                  .onClick(() => {
                    if (!call.hasCallSync() && item.poi?.phone) {
                      call.makeCall(item.poi.phone)
                    }
                  })

                  Column({ space: 5 }) {
                    Image($r('app.media.ic_guard_pcs_lx'))
                      .width(26)
                      .aspectRatio(1)
                    Text('路线')
                      .fontSize(12)
                      .fontColor($r('app.color.font_sub'))
                  }
                }
              }
              .width('100%')
              .height(80)
              .alignItems(VerticalAlign.Center)
              .justifyContent(FlexAlign.SpaceBetween)
            }
          })
        }
        .padding({ left: 20, right: 20 })
        .width('100%')
        .height(570 - 60)
      }
      .height(570)
      .backgroundColor('#fff')
      .width('100%')
      .borderRadius({
        topLeft: 12,
        topRight: 12,
        bottomLeft: 0,
        bottomRight: 0
      })
      .clip(true)
    }
    .height('100%')
    .width('100%')
  }
}