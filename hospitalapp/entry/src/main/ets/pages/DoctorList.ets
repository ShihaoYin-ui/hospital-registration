import { router } from '@kit.ArkUI';
import { ApiService } from '../services/ApiService';
import { Doctor } from '../models/Models';

@Entry
@Component
struct DoctorList {
  @State doctors: Doctor[] = [];
  @State filteredDoctors: Doctor[] = [];
  @State deptName: string = '';
  @State deptId: number = 0;
  @State message: string = '';
  @State loading: boolean = true;
  @State selectedDate: string = '';
  @State selectedPeriod: string = 'all'; // 'all' | 'am' | 'pm'
  @State selectedTitle: number = 0; // 0=全部
  @State sortByQuota: boolean = false;

  aboutToAppear() {
    const params = router.getParams() as Record<string, Object>;
    if (params) {
      this.deptId = params['deptId'] as number;
      this.deptName = params['deptName'] as string;
    }
    this.selectedDate = this.getTodayStr();
    this.loadDoctors();
  }

  getTodayStr(): string {
    const d = new Date();
    const y = d.getFullYear();
    const m = String(d.getMonth() + 1).padStart(2, '0');
    const day = String(d.getDate()).padStart(2, '0');
    return `${y}-${m}-${day}`;
  }

  getDateList(): string[] {
    const dates: string[] = [];
    const now = new Date();
    for (let i = 0; i < 7; i++) {
      const d = new Date(now.getFullYear(), now.getMonth(), now.getDate() + i);
      const y = d.getFullYear();
      const m = String(d.getMonth() + 1).padStart(2, '0');
      const day = String(d.getDate()).padStart(2, '0');
      dates.push(`${y}-${m}-${day}`);
    }
    return dates;
  }

  getDateLabel(dateStr: string): string {
    const today = this.getTodayStr();
    if (dateStr === today) return '今天';
    const tomorrow = this.getDateList()[1];
    if (dateStr === tomorrow) return '明天';
    const parts = dateStr.split('-');
    return `${parseInt(parts[1])}/${parseInt(parts[2])}`;
  }

  applyFilter() {
    let result = [...this.doctors];
    if (this.selectedTitle > 0) {
      result = result.filter(d => d.title === this.selectedTitle);
    }
    if (this.sortByQuota) {
      // 按名字排序占位，实际应按号源数
      result.sort((a, b) => a.name.localeCompare(b.name));
    }
    this.filteredDoctors = result;
  }

