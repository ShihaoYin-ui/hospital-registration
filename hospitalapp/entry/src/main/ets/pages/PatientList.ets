import { router } from '@kit.ArkUI';
import { ApiService } from '../services/ApiService';
import { UserStore, Patient } from '../models/Models';

@Entry
@Component
struct PatientList {
  @State patients: Patient[] = [];
  @State message: string = '';
  @State loading: boolean = true;

  aboutToAppear() {
    this.loadPatients();
  }

  onPageShow() {
    this.loadPatients();
  }

  build() {
    Column() {
      Text('就诊人管理')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 20, bottom: 10 })

      Button('添加就诊人')
        .width('80%')
        .margin({ bottom: 10 })
        .onClick(() => { router.pushUrl({ url: 'pages/PatientEdit' }); })

      if (this.loading) {
        Text('加载中...')
      } else if (this.message) {
        Text(this.message).fontColor('#ff4444')
      } else if (this.patients.length === 0) {
        Text('暂无就诊人').margin({ top: 20 })
      }

      List() {
        ForEach(this.patients, (item: Patient) => {
          ListItem() {
            Row() {
              Column() {
                Text(item.name).fontSize(16)
                Text(item.phone).fontSize(14).fontColor('#666')
                Text(item.relationship ? '关系: ' + item.relationship : '')
                  .fontSize(12).fontColor('#999')
                if (item.isDefault === 'Y') {
                  Text('默认就诊人').fontSize(12).fontColor('#007aff')
                }
              }
              .alignItems(HorizontalAlign.Start)
              .layoutWeight(1)

              Button('编辑')
                .fontSize(12)
                .height(30)
                .onClick(() => {
                  router.pushUrl({
                    url: 'pages/PatientEdit',
                    params: { patient: item }
                  });
                })

              Button('删除')
                .fontSize(12)
                .height(30)
                .backgroundColor('#ff4444')
                .onClick(() => { this.deletePatient(item); })
            }
            .width('100%')
            .padding(10)
          }
        })
      }
      .width('90%')
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
  }

  async loadPatients() {
    this.loading = true;
    try {
      const res = await ApiService.getPatientList(UserStore.userId);
      if (res.code === 200) {
        this.patients = res.data || [];
      } else {
        this.message = res.message;
      }
    } catch (e) {
      this.message = '加载失败: ' + JSON.stringify(e);
    }
    this.loading = false;
  }

  async deletePatient(item: Patient) {
    try {
      const res = await ApiService.deletePatient(item.id, UserStore.userId);
      if (res.code === 200) {
        this.loadPatients();
      } else {
        this.message = res.message || '删除失败';
      }
    } catch (e) {
      this.message = '删除失败: ' + JSON.stringify(e);
    }
  }
}
