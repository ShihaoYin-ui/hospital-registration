import { router } from '@kit.ArkUI';
import { ApiService } from '../services/ApiService';
import { DepartmentType, Department } from '../models/Models';

@Entry
@Component
struct DepartmentList {
  @State types: DepartmentType[] = [];
  @State departments: Department[] = [];
  @State parentName: string = '';
  @State currentTypeId: number = 0;
  @State message: string = '';
  @State loading: boolean = true;
  @State mode: string = 'types'; // 'types' | 'departments'

  aboutToAppear() {
    this.loadRootTypes();
  }

  build() {
    Column() {
      Text(this.mode === 'types' ? '科室分类' : this.parentName)
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 20, bottom: 10 })

      if (this.mode === 'departments') {
        Button('返回分类')
          .width('80%')
          .margin({ bottom: 10 })
          .backgroundColor('#eeeeee')
          .fontColor('#333333')
          .onClick(() => {
            this.mode = 'types';
            this.loadRootTypes();
          })
      }

      if (this.loading) {
        Text('加载中...')
      } else if (this.message) {
        Text(this.message).fontColor('#ff4444')
      }

      List() {
        ForEach(
          this.mode === 'types' ? this.types : this.departments,
          (item: DepartmentType | Department) => {
            ListItem() {
              Row() {
                Text(item.name)
                  .fontSize(16)
                  .layoutWeight(1)

                Text('>')
                  .fontSize(18)
                  .fontColor('#999')
              }
              .width('100%')
              .padding(15)
              .onClick(() => {
                if (this.mode === 'types') {
                  const t = item as DepartmentType;
                  this.loadChildrenOrDepartments(t);
                } else {
                  const d = item as Department;
                  router.pushUrl({
                    url: 'pages/DoctorList',
                    params: { deptId: d.id, deptName: d.name }
                  });
                }
              })
            }
            .border({ width: { bottom: 0.5 }, color: '#e0e0e0' })
          }
        )
      }
      .width('100%')
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
  }

  async loadRootTypes() {
    this.loading = true;
    this.mode = 'types';
    try {
      const res = await ApiService.getRootTypes();
      if (res.code === 200) {
        this.types = res.data || [];
      } else {
        this.message = res.message;
      }
    } catch (e) {
      this.message = '加载失败: ' + JSON.stringify(e);
    }
    this.loading = false;
  }

  async loadChildrenOrDepartments(t: DepartmentType) {
    this.loading = true;
    try {
      const childRes = await ApiService.getChildTypes(t.id);
      if (childRes.code === 200 && childRes.data && childRes.data.length > 0) {
        this.types = childRes.data;
        this.mode = 'types';
        this.parentName = t.name;
      } else {
        const deptRes = await ApiService.getDepartmentsByType(t.id);
        if (deptRes.code === 200 && deptRes.data) {
          this.departments = deptRes.data as Department[];
          this.mode = 'departments';
          this.parentName = t.name;
        }
      }
    } catch (e) {
      this.message = '加载失败: ' + JSON.stringify(e);
    }
    this.loading = false;
  }
}
