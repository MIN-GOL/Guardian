@Component
export struct TitleDividerComp {
  @Prop title: string = ''
  fontSize?: number = 14

  build() {
    Row() {
      Text(this.title)
        .fontSize(this.fontSize)
        .fontWeight(500)
        .fontColor($r('app.color.font_sub'))
    }
    .width('100%')
    .height(40)
    .backgroundColor($r('app.color.background'))
    .padding({ left: 20, right: 20 })
  }
}