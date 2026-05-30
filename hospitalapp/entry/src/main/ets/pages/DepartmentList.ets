import { router } from '@kit.ArkUI';
import { ApiService } from '../services/ApiService';
import { DepartmentType, Department } from '../models/Models';

// 科室图标映射
const ICONS: Record<string, string> = {
  '内科': '🫀', '外科': '🔪', '儿科': '👶', '妇产科': '🤰',
  '骨科': '🦴', '眼科': '👁', '皮肤科': '🩺', '神经内科': '🧠',
  '心血管内科': '❤️', '放射科': '📷', '检验科': '🔬', '呼吸科': '🫁',
  '口腔科': '🦷', '耳鼻喉科': '👂', '消化内科': '🫄', '内分泌科': '💊',
  '临床科室': '🏥', '医技科室': '⚙️'
};

@Entry
@Component
struct DepartmentList {
  @State rootTypes: DepartmentType[] = [];
  @State rightItems: (DepartmentType | Department)[] = [];
  @State selectedTypeId: number = -1;
  @State selectedTypeName: string = '';
  @State message: string = '';
  @State loading: boolean = true;

  aboutToAppear() {
    this.loadRootTypes();
  }

  build() {
    Column() {
      // 搜索框
      Row() {
        Text('🔍').fontSize(14).margin({ right: 6 })
        Text('搜索科室').fontSize(14).fontColor('#999')
      }
      .width('94%')
      .height(38)
      .backgroundColor('#f2f2f2')
      .borderRadius(10)
      .padding({ left: 12 })
      .margin({ top: 8, bottom: 8 })

      // 左右分栏
      Row() {
        // 左侧一级科室列表
        List() {
          ForEach(this.rootTypes, (item: DepartmentType) => {
            ListItem() {
              Text(item.name)
                .fontSize(14)
                .fontColor(this.selectedTypeId === item.id ? '#0077cc' : '#333')
                .fontWeight(this.selectedTypeId === item.id ? FontWeight.Bold : FontWeight.Normal)
                .width('100%')
                .height(48)
                .textAlign(TextAlign.Center)
                .backgroundColor(this.selectedTypeId === item.id ? '#e8f4fd' : '#fafafa')
                .padding({ left: 8, right: 8 })
            }
            .onClick(() => { this.selectType(item); })
          })
        }
        .width('28%')
        .backgroundColor('#fafafa')
        .height('100%')

        Divider().vertical(true).height('100%')

        // 右侧列表
        List() {
          if (this.rightItems.length === 0) {
            ListItem() {
              Text('请选择左侧分类')
                .fontSize(14)
                .fontColor('#aaa')
                .padding(20)
            }
          }
          ForEach(this.rightItems, (item: DepartmentType | Department) => {
            ListItem() {
              Row() {
                Text(this.getIcon(item.name))
                  .fontSize(22)
                  .width(36)
                  .height(36)
                  .textAlign(TextAlign.Center)
                  .borderRadius(8)
                  .backgroundColor(this.getBgColor(item.name))
                  .margin({ right: 10 })

                Column() {
                  Text(item.name).fontSize(15).fontColor('#333')
                  // 判断是科室还是分类
                  if (this.isType(item)) {
                    Text('点击查看').fontSize(11).fontColor('#aaa')
                  } else {
                    Text('查看医生 >').fontSize(11).fontColor('#0077cc')
                  }
                }
                .alignItems(HorizontalAlign.Start)

                Blank()
                Text('>').fontSize(14).fontColor('#ccc')
              }
              .width('100%')
              .padding({ left: 12, right: 12, top: 14, bottom: 14 })
              .onClick(() => { this.onRightClick(item); })
            }
          })
        }
        .width('72%')
        .height('100%')
      }
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }

  isType(item: DepartmentType | Department): boolean {
    return (item as DepartmentType).parentId !== undefined;
  }

  getIcon(name: string): string {
    return ICONS[name] || '🏥';
  }

  getBgColor(name: string): string {
    const colors: Record<string, string> = {
      '内科': '#e8f5e9', '外科': '#e3f2fd', '儿科': '#fce4ec',
      '妇产科': '#f3e5f5', '骨科': '#fff3e0', '眼科': '#e0f7fa',
      '皮肤科': '#f1f8e9', '心血管内科': '#fce4ec', '呼吸科': '#e8f5e9'
    };
    return colors[name] || '#f5f5f5';
  }

  async loadRootTypes() {
    this.loading = true;
    try {
      const res = await ApiService.getRootTypes();
      if (res.code === 200 && res.data) {
        this.rootTypes = res.data;
        if (res.data.length > 0) {
          this.selectType(res.data[0]);
        }
      }
    } catch (e) {
      this.message = '加载失败';
    }
    this.loading = false;
  }

  selectType(item: DepartmentType) {
    this.selectedTypeId = item.id;
    this.selectedTypeName = item.name;
    this.loadRightPane(item);
  }

  async loadRightPane(t: DepartmentType) {
    try {
      const childRes = await ApiService.getChildTypes(t.id);
      if (childRes.code === 200 && childRes.data && childRes.data.length > 0) {
        this.rightItems = childRes.data;
        return;
      }
      const deptRes = await ApiService.getDepartmentsByType(t.id);
      if (deptRes.code === 200 && deptRes.data) {
        this.rightItems = deptRes.data as Department[];
      }
    } catch (e) {
      this.rightItems = [];
    }
  }

  onRightClick(item: DepartmentType | Department) {
    if (this.isType(item)) {
      // 子分类 → 更新右侧
      this.selectedTypeId = item.id;
      this.selectedTypeName = item.name;
      this.loadRightPane(item as DepartmentType);
    } else {
      // 科室 → 跳转医生列表
      const dept = item as Department;
      router.pushUrl({
        url: 'pages/DoctorList',
        params: { deptId: dept.id, deptName: dept.name }
      });
    }
  }
}
