import { router } from '@kit.ArkUI';
import { UserStore } from '../models/Models';

// 科室卡片数据结构
interface DeptItem {
  emoji: string;
  name: string;
}

@Entry
@Component
struct Home {
  private departments: DeptItem[] = [
    { emoji: '🫀', name: '内科' },
    { emoji: '🔪', name: '外科' },
    { emoji: '👶', name: '儿科' },
    { emoji: '🤰', name: '妇产科' },
    { emoji: '🦴', name: '骨科' },
    { emoji: '👁', name: '眼科' },
    { emoji: '🫁', name: '呼吸科' },
    { emoji: '🦷', name: '口腔科' }
  ];

  build() {
    Column() {
      // ========== 顶部导航栏 ==========
      Row() {
        Row() {
          Text('🏥').fontSize(20)
          Text('云医院').fontSize(18).fontWeight(FontWeight.Bold).margin({ left: 6 })
        }

        Blank()

        Text('🔔')
          .fontSize(20)
          .margin({ right: 12 })

        Row() {
          Text('👤')
            .fontSize(18)
            .width(32)
            .height(32)
            .textAlign(TextAlign.Center)
            .borderRadius(16)
            .backgroundColor('#e8f0fe')
        }
        .onClick(() => { router.pushUrl({ url: 'pages/Mine' }); })
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 12, bottom: 10 })
      .backgroundColor(Color.White)

      // ========== 滚动内容区 ==========
      Scroll() {
        Column() {

          // ========== 搜索区 ==========
          Row() {
            Text('🔍')
              .fontSize(16)
              .margin({ right: 8 })

            Text('搜索科室、医生或症状')
              .fontSize(14)
              .fontColor('#999999')
          }
          .width('90%')
          .height(42)
          .backgroundColor('#f2f2f2')
          .borderRadius(21)
          .padding({ left: 16 })
          .margin({ top: 12, bottom: 8 })
          .onClick(() => { router.pushUrl({ url: 'pages/DepartmentList' }); })

          // ========== 公告栏 ==========
          Row() {
            Text('📢').fontSize(13)
            Text('今日儿科余号充足，可加挂；发热门诊24小时开放')
              .fontSize(12)
              .fontColor('#8B6914')
              .maxLines(1)
              .textOverflow({ overflow: TextOverflow.MARQUEE })
              .layoutWeight(1)
              .margin({ left: 6 })
          }
          .width('90%')
          .padding({ left: 12, right: 12, top: 8, bottom: 8 })
          .backgroundColor('#FFF8E1')
          .borderRadius(10)
          .margin({ bottom: 12 })

          // ========== 核心挂号入口大卡 ==========
          Row() {
            Column() {
              Text('预约挂号')
                .fontSize(20)
                .fontWeight(FontWeight.Bold)
                .fontColor(Color.White)
                .margin({ bottom: 4 })

              Text('在线预约，无需排队')
                .fontSize(13)
                .fontColor('rgba(255,255,255,0.8)')
            }
            .alignItems(HorizontalAlign.Start)
            .margin({ left: 20 })

            Blank()

            Text('👨‍⚕️📋')
              .fontSize(40)
              .margin({ right: 20 })
          }
          .width('90%')
          .height(100)
          .borderRadius(16)
          .linearGradient({
            direction: GradientDirection.Right,
            colors: [['#0077cc', 0], ['#00a8e8', 1]]
          })
          .margin({ bottom: 16 })
          .onClick(() => { router.pushUrl({ url: 'pages/DepartmentList' }); })

          // ========== 辅助入口双栏 ==========
          Row() {
            Column() {
              Text('💬').fontSize(28).margin({ bottom: 6 })
              Text('在线问诊').fontSize(13).fontColor('#555')
            }
            .width('43%')
            .height(80)
            .backgroundColor(Color.White)
            .borderRadius(12)
            .justifyContent(FlexAlign.Center)
            .shadow({ radius: 4, color: '#10000000', offsetX: 0, offsetY: 2 })

            Column() {
              Text('🩺').fontSize(28).margin({ bottom: 6 })
              Text('体检预约').fontSize(13).fontColor('#555')
            }
            .width('43%')
            .height(80)
            .backgroundColor(Color.White)
            .borderRadius(12)
            .justifyContent(FlexAlign.Center)
            .shadow({ radius: 4, color: '#10000000', offsetX: 0, offsetY: 2 })
          }
          .width('90%')
          .justifyContent(FlexAlign.SpaceBetween)
          .margin({ bottom: 20 })

          // ========== 科室九宫格 ==========
          Column() {
            Row() {
              Text('科室导航')
                .fontSize(17)
                .fontWeight(FontWeight.Bold)
              Blank()
              Text('全部 >')
                .fontSize(13)
                .fontColor('#0077cc')
                .onClick(() => { router.pushUrl({ url: 'pages/DepartmentList' }); })
            }
            .width('90%')
            .margin({ bottom: 12 })

            // 4列2行网格
            Grid() {
              ForEach(this.departments, (item: DeptItem) => {
                GridItem() {
                  Column() {
                    Text(item.emoji).fontSize(30)
                    Text(item.name)
                      .fontSize(12)
                      .fontColor('#555')
                      .margin({ top: 6 })
                  }
                  .width('100%')
                  .height(80)
                  .backgroundColor(Color.White)
                  .borderRadius(12)
                  .justifyContent(FlexAlign.Center)
                  .onClick(() => { router.pushUrl({ url: 'pages/DepartmentList' }); })
                }
              })
            }
            .columnsTemplate('1fr 1fr 1fr 1fr')
            .rowsGap(10)
            .columnsGap(10)
            .width('90%')
            .height(180)
          }
          .margin({ bottom: 24 })

          // ========== 热门医生推荐 ==========
          Column() {
            Row() {
              Text('热门专家')
                .fontSize(17)
                .fontWeight(FontWeight.Bold)
              Blank()
              Text('更多 >')
                .fontSize(13)
                .fontColor('#0077cc')
                .onClick(() => { router.pushUrl({ url: 'pages/DepartmentList' }); })
            }
            .width('90%')
            .margin({ bottom: 12 })

            // 横向滑动医生卡片
            Scroll() {
              Row() {
                this.doctorCard('张医生', '主任医师', '心内科', '15')
                this.doctorCard('李医生', '副主任医师', '神经内科', '8')
                this.doctorCard('王医生', '主任医师', '儿科', '22')
                this.doctorCard('赵医生', '主治医师', '皮肤科', '30')
              }
              .padding({ left: 16, right: 8 })
            }
            .scrollable(ScrollDirection.Horizontal)
            .scrollBar(BarState.Off)
          }

          // 底部留白
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

  @Builder
  doctorCard(name: string, title: string, dept: string, quota: string) {
    Column() {
      Text('👨‍⚕️')
        .fontSize(30)
        .width(50)
        .height(50)
        .textAlign(TextAlign.Center)
        .borderRadius(25)
        .backgroundColor('#e8f0fe')
        .margin({ bottom: 8 })

      Text(name)
        .fontSize(14)
        .fontWeight(FontWeight.Bold)

      Text(title)
        .fontSize(11)
        .fontColor('#888')
        .margin({ top: 2, bottom: 4 })

      Text('擅长：' + dept)
        .fontSize(10)
        .fontColor('#aaa')
        .maxLines(1)

      Text('余' + quota + '号')
        .fontSize(11)
        .fontColor('#2e7d32')
        .backgroundColor('#e8f5e9')
        .borderRadius(8)
        .padding({ left: 8, right: 8, top: 2, bottom: 2 })
        .margin({ top: 6 })
    }
    .width(130)
    .padding({ top: 14, bottom: 14, left: 10, right: 10 })
    .backgroundColor(Color.White)
    .borderRadius(12)
    .margin({ right: 10 })
    .shadow({ radius: 2, color: '#08000000', offsetY: 1 })
    .onClick(() => { router.pushUrl({ url: 'pages/DepartmentList' }); })
  }
}
