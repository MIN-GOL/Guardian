@Component
export struct EmptyTipsComp {
  @Prop title: string = ''

  build() {
    Column({ space: 20 }) {
      Image($r('app.media.ic_public_status_empty'))
        .width(160)
        .height(144)
      Text(this.title)
        .textAlign(TextAlign.Center)
        .fontSize(13)
        .lineHeight(18)
        .fontColor('#151515')
    }
    .justifyContent(FlexAlign.Start)
    .padding({ top: 180 })
    .height('100%')
  }
}