import { router } from '@kit.ArkUI';
import { ApiService } from '../services/ApiService';
import { UserStore, Doctor, DynamicSchedule, Patient } from '../models/Models';

@Entry
@Component
struct DoctorDetail {
  @State doctor: Doctor = {
    id: 0, code: '', name: '', gender: '', birthDate: '', deptId: 0,
    title: 0, level: 0, specialty: '', practiceYear: 0, polStatus: '',
    education: '', resume: '', phone: '', email: '', sortOrder: 0, status: 1
  };
  @State schedules: DynamicSchedule[] = [];
  @State patients: Patient[] = [];
  @State message: string = '';
  @State loading: boolean = true;
  @State date: string = '';
  @State doctorId: number = 0;
  @State doctorName: string = '';
  @State doctorTitle: string = '';
  @State doctorSpecialty: string = '';
  @State doctorPracticeYear: number = 0;

  aboutToAppear() {
    const params = router.getParams() as Record<string, Object>;
    if (params) {
      this.doctorId = (params['doctorId'] as number) || 0;
      this.doctorName = (params['doctorName'] as string) || '';
      this.doctorTitle = (params['doctorTitle'] as string) || '';
      this.doctorSpecialty = (params['doctorSpecialty'] as string) || '';
      this.doctorPracticeYear = (params['practiceYear'] as number) || 0;
    }
    const today = new Date();
    this.date = today.getFullYear() + '-' +
      String(today.getMonth() + 1).padStart(2, '0') + '-' +
      String(today.getDate()).padStart(2, '0');
    this.loadData();
  }

  build() {
    Column() {
      // 返回 + 医生姓名
      Row() {
        Text('←').fontSize(22).width(28).textAlign(TextAlign.Center)
          .onClick(() => { router.back(); })

        Text(this.doctorName || '医生详情')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .margin({ left: 8 })

        Blank()
      }
      .width('100%')
      .padding({ left: 12, right: 12, top: 10, bottom: 8 })
      .backgroundColor(Color.White)

      Scroll() {
        Column() {
          // 医生信息卡片
          Row() {
            Text('👨‍⚕️')
              .fontSize(40)
              .width(64)
              .height(64)
              .textAlign(TextAlign.Center)
              .borderRadius(12)
              .backgroundColor('#e8f0fe')
              .margin({ right: 14 })

            Column() {
              Text(this.doctorName)
                .fontSize(20)
                .fontWeight(FontWeight.Bold)
              Text(this.doctorTitle)
                .fontSize(14)
                .fontColor('#0077cc')
                .margin({ top: 2, bottom: 2 })
              Text('从业 ' + this.doctorPracticeYear + ' 年')
                .fontSize(12)
                .fontColor('#999')
            }
            .alignItems(HorizontalAlign.Start)
            .layoutWeight(1)
          }
          .width('92%')
          .padding(16)
          .backgroundColor(Color.White)
          .borderRadius(12)
          .margin({ top: 12, bottom: 8 })

          // 擅长领域
          if (this.doctorSpecialty) {
            Column() {
              Text('擅长领域')
                .fontSize(14)
                .fontWeight(FontWeight.Bold)
                .margin({ bottom: 8 })

              Text(this.doctorSpecialty)
                .fontSize(13)
                .fontColor('#555')
                .padding(12)
                .backgroundColor('#f5f5f5')
                .borderRadius(8)
            }
            .width('92%')
            .alignItems(HorizontalAlign.Start)
            .margin({ bottom: 12 })
          }

          // 排班标题
          Text('排班信息 - ' + this.date)
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .margin({ bottom: 10 })

          if (this.loading) {
            LoadingProgress().width(40).height(40).margin({ top: 20 })
          } else if (this.message) {
            Text(this.message).fontColor('#ff4444').margin({ top: 10 })
          } else if (this.schedules.length === 0) {
            Column() {
              Text('📅').fontSize(40)
              Text('该日暂无排班').fontColor('#999').margin({ top: 8 })
            }
            .margin({ top: 20 })
          }

          // 时间段按钮式排班
          ForEach(this.schedules, (item: DynamicSchedule) => {
            Row() {
              Column() {
                Text(item.timeSlot || '')
                  .fontSize(15)
                  .fontWeight(FontWeight.Bold)
                Text(item.period || '')
                  .fontSize(11)
                  .fontColor('#888')
              }
              .alignItems(HorizontalAlign.Start)
              .layoutWeight(1)

              Text('余' + item.remainingQuota + '/' + item.totalQuota)
                .fontSize(12)
                .fontColor(item.remainingQuota > 0 ? '#2e7d32' : '#999')
                .backgroundColor(item.remainingQuota > 0 ? '#e8f5e9' : '#f5f5f5')
                .borderRadius(6)
                .padding({ left: 10, right: 10, top: 4, bottom: 4 })
                .margin({ right: 12 })

              Button(item.remainingQuota > 0 ? '预约' : '约满')
                .fontSize(13)
                .fontColor(item.remainingQuota > 0 ? Color.White : '#999')
                .backgroundColor(item.remainingQuota > 0 ? '#0077cc' : '#e0e0e0')
                .borderRadius(8)
                .height(34)
                .enabled(item.remainingQuota > 0)
                .onClick(() => {
                  router.pushUrl({
                    url: 'pages/ConfirmAppointment',
                    params: {
                      scheduleId: item.id,
                      doctorName: this.doctorName,
                      doctorTitle: this.doctorTitle,
                      deptName: (router.getParams() as Record<string, Object>)['deptName'] as string || '',
                      timeSlot: item.timeSlot,
                      period: item.period,
                      scheduleDate: this.date,
                      fee: 20
                    }
                  });
                })
            }
            .width('92%')
            .padding(14)
            .backgroundColor(Color.White)
            .borderRadius(10)
            .margin({ bottom: 8 })
          })

          Row().height(20)
        }
        .width('100%')
        .alignItems(HorizontalAlign.Center)
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .backgroundColor('#f5f5f5')
    }
    .width('100%')
    .height('100%')
  }

  async loadData() {
    this.loading = true;
    this.message = '';
    try {
      const schedRes = await ApiService.getAvailableSchedules(this.doctorId, this.date);
      if (schedRes.code === 200) {
        this.schedules = schedRes.data || [];
      } else {
        this.message = schedRes.message;
      }
      const patRes = await ApiService.getPatientList(UserStore.userId);
      if (patRes.code === 200 && patRes.data) {
        this.patients = patRes.data;
      }
    } catch (e) {
      this.message = '加载失败: ' + JSON.stringify(e);
    }
    this.loading = false;
  }

  async reserve(scheduleId: number) {
    if (this.patients.length === 0) {
      this.message = '请先在就诊人管理中添加就诊人';
      return;
    }
    const defaultPat = this.patients.find(p => p.isDefault === 'Y') || this.patients[0];
    try {
      const res = await ApiService.reserve(UserStore.userId, defaultPat.id, scheduleId);
      if (res.code === 200) {
        this.message = '预约成功!';
        this.loadData();
      } else {
        this.message = res.message || '预约失败';
      }
    } catch (e) {
      this.message = '预约失败: ' + JSON.stringify(e);
    }
  }
}
