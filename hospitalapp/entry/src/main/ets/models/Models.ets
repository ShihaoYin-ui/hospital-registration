export interface ApiResult<T> {
  code: number;
  message: string;
  data: T;
}

export interface LoginData {
  id: number;
  name: string;
  phone: string;
}

export interface User {
  id: number;
  idNumber: string;
  name: string;
  gender: string;
  birthDate: string;
  phone: string;
  nativePlace: string;
  address: string;
  email: string;
  password: string;
  status: number;
}

export interface Patient {
  id: number;
  userId: number;
  name: string;
  gender: string;
  idNumber: string;
  phone: string;
  relationship: string;
  isDefault: string;
  createTime: string;
}

export interface DepartmentType {
  id: number;
  code: string;
  name: string;
  parentId: number;
  sortOrder: number;
  status: number;
}

export interface Department {
  id: number;
  code: string;
  name: string;
  type: number;
  level: number;
  intro: string;
  leaderId: number;
  phone: string;
  location: string;
  sortOrder: number;
  status: number;
}

export interface Doctor {
  id: number;
  code: string;
  name: string;
  gender: string;
  birthDate: string;
  deptId: number;
  title: number;
  level: number;
  specialty: string;
  practiceYear: number;
  polStatus: string;
  education: string;
  resume: string;
  phone: string;
  email: string;
  sortOrder: number;
  status: number;
}

export interface DynamicSchedule {
  id: number;
  scheduleId: number;
  doctorId: number;
  scheduleDate: string;
  timeSlot: string;
  period: string;
  totalQuota: number;
  remainingQuota: number;
  status: number;
}

export interface Appointment {
  id: number;
  userId: number;
  patientId: number;
  deptId: number;
  doctorId: number;
  scheduleId: number;
  type: number;
  appointmentTime: string;
  fee: number;
  status: number;
  cancelTime: string;
  checkinTime: string;
  createTime: string;
}

export interface VisitRecord {
  id: number;
  appointmentId: number;
  patientId: number;
  doctorId: number;
  visitDate: string;
  diagnosis: string;
  prescription: string;
  remarks: string;
  createTime: string;
}

export class UserStore {
  static userId: number = 0;
  static userName: string = '';
  static phone: string = '';
}
