import { router } from '@kit.ArkUI';
import { ApiService } from '../services/ApiService';
import { UserStore, Patient } from '../models/Models';

@Entry
@Component
struct ConfirmAppointment {
  @State doctorName: string = '';
  @State doctorTitle: string = '';
  @State deptName: string = '';
  @State timeSlot: string = '';
  @State period: string = '';
  @State scheduleDate: string = '';
  @State scheduleId: number = 0;
  @State fee: number = 20;
  @State patients: Patient[] = [];
  @State selectedPatientId: number = -1;
  @State selectedPatientName: string = '';
  @State message: string = '';
  @State loading: boolean = true;
  @State paying: boolean = false;
  @State payMethod: string = 'wechat';
  @State success: boolean = false;

  aboutToAppear() {
    const params = router.getParams() as Record<string, Object>;
    if (params) {
      this.doctorName = (params['doctorName'] as string) || '';
      this.doctorTitle = (params['doctorTitle'] as string) || '';
      this.deptName = (params['deptName'] as string) || '';
      this.timeSlot = (params['timeSlot'] as string) || '';
      this.period = (params['period'] as string) || '';
      this.scheduleDate = (params['scheduleDate'] as string) || '';
      this.scheduleId = (params['scheduleId'] as number) || 0;
      this.fee = (params['fee'] as number) || 20;
    }
    this.loadPatients();
  }

  async loadPatients() {
    try {
      const res = await ApiService.getPatientList(UserStore.userId);
      if (res.code === 200 && res.data) {
        this.patients = res.data;
        const def = this.patients.find(p => p.isDefault === 'Y');
        if (def) {
          this.selectedPatientId = def.id;
          this.selectedPatientName = def.name;
        } else if (this.patients.length > 0) {
          this.selectedPatientId = this.patients[0].id;
          this.selectedPatientName = this.patients[0].name;
        }
      }
    } catch (e) {
      this.message = '加载就诊人失败';
    }
    this.loading = false;
  }

  async doPay() {
    if (this.selectedPatientId <= 0) {
      this.message = '请选择就诊人';
      return;
    }
    this.paying = true;
    try {
      const res = await ApiService.reserve(UserStore.userId, this.selectedPatientId, this.scheduleId);
      if (res.code === 200) {
        this.success = true;
      } else {
        this.message = res.message || '预约失败';
      }
    } catch (e) {
      this.message = '支付失败: ' + JSON.stringify(e);
    }
    this.paying = false;
  }

  getPeriodLabel(): string {
    return this.period === 'AM' ? '上午' : this.period === 'PM' ? '下午' : '';
  }

