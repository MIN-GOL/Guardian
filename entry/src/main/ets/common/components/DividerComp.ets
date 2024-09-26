@Component
export struct DividerComp {
  build() {
    Divider()
      .color($r('app.color.background'))
      .strokeWidth(10)
  }
}