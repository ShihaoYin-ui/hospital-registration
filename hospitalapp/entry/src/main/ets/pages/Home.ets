import { router } from '@kit.ArkUI';
import { UserStore } from '../models/Models';

@Entry
@Component
struct Home {
  build() {
    Column() {
      Text('云医院挂号系统')
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 30, bottom: 10 })

      Text('欢迎, ' + UserStore.userName)
        .fontSize(16)
        .margin({ bottom: 30 })

      Button('就诊人管理')
        .width('80%')
        .margin({ bottom: 12 })
        .onClick(() => { router.pushUrl({ url: 'pages/PatientList' }); })

      Button('科室浏览')
        .width('80%')
        .margin({ bottom: 12 })
        .onClick(() => { router.pushUrl({ url: 'pages/DepartmentList' }); })

      Button('我的预约')
        .width('80%')
        .margin({ bottom: 12 })
        .onClick(() => { router.pushUrl({ url: 'pages/AppointmentList' }); })

      Button('退出登录')
        .width('80%')
        .margin({ top: 20 })
        .backgroundColor('#eeeeee')
        .fontColor('#333333')
        .onClick(() => {
          UserStore.userId = 0;
          UserStore.userName = '';
          UserStore.phone = '';
          router.replaceUrl({ url: 'pages/Index' });
        })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
  }
}
