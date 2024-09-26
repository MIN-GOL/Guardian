import { showDevelopingTips } from '../../../common/dev'

interface Item {
  text: string
  src: string
  time: number
}

@Entry
@Component
struct FakeVoiceIndexPage {
  @State playingSrc: string = ''
  @State isRecording: boolean = false
  @State list: Item[] = [
    { text: '把那个快递给我放门口吧，我一会再拿，谢谢啊', src: 'lab_voice_trick_1.m4a', time: 7 },
    { text: '好，你放门口吧，我等会儿来拿', src: 'lab_voice_trick_2.m4a', time: 4 },
    { text: '老婆，谁呀？', src: 'lab_voice_trick_3.m4a', time: 3 },
    { text: '谁啊！干嘛呢！再不走报警了啊！', src: 'lab_voice_trick_4.m4a', time: 9 },
    { text: '宝贝，我在老地方等你呢，你到哪了？', src: 'lab_voice_trick_5.m4a', time: 5 },
    { text: '你在原地等我一会，我马上就到', src: 'lab_voice_trick_6.m4a', time: 5 },
    { text: '还有多长时间呀？我来接你吧', src: 'lab_voice_trick_7.m4a', time: 4 },
  ]

  @Builder
  TitleBuilder(title: string, description: string) {
    Column() {
      // 标题
      Row() {
        Divider()
          .backgroundColor('#0C273D')
          .vertical(true)
          .width(4)
          .height(18)
          .borderRadius(3)
          .margin({ right: 10 })
        Text(title)
          .fontSize(16)
          .fontWeight(500)
          .fontColor($r('app.color.font'))
      }
      .width('100%')

      // 说明
      Text(description)
        .fontSize(12)
        .fontColor($r('app.color.font_sub'))
        .lineHeight(18)
        .margin({ top: 10 })
        .width('100%')
    }
    .padding(20)
    .width('100%')
  }

  build() {
    Navigation() {
      Stack() {
        Scroll() {
          Column() {
            // 标题
            this.TitleBuilder('安全守护语音包',
              '推荐场景：外卖/快递上门、打车、走夜路等关键时刻，您可以通过此语音包伪装自己，震慑对方，降低危险性。')
            // 列表
            Column({ space: 20 }) {
              ForEach(this.list, (item: Item) => {
                Column() {
                  Stack() {
                    Row({ space: 5 }) {
                      if (this.playingSrc === item.src) {
                        ImageAnimator()
                          .images([
                            { src: $r('app.media.ic_public_voice1') },
                            { src: $r('app.media.ic_public_voice2') },
                            { src: $r('app.media.ic_public_voice3') },
                          ])
                          .state(AnimationStatus.Running)
                          .duration(1000)
                          .iterations(item.time)
                          .reverse(true)
                          .height(18)
                          .width(18)
                          .onFinish(() => {
                            this.playingSrc = ''
                          })
                      } else {
                        Image($r("app.media.ic_public_voice"))
                          .height(18)
                          .width(18)
                      }
                      Text(item.time + ' 〃')
                        .fontColor('#fff')
                    }
                    .padding({ left: 5 })

                    // 绘制小三角
                    Polygon({ width: 5, height: 10 })
                      .points([[0, 5], [5, 0], [5, 10]])
                      .fill('#1bd389')
                      .margin({ left: -5 })
                  }
                  .alignContent(Alignment.Start)
                  .width(50 + item.time * 4)
                  .height(32)
                  .backgroundColor('#1bd389')
                  .borderRadius(3)
                  .margin({ left: 5 })
                  .onClick(() => {
                    // TODO: 点击播放声音 - 单次
                  })

                  Text(item.text)
                    .fontSize(12)
                    .fontColor($r('app.color.font'))
                    .margin({ top: 10 })
                }
                .width('100%')
                .alignItems(HorizontalAlign.Start)
              })
            }
            .padding({ left: 20, right: 20, bottom: 20 })
          }
          .justifyContent(FlexAlign.Start)
        }
        .scrollable(ScrollDirection.Vertical)
      }
      .alignContent(Alignment.Bottom)
    }
    .title('伪装声音')
    .titleMode(NavigationTitleMode.Mini)
    .mode(NavigationMode.Stack)
  }
}