import { router } from '@kit.ArkUI';
import { ApiService } from '../services/ApiService';
import { Doctor } from '../models/Models';

@Entry
@Component
struct DoctorList {
  @State doctors: Doctor[] = [];
  @State deptName: string = '';
  @State deptId: number = 0;
  @State message: string = '';
  @State loading: boolean = true;

  aboutToAppear() {
    const params = router.getParams() as Record<string, Object>;
    if (params) {
      this.deptId = params['deptId'] as number;
      this.deptName = params['deptName'] as string;
    }
    this.loadDoctors();
  }

  build() {
    Column() {
      Text(this.deptName || '医生列表')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 20, bottom: 10 })

      if (this.loading) {
        Text('加载中...')
      } else if (this.message) {
        Text(this.message).fontColor('#ff4444')
      } else if (this.doctors.length === 0) {
        Text('该科室暂无医生').margin({ top: 20 })
      }

      List() {
        ForEach(this.doctors, (item: Doctor) => {
          ListItem() {
            Row() {
              Column() {
                Text(item.name).fontSize(16)
                Text(this.getTitle(item.title)).fontSize(13).fontColor('#666')
                if (item.specialty) {
                  Text('擅长: ' + item.specialty).fontSize(12).fontColor('#999')
                }
              }
              .alignItems(HorizontalAlign.Start)
              .layoutWeight(1)

              Text('>').fontSize(18).fontColor('#999')
            }
            .width('100%')
            .padding(15)
            .onClick(() => {
              router.pushUrl({
                url: 'pages/DoctorDetail',
                params: { doctor: item }
              });
            })
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

  getTitle(t: number): string {
    const titles: Record<number, string> = {
      1: '主任医师', 2: '副主任医师', 3: '主治医师', 4: '住院医师'
    };
    return titles[t] || '医师';
  }

  async loadDoctors() {
    this.loading = true;
    try {
      const res = await ApiService.getDoctorsByDept(this.deptId);
      if (res.code === 200) {
        this.doctors = res.data || [];
      } else {
        this.message = res.message;
      }
    } catch (e) {
      this.message = '加载失败: ' + JSON.stringify(e);
    }
    this.loading = false;
  }
}