  build() {
    Column() {
      // 顶部导航
      Row() {
        Text('←').fontSize(22).width(28).textAlign(TextAlign.Center)
          .onClick(() => { router.back(); })

        Text(this.deptName)
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .margin({ left: 8 })

        Blank()
      }
      .width('100%')
      .padding({ left: 12, right: 12, top: 10, bottom: 8 })
      .backgroundColor(Color.White)

      // 日期选择
      Scroll() {
        Row() {
          ForEach(this.getDateList(), (date: string) => {
            Text(this.getDateLabel(date))
              .fontSize(13)
              .fontColor(this.selectedDate === date ? Color.White : '#555')
              .fontWeight(this.selectedDate === date ? FontWeight.Bold : FontWeight.Normal)
              .width(58)
              .height(34)
              .textAlign(TextAlign.Center)
              .borderRadius(17)
              .backgroundColor(this.selectedDate === date ? '#0077cc' : '#f5f5f5')
              .margin({ right: 8 })
              .onClick(() => {
                this.selectedDate = date;
              })
          })
        }
        .padding({ left: 12, right: 12 })
      }
      .scrollable(ScrollDirection.Horizontal)
      .scrollBar(BarState.Off)
      .height(46)
      .margin({ bottom: 4 })

      // 上午/下午 + 职称筛选
      Row() {
        Row() {
          Text('全部').fontSize(12)
            .fontColor(this.selectedPeriod === 'all' ? Color.White : '#555')
            .padding({ left: 12, right: 12, top: 4, bottom: 4 })
            .borderRadius(10)
            .backgroundColor(this.selectedPeriod === 'all' ? '#0077cc' : '#f0f0f0')
            .margin({ right: 6 })
            .onClick(() => { this.selectedPeriod = 'all'; })

          Text('上午').fontSize(12)
            .fontColor(this.selectedPeriod === 'am' ? Color.White : '#555')
            .padding({ left: 12, right: 12, top: 4, bottom: 4 })
            .borderRadius(10)
            .backgroundColor(this.selectedPeriod === 'am' ? '#0077cc' : '#f0f0f0')
            .margin({ right: 6 })
            .onClick(() => { this.selectedPeriod = 'am'; })

          Text('下午').fontSize(12)
            .fontColor(this.selectedPeriod === 'pm' ? Color.White : '#555')
            .padding({ left: 12, right: 12, top: 4, bottom: 4 })
            .borderRadius(10)
            .backgroundColor(this.selectedPeriod === 'pm' ? '#0077cc' : '#f0f0f0')
            .onClick(() => { this.selectedPeriod = 'pm'; })
        }

        Blank()

        Text(this.sortByQuota ? '有号优先 ✓' : '有号优先')
          .fontSize(12)
          .fontColor('#0077cc')
          .onClick(() => {
            this.sortByQuota = !this.sortByQuota;
            this.applyFilter();
          })
      }
      .width('100%')
      .padding({ left: 12, right: 12, bottom: 6 })

      Divider()

      // 医生列表
      if (this.loading) {
        Column() {
          LoadingProgress().width(40).height(40)
          Text('加载中...').fontColor('#999').margin({ top: 8 })
        }
        .width('100%')
        .layoutWeight(1)
        .justifyContent(FlexAlign.Center)
      } else if (this.filteredDoctors.length === 0) {
        Column() {
          Text('🩺').fontSize(48)
          Text(this.message || '该科室暂无医生').fontColor('#999').margin({ top: 8 })
        }
        .width('100%')
        .layoutWeight(1)
        .justifyContent(FlexAlign.Center)
      } else {
        List() {
          ForEach(this.filteredDoctors, (item: Doctor) => {
            ListItem() {
              Row() {
                // 头像
                Text('👨‍⚕️')
                  .fontSize(28)
                  .width(48)
                  .height(48)
                  .textAlign(TextAlign.Center)
                  .borderRadius(8)
                  .backgroundColor('#e8f0fe')
                  .margin({ right: 12 })

                Column() {
                  Row() {
                    Text(item.name).fontSize(16).fontWeight(FontWeight.Bold)
                    Text(this.getTitle(item.title))
                      .fontSize(12)
                      .fontColor('#888')
                      .margin({ left: 8 })
                  }

                  Text('擅长：' + (item.specialty || '暂无'))
                    .fontSize(12)
                    .fontColor('#999')
                    .maxLines(1)
                    .margin({ top: 4, bottom: 4 })

                  Row() {
                    Text('余10号')
                      .fontSize(11)
                      .fontColor('#2e7d32')
                      .backgroundColor('#e8f5e9')
                      .borderRadius(6)
                      .padding({ left: 8, right: 8, top: 2, bottom: 2 })

                    Text('¥20')
                      .fontSize(13)
                      .fontColor('#e65100')
                      .fontWeight(FontWeight.Bold)
                      .margin({ left: 12 })
                  }
                }
                .alignItems(HorizontalAlign.Start)
                .layoutWeight(1)

                Button('预约')
                  .fontSize(13)
                  .fontColor(Color.White)
                  .backgroundColor('#0077cc')
                  .borderRadius(8)
                  .height(34)
                  .padding({ left: 14, right: 14 })
                  .onClick(() => {
                    router.pushUrl({
                      url: 'pages/DoctorDetail',
                      params: {
                        doctorId: item.id,
                        doctorName: item.name,
                        doctorTitle: this.getTitle(item.title),
                        doctorSpecialty: item.specialty || '',
                        deptId: this.deptId,
                        deptName: this.deptName,
                        practiceYear: item.practiceYear || 0
                      }
                    });
                  })
              }
              .width('100%')
              .padding({ left: 14, right: 14, top: 14, bottom: 14 })
            }
          })
        }
        .width('100%')
        .layoutWeight(1)
        .scrollBar(BarState.Off)
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#f5f5f5')
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
      if (res.code === 200 && res.data) {
        this.doctors = res.data;
        this.applyFilter();
      } else {
        this.message = res.message;
      }
    } catch (e) {
      this.message = '加载失败';
    }
    this.loading = false;
  }
}
