import { router } from '@kit.ArkUI';
import { ApiService } from '../services/ApiService';
import { Patient, User } from '../models/Models';

@Entry
@Component
struct Register {
  @State name: string = '';
  @State phone: string = '';
  @State password: string = '';
  @State email: string = '';
  @State gender: string = '';
  @State birthDate: string = '';
  @State nativePlace: string = '';
  @State address: string = '';
  @State idNumber: string = '';
  @State message: string = '';
  @State loading: boolean = false;

  build() {
    Column() {
      Text('用户注册')
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 20 })

      TextInput({ placeholder: '姓名 *' })
        .width('80%').margin({ bottom: 10 })
        .onChange((v: string) => { this.name = v; })

      TextInput({ placeholder: '手机号 *' })
        .width('80%').margin({ bottom: 10 })
        .type(InputType.PhoneNumber)
        .onChange((v: string) => { this.phone = v; })

      TextInput({ placeholder: '密码 *' })
        .type(InputType.Password)
        .width('80%').margin({ bottom: 10 })
        .onChange((v: string) => { this.password = v; })

      TextInput({ placeholder: '邮箱' })
        .width('80%').margin({ bottom: 10 })
        .type(InputType.Email)
        .onChange((v: string) => { this.email = v; })

      // 性别选择
      Row() {
        Text('性别').fontSize(16).fontColor('#666').width(60)
        Row() {
          Row() {
            Radio({ value: 'M', group: 'gender' })
              .checked(this.gender === 'M')
              .onChange((checked: boolean) => { if (checked) this.gender = 'M'; })
            Text('男').margin({ left: 4, right: 16 })
          }
          Row() {
            Radio({ value: 'F', group: 'gender' })
              .checked(this.gender === 'F')
              .onChange((checked: boolean) => { if (checked) this.gender = 'F'; })
            Text('女')
          }
        }
      }
      .width('80%')
      .margin({ bottom: 10 })
      .justifyContent(FlexAlign.Start)

      // 出生日期
      TextInput({ placeholder: '出生日期 (如 1990-01-01)' })
        .width('80%').margin({ bottom: 10 })
        .onChange((v: string) => { this.birthDate = v; })

      TextInput({ placeholder: '身份证号' })
        .width('80%').margin({ bottom: 10 })
        .onChange((v: string) => { this.idNumber = v; })

      TextInput({ placeholder: '籍贯' })
        .width('80%').margin({ bottom: 10 })
        .onChange((v: string) => { this.nativePlace = v; })

      TextInput({ placeholder: '地址' })
        .width('80%').margin({ bottom: 10 })
        .onChange((v: string) => { this.address = v; })

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
      this.message = '请填写必填信息（姓名、手机号、密码）';
      return;
    }
    this.loading = true;
    try {
      const u: User = {
        id: 0, name: this.name, phone: this.phone, password: this.password,
        idNumber: this.idNumber, gender: this.gender, birthDate: this.birthDate,
        nativePlace: this.nativePlace, address: this.address, email: this.email,
        status: 1
      };
      const res = await ApiService.register(u);
      if (res.code === 200 && res.data) {
        // 自动将本人添加为就诊人
        const patient: Patient = {
          id: 0, userId: res.data.id, name: this.name,
          gender: this.gender, idNumber: this.idNumber, phone: this.phone,
          relationship: '本人', isDefault: 'Y', createTime: ''
        };
        await ApiService.addPatient(patient);
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
