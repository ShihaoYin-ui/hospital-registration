import { HttpUtil } from '../utils/HttpUtil';
import { ApiResult, LoginData, User, Patient, DepartmentType, Department, Doctor, DynamicSchedule, Appointment, VisitRecord } from '../models/Models';

type Params = Record<string, string | number>;

export class ApiService {
  // 用户模块
  static async login(phone: string, password: string): Promise<ApiResult<LoginData>> {
    const p: Params = { 'phone': phone, 'password': password };
    const raw = await HttpUtil.post('/api/user/login', undefined, p);
    return JSON.parse(raw) as ApiResult<LoginData>;
  }

  static async register(user: User): Promise<ApiResult<User>> {
    const raw = await HttpUtil.post('/api/user/register', user as Object);
    return JSON.parse(raw) as ApiResult<User>;
  }

  static async changePassword(userId: number, oldPwd: string, newPwd: string): Promise<ApiResult<null>> {
    const p: Params = { 'userId': userId, 'oldPwd': oldPwd, 'newPwd': newPwd };
    const raw = await HttpUtil.put('/api/user/password', undefined, p);
    return JSON.parse(raw) as ApiResult<null>;
  }

  static async getUserInfo(userId: number): Promise<ApiResult<User>> {
    const p: Params = { 'userId': userId };
    const raw = await HttpUtil.get('/api/user/info', p);
    return JSON.parse(raw) as ApiResult<User>;
  }

  // 就诊人模块
  static async getPatientList(userId: number): Promise<ApiResult<Patient[]>> {
    const p: Params = { 'userId': userId };
    const raw = await HttpUtil.get('/api/patient/list', p);
    return JSON.parse(raw) as ApiResult<Patient[]>;
  }

  static async getDefaultPatient(userId: number): Promise<ApiResult<Patient>> {
    const p: Params = { 'userId': userId };
    const raw = await HttpUtil.get('/api/patient/default', p);
    return JSON.parse(raw) as ApiResult<Patient>;
  }

  static async addPatient(patient: Patient): Promise<ApiResult<null>> {
    const raw = await HttpUtil.post('/api/patient/add', patient as Object);
    return JSON.parse(raw) as ApiResult<null>;
  }

  static async updatePatient(patient: Patient): Promise<ApiResult<null>> {
    const raw = await HttpUtil.put('/api/patient/update', patient as Object);
    return JSON.parse(raw) as ApiResult<null>;
  }

  static async deletePatient(id: number, userId: number): Promise<ApiResult<null>> {
    const p: Params = { 'id': id, 'userId': userId };
    const raw = await HttpUtil.del('/api/patient/delete', p);
    return JSON.parse(raw) as ApiResult<null>;
  }

  static async setDefaultPatient(id: number, userId: number): Promise<ApiResult<null>> {
    const p: Params = { 'id': id, 'userId': userId };
    const raw = await HttpUtil.put('/api/patient/setDefault', undefined, p);
    return JSON.parse(raw) as ApiResult<null>;
  }

  // 科室类型模块
  static async getRootTypes(): Promise<ApiResult<DepartmentType[]>> {
    const raw = await HttpUtil.get('/api/type/root');
    return JSON.parse(raw) as ApiResult<DepartmentType[]>;
  }

  static async getChildTypes(parentId: number): Promise<ApiResult<DepartmentType[]>> {
    const p: Params = { 'parentId': parentId };
    const raw = await HttpUtil.get('/api/type/children', p);
    return JSON.parse(raw) as ApiResult<DepartmentType[]>;
  }

  // 科室模块
  static async getDepartmentsByType(type: number): Promise<ApiResult<Department[]>> {
    const p: Params = { 'type': type };
    const raw = await HttpUtil.get('/api/department/listByType', p);
    return JSON.parse(raw) as ApiResult<Department[]>;
  }

  static async getAllActiveDepartments(): Promise<ApiResult<Department[]>> {
    const raw = await HttpUtil.get('/api/department/allActive');
    return JSON.parse(raw) as ApiResult<Department[]>;
  }

  static async getDepartmentDetail(id: number): Promise<ApiResult<Department>> {
    const p: Params = { 'id': id };
    const raw = await HttpUtil.get('/api/department/detail', p);
    return JSON.parse(raw) as ApiResult<Department>;
  }

