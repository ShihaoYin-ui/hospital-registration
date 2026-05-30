import { router } from '@kit.ArkUI';
import { ApiService } from '../services/ApiService';
import { User, UserStore } from '../models/Models';

@Entry
@Component
struct Mine {
  @State user: User | null = null;
  @State loading: boolean = true;
  @State showPwdDialog: boolean = false;
  @State oldPwd: string = '';
  @State newPwd: string = '';
  @State pwdMsg: string = '';

  aboutToAppear() {
    this.loadUserInfo();
  }

  async loadUserInfo() {
    this.loading = true;
    try {
      const res = await ApiService.getUserInfo(UserStore.userId);
      if (res.code === 200) {
        this.user = res.data;
      }
    } catch (e) {
      // ignore
    }
    this.loading = false;
  }

  maskIdNumber(idNumber: string): string {
    if (!idNumber || idNumber.length < 4) {
      return '****';
    }
    const last4 = idNumber.substring(idNumber.length - 4);
    const stars = '*'.repeat(idNumber.length - 4);
    return stars + last4;
  }

  async doChangePwd() {
    this.pwdMsg = '';
    if (!this.oldPwd || !this.newPwd) {
      this.pwdMsg = '请填写新旧密码';
      return;
    }
    try {
      const res = await ApiService.changePassword(UserStore.userId, this.oldPwd, this.newPwd);
      if (res.code === 200) {
        this.showPwdDialog = false;
        this.oldPwd = '';
        this.newPwd = '';
      } else {
        this.pwdMsg = res.message || '修改失败';
      }
    } catch (e) {
      this.pwdMsg = '网络错误';
    }
  }

  build() {
    Stack() {
      Column() {
        // 顶部栏
        Row() {
          Text('←')
            .fontSize(24)
            .width(24)
            .height(24)
            .textAlign(TextAlign.Center)
            .onClick(() => { router.back(); })

          Text('个人中心')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .margin({ left: 12 })

          Blank()
        }
        .width('100%')
        .padding({ left: 16, right: 16, top: 12, bottom: 12 })

        Divider()

        if (this.loading) {
          Column() {
            LoadingProgress().width(40).height(40)
            Text('加载中...').margin({ top: 8 }).fontColor('#999')
          }
          .width('100%')
          .layoutWeight(1)
          .justifyContent(FlexAlign.Center)
        } else if (this.user) {
          Column() {
            // 头像
            Text('👤')
              .fontSize(36)
              .width(72)
              .height(72)
              .textAlign(TextAlign.Center)
              .borderRadius(36)
              .backgroundColor('#e0e0e0')
              .margin({ top: 24, bottom: 8 })

            Text(this.user.name)
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .margin({ bottom: 20 })

            // 信息卡片
            Column() {
              this.infoItem('手机号', this.user.phone)
              Divider().margin({ left: 12, right: 12 })
              this.infoItem('身份证号', this.maskIdNumber(this.user.idNumber))
              Divider().margin({ left: 12, right: 12 })
              this.infoItem('性别', this.user.gender === 'M' ? '男' : this.user.gender === 'F' ? '女' : '未设置')
              Divider().margin({ left: 12, right: 12 })
              this.infoItem('出生日期', this.user.birthDate || '未设置')
              Divider().margin({ left: 12, right: 12 })
              this.infoItem('籍贯', this.user.nativePlace || '未设置')
              Divider().margin({ left: 12, right: 12 })
              this.infoItem('地址', this.user.address || '未设置')
              Divider().margin({ left: 12, right: 12 })
              this.infoItem('邮箱', this.user.email || '未设置')
            }
            .width('90%')
            .backgroundColor(Color.White)
            .borderRadius(12)
            .padding({ top: 8, bottom: 8 })

            // 功能按钮
            Button('修改密码')
              .width('90%')
              .margin({ top: 20 })
              .onClick(() => { this.showPwdDialog = true; })

            Button('就诊人管理')
              .width('90%')
              .margin({ top: 10 })
              .onClick(() => { router.pushUrl({ url: 'pages/PatientList' }); })

            Button('我的预约')
              .width('90%')
              .margin({ top: 10 })
              .onClick(() => { router.pushUrl({ url: 'pages/AppointmentList' }); })

            Button('退出登录')
              .width('90%')
              .margin({ top: 10 })
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
          .layoutWeight(1)
        }
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#f5f5f5')

      // 修改密码弹窗
      if (this.showPwdDialog) {
        Column() {
          Column() {
            Text('修改密码')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .margin({ bottom: 16 })

            TextInput({ placeholder: '原密码' })
              .type(InputType.Password)
              .width('100%')
              .margin({ bottom: 10 })
              .onChange((v: string) => { this.oldPwd = v; })

            TextInput({ placeholder: '新密码' })
              .type(InputType.Password)
              .width('100%')
              .margin({ bottom: 10 })
              .onChange((v: string) => { this.newPwd = v; })

            if (this.pwdMsg) {
              Text(this.pwdMsg)
                .fontColor('#ff4444')
                .fontSize(13)
                .margin({ bottom: 8 })
            }

            Row() {
              Button('取消')
                .backgroundColor('#eeeeee')
                .fontColor('#333333')
                .layoutWeight(1)
                .margin({ right: 8 })
                .onClick(() => {
                  this.showPwdDialog = false;
                  this.oldPwd = '';
                  this.newPwd = '';
                  this.pwdMsg = '';
                })

              Button('确认')
                .layoutWeight(1)
                .margin({ left: 8 })
                .onClick(() => { this.doChangePwd(); })
            }
            .width('100%')
          }
          .width('80%')
          .padding(20)
          .backgroundColor(Color.White)
          .borderRadius(12)
        }
        .width('100%')
        .height('100%')
        .backgroundColor('rgba(0,0,0,0.4)')
        .justifyContent(FlexAlign.Center)
        .onClick(() => {
          this.showPwdDialog = false;
          this.oldPwd = '';
          this.newPwd = '';
          this.pwdMsg = '';
        })
      }
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  infoItem(label: string, value: string) {
    Row() {
      Text(label)
        .fontSize(15)
        .fontColor('#999999')
        .width(80)

      Text(value)
        .fontSize(15)
        .fontColor('#333333')
        .layoutWeight(1)
        .textAlign(TextAlign.End)
    }
    .width('100%')
    .padding({ left: 16, right: 16, top: 12, bottom: 12 })
  }
}
