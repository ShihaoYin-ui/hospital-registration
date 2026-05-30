import { ApiService } from '../services/ApiService';
import { UserStore, Appointment } from '../models/Models';

@Entry
@Component
struct AppointmentList {
  @State appointments: Appointment[] = [];
  @State message: string = '';
  @State loading: boolean = true;

  aboutToAppear() {
    this.loadAppointments();
  }

  build() {
    Column() {
      Text('我的预约')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 20, bottom: 10 })

      if (this.loading) {
        Text('加载中...')
      } else if (this.message) {
        Text(this.message).fontColor('#ff4444')
      } else if (this.appointments.length === 0) {
        Text('暂无预约').margin({ top: 20 })
      }

      List() {
        ForEach(this.appointments, (item: Appointment) => {
          ListItem() {
            Column() {
              Row() {
                Text('预约ID: ' + item.id).fontSize(14)
                Text(this.statusText(item.status))
                  .fontSize(12)
                  .fontColor(this.statusColor(item.status))
                  .margin({ left: 10 })
              }

              Text('科室ID: ' + item.deptId + '  医生ID: ' + item.doctorId)
                .fontSize(12).fontColor('#666')

              Text('就诊人ID: ' + item.patientId).fontSize(12).fontColor('#666')

              if (item.appointmentTime) {
                Text('预约时间: ' + item.appointmentTime)
                  .fontSize(12).fontColor('#666')
              }

              Row() {
                if (item.status === 0 && !item.checkinTime) {
                  Button('签到')
                    .fontSize(12).height(28)
                    .onClick(() => { this.doCheckin(item.id); })

                  Button('取消')
                    .fontSize(12).height(28)
                    .backgroundColor('#ff4444')
                    .margin({ left: 8 })
                    .onClick(() => { this.doCancel(item.id); })
                }
              }
              .margin({ top: 5 })
            }
            .width('100%')
            .padding(12)
            .alignItems(HorizontalAlign.Start)
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

  statusText(s: number): string {
    switch (s) {
      case 0: return '待就诊';
      case 1: return '已完成';
      case 2: return '已取消';
      default: return '未知';
    }
  }

  statusColor(s: number): string {
    switch (s) {
      case 0: return '#007aff';
      case 1: return '#4caf50';
      case 2: return '#999';
      default: return '#999';
    }
  }

  async loadAppointments() {
    this.loading = true;
    try {
      const res = await ApiService.getUserAppointments(UserStore.userId);
      if (res.code === 200) {
        this.appointments = res.data || [];
      } else {
        this.message = res.message;
      }
    } catch (e) {
      this.message = '加载失败: ' + JSON.stringify(e);
    }
    this.loading = false;
  }

  async doCheckin(appointmentId: number) {
    try {
      const res = await ApiService.checkin(appointmentId);
      if (res.code === 200) {
        this.loadAppointments();
      } else {
        this.message = res.message || '签到失败';
      }
    } catch (e) {
      this.message = '签到失败: ' + JSON.stringify(e);
    }
  }

  async doCancel(appointmentId: number) {
    try {
      const res = await ApiService.cancelAppointment(appointmentId);
      if (res.code === 200) {
        this.loadAppointments();
      } else {
        this.message = res.message || '取消失败';
      }
    } catch (e) {
      this.message = '取消失败: ' + JSON.stringify(e);
    }
  }
}