  // 医生模块
  static async getDoctorsByDept(deptId: number): Promise<ApiResult<Doctor[]>> {
    const p: Params = { 'deptId': deptId };
    const raw = await HttpUtil.get('/api/doctor/listByDept', p);
    return JSON.parse(raw) as ApiResult<Doctor[]>;
  }

  static async searchDoctors(keyword: string): Promise<ApiResult<Doctor[]>> {
    const p: Params = { 'keyword': keyword };
    const raw = await HttpUtil.get('/api/doctor/search', p);
    return JSON.parse(raw) as ApiResult<Doctor[]>;
  }

  static async getDoctorDetail(id: number): Promise<ApiResult<Doctor>> {
    const p: Params = { 'id': id };
    const raw = await HttpUtil.get('/api/doctor/detail', p);
    return JSON.parse(raw) as ApiResult<Doctor>;
  }

  // 排班模块
  static async getAvailableSchedules(doctorId: number, date: string): Promise<ApiResult<DynamicSchedule[]>> {
    const p: Params = { 'doctorId': doctorId, 'date': date };
    const raw = await HttpUtil.get('/api/schedule/available', p);
    return JSON.parse(raw) as ApiResult<DynamicSchedule[]>;
  }

  static async getScheduleRange(doctorId: number, startDate: string, endDate: string): Promise<ApiResult<DynamicSchedule[]>> {
    const p: Params = { 'doctorId': doctorId, 'startDate': startDate, 'endDate': endDate };
    const raw = await HttpUtil.get('/api/schedule/range', p);
    return JSON.parse(raw) as ApiResult<DynamicSchedule[]>;
  }

  // 预约模块
  static async reserve(userId: number, patientId: number, scheduleId: number): Promise<ApiResult<Appointment>> {
    const p: Params = { 'userId': userId, 'patientId': patientId, 'scheduleId': scheduleId };
    const raw = await HttpUtil.post('/api/appointment/reserve', undefined, p);
    return JSON.parse(raw) as ApiResult<Appointment>;
  }

  static async cancelAppointment(appointmentId: number): Promise<ApiResult<null>> {
    const p: Params = { 'appointmentId': appointmentId };
    const raw = await HttpUtil.put('/api/appointment/cancel', undefined, p);
    return JSON.parse(raw) as ApiResult<null>;
  }

  static async checkin(appointmentId: number): Promise<ApiResult<null>> {
    const p: Params = { 'appointmentId': appointmentId };
    const raw = await HttpUtil.put('/api/appointment/checkin', undefined, p);
    return JSON.parse(raw) as ApiResult<null>;
  }

  static async getUserAppointments(userId: number): Promise<ApiResult<Appointment[]>> {
    const p: Params = { 'userId': userId };
    const raw = await HttpUtil.get('/api/appointment/user', p);
    return JSON.parse(raw) as ApiResult<Appointment[]>;
  }

  static async getPatientAppointments(patientId: number): Promise<ApiResult<Appointment[]>> {
    const p: Params = { 'patientId': patientId };
    const raw = await HttpUtil.get('/api/appointment/patient', p);
    return JSON.parse(raw) as ApiResult<Appointment[]>;
  }

  static async getAppointmentDetail(id: number): Promise<ApiResult<Appointment>> {
    const p: Params = { 'id': id };
    const raw = await HttpUtil.get('/api/appointment/detail', p);
    return JSON.parse(raw) as ApiResult<Appointment>;
  }

  // 就诊记录模块
  static async getVisitByAppointment(appointmentId: number): Promise<ApiResult<VisitRecord>> {
    const p: Params = { 'appointmentId': appointmentId };
    const raw = await HttpUtil.get('/api/visit/byAppointment', p);
    return JSON.parse(raw) as ApiResult<VisitRecord>;
  }

  static async getVisitByPatient(patientId: number): Promise<ApiResult<VisitRecord[]>> {
    const p: Params = { 'patientId': patientId };
    const raw = await HttpUtil.get('/api/visit/byPatient', p);
    return JSON.parse(raw) as ApiResult<VisitRecord[]>;
  }
}
