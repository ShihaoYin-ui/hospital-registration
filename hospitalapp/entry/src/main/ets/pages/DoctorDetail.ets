import { router } from '@kit.ArkUI';
import { ApiService } from '../services/ApiService';
import { UserStore, Doctor, DynamicSchedule, Patient } from '../models/Models';

@Entry
@Component
struct DoctorDetail {
  @State doctor: Doctor = {} as Doctor;
  @State schedules: DynamicSchedule[] = [];
  @State patients: Patient[] = [];
  @State message: string = '';
  @State loading: boolean = true;
  @State date: string = '';

  aboutToAppear() {
    const params = router.getParams() as Record<string, Object>;
    if (params && params['doctor']) {
      this.doctor = params['doctor'] as Doctor;
    }
    const today = new Date();
    this.date = today.getFullYear() + '-' +
      String(today.getMonth() + 1).padStart(2, '0') + '-' +
      String(today.getDate()).padStart(2, '0');
    this.loadData();
  }

  build() {
    Column() {
      Text(this.doctor.name || '医生详情')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 20, bottom: 5 })

      Text('科室ID: ' + this.doctor.deptId + '  从业' + this.doctor.practiceYear + '年')
        .fontSize(12).fontColor('#666').margin({ bottom: 5 })

      if (this.doctor.specialty) {
        Text('擅长: ' + this.doctor.specialty)
          .fontSize(13).fontColor('#333').margin({ bottom: 10 })
      }

      Text('排班日期: ' + this.date)
        .fontSize(14)
        .margin({ bottom: 10 })

      if (this.loading) {
        Text('加载中...')
      } else if (this.message) {
        Text(this.message).fontColor('#ff4444')
      } else if (this.schedules.length === 0) {
        Text('该日暂无排班').margin({ top: 20 })
      }

      List() {
        ForEach(this.schedules, (item: DynamicSchedule) => {
          ListItem() {
            Row() {
              Column() {
                Text(item.period || item.timeSlot).fontSize(16)
                Text('余号: ' + item.remainingQuota + '/' + item.totalQuota)
                  .fontSize(13).fontColor('#666')
              }
              .alignItems(HorizontalAlign.Start)
              .layoutWeight(1)

              Button('预约')
                .fontSize(13)
                .height(32)
                .enabled(item.remainingQuota > 0)
                .onClick(() => { this.reserve(item.id); })
            }
            .width('100%')
            .padding(10)
          }
          .border({ width: { bottom: 0.5 }, color: '#e0e0e0' })
        })
      }
      .width('100%')
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
  }

  async loadData() {
    this.loading = true;
    try {
      const schedRes = await ApiService.getAvailableSchedules(this.doctor.id, this.date);
      if (schedRes.code === 200) {
        this.schedules = schedRes.data || [];
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
      this.message = '请先添加就诊人';
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
