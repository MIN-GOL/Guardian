import { router } from '@kit.ArkUI'

@Builder
export function NavigationTitleBuilder(title = '', fontColor = $r('app.color.white')) {
  Row({ space: 15 }) {
    Image($r('app.media.ic_public_back'))
      .fillColor(fontColor)
      .width(24)
      .onClick(() => {
        router.back()
      })
    Text(title)
      .fontSize(18)
      .fontWeight(500)
      .fontColor(fontColor)
  }
  .height('100%')
  .padding({ left: 25 })
}