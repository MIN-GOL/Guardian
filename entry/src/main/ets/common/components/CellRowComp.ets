@Component
export struct CellRowArrowComp {
  @Prop title: string = ''
  @Prop rightText: string = ''
  @Prop rightTextColor: ResourceColor = $r('app.color.font')

  build() {
    Row() {
      Text(this.title)
        .fontSize(14)
        .fontColor($r('app.color.font'))
        .layoutWeight(1)
      if (this.rightText) {
        Text(this.rightText)
          .fontSize(14)
          .fontColor(this.rightTextColor)
      }
      Image($r('app.media.ic_arrow_right_small'))
        .width(22)
        .height(22)
    }
    .width('100%')
    .height(50)
    .padding({ left: 20, right: 10 })
    .backgroundColor($r('app.color.white'))
  }
}

@Component
export struct CellRowInputComp {
  title: string = ''
  value: string = ''
  unit: string = ''

  build() {
    Row() {
      Text(this.title)
        .fontSize(14)
        .fontColor($r('app.color.font'))
        .layoutWeight(1)
      TextInput({ text: this.value })
        .width(60)
        .textAlign(TextAlign.End)
        .padding(2)
        .backgroundColor(Color.Transparent)
        .fontSize(14)
      Text(this.unit)
        .fontSize(14)
        .fontColor($r('app.color.font'))
    }
    .width('100%')
    .height(50)
    .padding({ left: 20, right: 20 })
    .justifyContent(FlexAlign.SpaceBetween)
  }
}


@Component
export struct CellRowSwitchComp {
  title: string = ''
  @Link isOn: boolean

  build() {
    Row() {
      Text(this.title)
        .fontSize(14)
        .fontColor($r('app.color.font'))
        .layoutWeight(1)
      Toggle({ type: ToggleType.Switch, isOn: this.isOn })
        .onChange((value) => {
          this.isOn = value
        })
    }
    .width('100%')
    .height(50)
    .padding({ left: 20, right: 20 })
    .justifyContent(FlexAlign.SpaceBetween)
    .backgroundColor($r('app.color.white'))
  }
}