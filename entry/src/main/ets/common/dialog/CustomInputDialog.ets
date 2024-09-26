@CustomDialog
export struct CustomInputDialog {
  controller?: CustomDialogController
  title?: ResourceStr = ''
  message?: ResourceStr = ''
  placeholder?: ResourceStr = ''
  @Link inputText: string
  @State tempInputText: string = ''
  onCancel?: () => void
  onConfirm?: () => void

  aboutToAppear() {
    this.tempInputText = this.inputText
  }

  build() {
    Column({ space: 10 }) {
      Text(this.title)
        .fontSize(20)
        .fontWeight(500)
        .fontColor($r('app.color.font'))
      Text(this.message)
        .fontSize(14)
        .fontColor($r('app.color.font'))
      TextInput({ text: this.tempInputText, placeholder: this.placeholder })
        .selectAll(true)// 自动全选
        .defaultFocus(true)// 自动获取焦点
        .height(40)
        .width('100%')
        .border({ width: 1, color: $r('app.color.border'), radius: 6 })
        .backgroundColor($r('app.color.white'))
        .padding({ left: 10 })
        .cancelButton({
          icon: { src: $r('app.media.ic_public_close'), size: 20 },
          style: CancelButtonStyle.INPUT
        })
        .onChange((value) => {
          this.tempInputText = value
        })
      Row({ space: 10 }) {
        Button('取消')
          .fontSize(16)
          .type(ButtonType.Normal)
          .height(40)
          .borderRadius(40 / 2)
          .backgroundColor(Color.Transparent)
          .fontColor($r('app.color.brand'))
          .layoutWeight(1)
          .onClick(() => {
            // 关闭弹窗
            this.controller?.close()
            // 执行取消
            if (this.onCancel) this.onCancel()
          })
        Button('确定')
          .fontSize(16)
          .type(ButtonType.Normal)
          .height(40)
          .borderRadius(40 / 2)
          .backgroundColor($r('app.color.brand'))
          .fontColor($r('app.color.white'))
          .layoutWeight(1)
          .enabled(this.tempInputText.length > 0)
          .onClick(() => {
            // 关闭弹窗
            this.controller?.close()
            // 更新 @Link 的值
            this.inputText = this.tempInputText
            // 执行确定
            if (this.onConfirm) this.onConfirm()
          })
      }
      .margin({ top: 10 })
    }
    .width(336)
    .borderRadius(24)
    .padding(20)
    .backgroundColor('#f1f1f1')
    .alignItems(HorizontalAlign.Start)
  }
}