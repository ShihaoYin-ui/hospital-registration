import { router } from '@kit.ArkUI';
import { ApiService } from '../services/ApiService';
import { User } from '../models/Models';

@Entry
@Component
struct Register {
  @State name: string = '';
  @State phone: string = '';
  @State password: string = '';
  @State idNumber: string = '';
  @State message: string = '';
  @State loading: boolean = false;

  build() {
    Column() {
      Text('用户注册')
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 20 })

      TextInput({ placeholder: '姓名' })
        .width('80%').margin({ bottom: 10 })
        .onChange((v: string) => { this.name = v; })

      TextInput({ placeholder: '手机号' })
        .width('80%').margin({ bottom: 10 })
        .onChange((v: string) => { this.phone = v; })

      TextInput({ placeholder: '身份证号' })
        .width('80%').margin({ bottom: 10 })
        .onChange((v: string) => { this.idNumber = v; })

      TextInput({ placeholder: '密码' })
        .type(InputType.Password)
        .width('80%').margin({ bottom: 10 })
        .onChange((v: string) => { this.password = v; })

      if (this.message) {
        Text(this.message)
          .fontColor('#ff4444')
          .margin({ bottom: 10 })
      }

      Button('注册')
        .width('80%')
        .enabled(!this.loading)
        .onClick(() => { this.doRegister(); })

      Button('返回登录')
        .width('80%')
        .margin({ top: 10 })
        .backgroundColor('#eeeeee')
        .fontColor('#333333')
        .onClick(() => { router.back(); })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
  }

  async doRegister() {
    if (!this.name || !this.phone || !this.password) {
      this.message = '请填写必填信息';
      return;
    }
    this.loading = true;
    try {
      const u: User = {
        id: 0, name: this.name, phone: this.phone, password: this.password,
        idNumber: this.idNumber, gender: '', birthDate: '', nativePlace: '',
        address: '', email: '', status: 1
      };
      const res = await ApiService.register(u);
      if (res.code === 200) {
        router.back();
      } else {
        this.message = res.message || '注册失败';
      }
    } catch (e) {
      this.message = '网络错误: ' + JSON.stringify(e);
    }
    this.loading = false;
  }
}
