import { router } from '@kit.ArkUI';
import { ApiService } from '../services/ApiService';
import { UserStore, Patient } from '../models/Models';

const EMPTY_PATIENT: Patient = {
  id: 0, userId: 0, name: '', gender: '', idNumber: '',
  phone: '', relationship: '', isDefault: 'N', createTime: ''
};

@Entry
@Component
struct PatientEdit {
  @State patient: Patient = EMPTY_PATIENT;
  @State message: string = '';
  @State loading: boolean = false;
  @State isEdit: boolean = false;

  aboutToAppear() {
    const params = router.getParams() as Record<string, Object>;
    if (params && params['patient']) {
      this.patient = params['patient'] as Patient;
      this.isEdit = true;
    }
  }

  build() {
    Column() {
      Text(this.isEdit ? '编辑就诊人' : '添加就诊人')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 20, bottom: 15 })

      TextInput({ placeholder: '姓名', text: this.patient.name })
        .width('80%').margin({ bottom: 8 })
        .onChange((v: string) => { this.patient.name = v; })

      TextInput({ placeholder: '性别(M/F)', text: this.patient.gender })
        .width('80%').margin({ bottom: 8 })
        .onChange((v: string) => { this.patient.gender = v; })

      TextInput({ placeholder: '身份证号', text: this.patient.idNumber })
        .width('80%').margin({ bottom: 8 })
        .onChange((v: string) => { this.patient.idNumber = v; })

      TextInput({ placeholder: '手机号', text: this.patient.phone })
        .width('80%').margin({ bottom: 8 })
        .onChange((v: string) => { this.patient.phone = v; })

      TextInput({ placeholder: '与本人关系', text: this.patient.relationship })
        .width('80%').margin({ bottom: 8 })
        .onChange((v: string) => { this.patient.relationship = v; })

      if (this.message) {
        Text(this.message).fontColor('#ff4444').margin({ bottom: 8 })
      }

      Button(this.isEdit ? '保存修改' : '添加')
        .width('80%')
        .enabled(!this.loading)
        .onClick(() => { this.submit(); })

      Button('返回')
        .width('80%')
        .margin({ top: 8 })
        .backgroundColor('#eeeeee')
        .fontColor('#333333')
        .onClick(() => { router.back(); })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
  }

  async submit() {
    if (!this.patient.name) {
      this.message = '请填写姓名';
      return;
    }
    this.loading = true;
    try {
      const res = this.isEdit
        ? await ApiService.updatePatient(this.patient)
        : await ApiService.addPatient(this.makePatient());
      if (res.code === 200) {
        router.back();
      } else {
        this.message = res.message || '操作失败';
      }
    } catch (e) {
      this.message = '操作失败: ' + JSON.stringify(e);
    }
    this.loading = false;
  }

  makePatient(): Patient {
    const p: Patient = {
      id: this.patient.id,
      userId: UserStore.userId,
      name: this.patient.name,
      gender: this.patient.gender,
      idNumber: this.patient.idNumber,
      phone: this.patient.phone,
      relationship: this.patient.relationship,
      isDefault: this.patient.isDefault,
      createTime: this.patient.createTime
    };
    return p;
  }
}