  build() {
    if (this.success) {
      // 成功页
      Column() {
        Text('🎉').fontSize(60).margin({ bottom: 12 })
        Text('预约成功！')
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .margin({ bottom: 8 })

        Text(this.deptName + ' · ' + this.doctorName)
          .fontSize(15)
          .fontColor('#666')
          .margin({ bottom: 4 })

        Text(this.scheduleDate + ' ' + this.getPeriodLabel() + ' ' + this.timeSlot)
          .fontSize(14)
          .fontColor('#888')
          .margin({ bottom: 8 })

        Text('就诊人：' + this.selectedPatientName)
          .fontSize(14)
          .fontColor('#888')
          .margin({ bottom: 30 })

        Button('返回首页')
          .width('70%')
          .onClick(() => {
            router.replaceUrl({ url: 'pages/Home' });
          })
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.Center)
      .backgroundColor(Color.White)
    } else {
      Column() {
        // 顶部
        Row() {
          Text('←').fontSize(22).width(28).textAlign(TextAlign.Center)
            .onClick(() => { router.back(); })

          Text('确认预约')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .margin({ left: 8 })

          Blank()
        }
        .width('100%')
        .padding({ left: 12, right: 12, top: 10, bottom: 8 })
        .backgroundColor(Color.White)

        Divider()

        // 步骤条
        Row() {
          this.stepItem('1', '选择时间', true)
          Text('──').fontColor('#ccc').fontSize(12)
          this.stepItem('2', '确认信息', true)
          Text('──').fontColor('#ccc').fontSize(12)
          this.stepItem('3', '完成', false)
        }
        .width('90%')
        .justifyContent(FlexAlign.Center)
        .padding({ top: 16, bottom: 12 })

        Scroll() {
          Column() {
            // 挂号信息卡片
            Column() {
              Text('就诊信息')
                .fontSize(15)
                .fontWeight(FontWeight.Bold)
                .margin({ bottom: 10 })
                .alignSelf(ItemAlign.Start)

              Row() {
                Text('🏥').fontSize(20).margin({ right: 8 })
                Text(this.deptName).fontSize(15)
              }
              .margin({ bottom: 6 })
              .alignSelf(ItemAlign.Start)

              Row() {
                Text('👨‍⚕️').fontSize(20).margin({ right: 8 })
                Text(this.doctorName + ' · ' + this.doctorTitle).fontSize(15)
              }
              .margin({ bottom: 6 })
              .alignSelf(ItemAlign.Start)

              Row() {
                Text('📅').fontSize(20).margin({ right: 8 })
                Text(this.scheduleDate + ' ' + this.getPeriodLabel() + ' ' + this.timeSlot).fontSize(15)
              }
              .alignSelf(ItemAlign.Start)
            }
            .width('92%')
            .padding(16)
            .backgroundColor(Color.White)
            .borderRadius(12)
            .margin({ top: 10, bottom: 10 })

            // 就诊人选择
            Column() {
              Text('就诊人')
                .fontSize(15)
                .fontWeight(FontWeight.Bold)
                .margin({ bottom: 8 })
                .alignSelf(ItemAlign.Start)

              if (this.patients.length === 0) {
                Text('暂无就诊人，请先添加').fontColor('#999').fontSize(13)
              }

              ForEach(this.patients, (p: Patient) => {
                Row() {
                  Text(p.gender === 'M' ? '👨' : '👩')
                    .fontSize(22)
                    .width(36)
                    .height(36)
                    .textAlign(TextAlign.Center)
                    .borderRadius(18)
                    .backgroundColor('#e8f0fe')
                    .margin({ right: 10 })

                  Column() {
                    Text(p.name).fontSize(15)
                    Text(p.idNumber ? this.maskId(p.idNumber) : '').fontSize(11).fontColor('#999')
                  }
                  .alignItems(HorizontalAlign.Start)
                  .layoutWeight(1)

                  Text(this.selectedPatientId === p.id ? '✅' : '○')
                    .fontSize(18)
                }
                .width('100%')
                .padding(12)
                .backgroundColor(this.selectedPatientId === p.id ? '#f0f7ff' : Color.White)
                .borderRadius(8)
                .margin({ bottom: 6 })
                .onClick(() => {
                  this.selectedPatientId = p.id;
                  this.selectedPatientName = p.name;
                })
              })
            }
            .width('92%')
            .padding(16)
            .backgroundColor(Color.White)
            .borderRadius(12)
            .margin({ bottom: 10 })

            // 费用明细
            Column() {
              Text('费用明细')
                .fontSize(15)
                .fontWeight(FontWeight.Bold)
                .margin({ bottom: 8 })
                .alignSelf(ItemAlign.Start)

              Row() {
                Text('挂号费').fontSize(14).fontColor('#666')
                Blank()
                Text('¥' + this.fee.toFixed(2))
                  .fontSize(16)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#e65100')
              }
              .width('100%')
              .margin({ bottom: 8 })

              Divider()

              Row() {
                Text('合计').fontSize(15).fontWeight(FontWeight.Bold)
                Blank()
                Text('¥' + this.fee.toFixed(2))
                  .fontSize(18)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#e65100')
              }
              .width('100%')
            }
            .width('92%')
            .padding(16)
            .backgroundColor(Color.White)
            .borderRadius(12)
            .margin({ bottom: 10 })

            // 支付方式
            Column() {
              Text('支付方式')
                .fontSize(15)
                .fontWeight(FontWeight.Bold)
                .margin({ bottom: 8 })
                .alignSelf(ItemAlign.Start)

              Row() {
                this.payMethodCard('wechat', '💚', '微信支付')
                this.payMethodCard('alipay', '💙', '支付宝')
                this.payMethodCard('insurance', '🏦', '医保支付')
              }
              .width('100%')
              .justifyContent(FlexAlign.SpaceBetween)
            }
            .width('92%')
            .padding(16)
            .backgroundColor(Color.White)
            .borderRadius(12)
            .margin({ bottom: 10 })

            Row().height(80)
          }
          .width('100%')
          .alignItems(HorizontalAlign.Center)
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
        .backgroundColor('#f5f5f5')

        // 底部支付栏
        Row() {
          Column() {
            Text('合计 ¥' + this.fee.toFixed(2))
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor('#e65100')
          }
          .layoutWeight(1)

          Button(this.paying ? '支付中...' : '确认支付')
            .fontSize(16)
            .fontColor(Color.White)
            .backgroundColor('#0077cc')
            .borderRadius(10)
            .height(44)
            .padding({ left: 30, right: 30 })
            .enabled(!this.paying)
            .onClick(() => { this.doPay(); })
        }
        .width('100%')
        .padding({ left: 16, right: 16, top: 10, bottom: 10 })
        .backgroundColor(Color.White)
        .shadow({ radius: 8, color: '#15000000', offsetY: -2 })
      }
      .width('100%')
      .height('100%')
    }
  }

  @Builder stepItem(num: string, label: string, active: boolean) {
    Column() {
      Text(num)
        .fontSize(12)
        .fontColor(active ? Color.White : '#aaa')
        .width(20)
        .height(20)
        .textAlign(TextAlign.Center)
        .borderRadius(10)
        .backgroundColor(active ? '#0077cc' : '#e0e0e0')
        .margin({ bottom: 2 })

      Text(label)
        .fontSize(10)
        .fontColor(active ? '#0077cc' : '#aaa')
    }
  }

  @Builder payMethodCard(method: string, icon: string, name: string) {
    Column() {
      Text(icon).fontSize(24).margin({ bottom: 4 })
      Text(name).fontSize(11).fontColor('#666')
    }
    .width('30%')
    .height(64)
    .justifyContent(FlexAlign.Center)
    .backgroundColor(this.payMethod === method ? '#f0f7ff' : '#f9f9f9')
    .border({ width: 1.5, color: this.payMethod === method ? '#0077cc' : '#e0e0e0' })
    .borderRadius(10)
    .onClick(() => { this.payMethod = method; })
  }

  maskId(idNumber: string): string {
    if (!idNumber || idNumber.length < 4) return '****';
    return '*'.repeat(idNumber.length - 4) + idNumber.substring(idNumber.length - 4);
  }
}
