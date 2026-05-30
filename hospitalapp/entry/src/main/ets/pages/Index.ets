import { router } from '@kit.ArkUI';
import { ApiService } from '../services/ApiService';
import { UserStore } from '../models/Models';

@Entry
@Component
struct Index {
  @State phone: string = '';
  @State password: string = '';
  @State message: string = '';
  @State loading: boolean = false;

  build() {
    Column() {
      Text('云医院挂号系统')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 30 })

      TextInput({ placeholder: '手机号' })
        .width('80%')
        .margin({ bottom: 10 })
        .onChange((v: string) => { this.phone = v; })

      TextInput({ placeholder: '密码' })
        .type(InputType.Password)
        .width('80%')
        .margin({ bottom: 10 })
        .onChange((v: string) => { this.password = v; })

      if (this.message) {
        Text(this.message)
          .fontColor('#ff4444')
          .margin({ bottom: 10 })
      }

      Button('登录')
        .width('80%')
        .enabled(!this.loading)
        .onClick(() => { this.doLogin(); })

      Button('注册新用户')
        .width('80%')
        .margin({ top: 10 })
        .backgroundColor('#eeeeee')
        .fontColor('#333333')
        .onClick(() => { router.pushUrl({ url: 'pages/Register' }); })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
  }

  async doLogin() {
    if (!this.phone || !this.password) {
      this.message = '请输入手机号和密码';
      return;
    }
    this.loading = true;
    try {
      const res = await ApiService.login(this.phone, this.password);
      if (res.code === 200 && res.data) {
        UserStore.userId = res.data.id;
        UserStore.userName = res.data.name;
        UserStore.phone = res.data.phone;
        router.replaceUrl({ url: 'pages/Home' });
      } else {
        this.message = res.message || '登录失败';
      }
    } catch (e) {
      this.message = '网络错误: ' + JSON.stringify(e);
    }
    this.loading = false;
  }
}
