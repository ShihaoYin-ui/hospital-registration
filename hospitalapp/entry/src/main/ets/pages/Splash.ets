import { router } from '@kit.ArkUI';

@Entry
@Component
struct Splash {
  build() {
    Column() {
      // 右上角跳过按钮
      Row() {
        Blank()
        Text('跳过')
          .fontSize(14)
          .fontColor('rgba(128,128,128,0.7)')
          .padding({ left: 16, right: 16, top: 8, bottom: 8 })
          .onClick(() => {
            router.replaceUrl({ url: 'pages/Index' });
          })
      }
      .width('100%')
      .padding({ right: 8, top: 8 })

      Column() {
        // 医疗主题插画区
        Column() {
          Row() {
            Text('🏥').fontSize(50)
            Text('❤️').fontSize(40).margin({ left: 8, right: 8 })
            Text('📅').fontSize(50)
          }
          .margin({ bottom: 12 })

          Text('专业分诊，轻松挂号')
            .fontSize(18)
            .fontColor('#666666')
            .fontWeight(FontWeight.Medium)
        }
        .layoutWeight(1)
        .justifyContent(FlexAlign.Center)

        // 指示点（用 Text 代替 Circle 避免 API 兼容问题）
        Row() {
          Text('●').fontSize(10).fontColor('#0077cc')
          Text('●').fontSize(7).fontColor('#cccccc').margin({ left: 8, right: 8 })
          Text('●').fontSize(7).fontColor('#cccccc')
        }
        .margin({ bottom: 30 })

        // 开始按钮
        Button('开始预约')
          .fontSize(18)
          .fontColor(Color.White)
          .width('80%')
          .height(50)
          .backgroundColor('#0077cc')
          .borderRadius(25)
          .onClick(() => {
            router.replaceUrl({ url: 'pages/Index' });
          })
      }
      .width('100%')
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#f0f5fb')
  }
}
