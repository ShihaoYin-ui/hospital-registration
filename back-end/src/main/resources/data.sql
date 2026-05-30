-- ==========================================
-- 云医院挂号系统 - 完整测试数据 (每表≥20条)
-- 运行前确保已创建数据库和表结构
-- ==========================================

SET FOREIGN_KEY_CHECKS = 0;

TRUNCATE visit_record;
TRUNCATE appointment;
TRUNCATE dynamic_schedule;
TRUNCATE fee_config;
TRUNCATE fixed_schedule;
TRUNCATE doctor;
TRUNCATE department;
TRUNCATE `type`;
TRUNCATE patient;
TRUNCATE user;

SET FOREIGN_KEY_CHECKS = 1;

    -- ==================== 先清空相关表（按依赖顺序） ====================
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE visit_record;
TRUNCATE TABLE appointment;
TRUNCATE TABLE dynamic_schedule;
TRUNCATE TABLE fixed_schedule;
TRUNCATE TABLE fee_config;
TRUNCATE TABLE doctor;
TRUNCATE TABLE patient;
TRUNCATE TABLE department;
TRUNCATE TABLE type;
TRUNCATE TABLE user;
SET FOREIGN_KEY_CHECKS = 1;

-- ==================== 1. 科室类型表 ====================
INSERT INTO type (id, code, name, parent_id, sort_order, status) VALUES
                                                                     (1, 'DEPT_TYPE_01', '内科系统', NULL, 1, 1),
                                                                     (2, 'DEPT_TYPE_02', '外科系统', NULL, 2, 1),
                                                                     (3, 'DEPT_TYPE_03', '妇产科系统', NULL, 3, 1),
                                                                     (4, 'DEPT_TYPE_04', '儿科系统', NULL, 4, 1),
                                                                     (5, 'DEPT_TYPE_05', '五官科', NULL, 5, 1),
                                                                     (6, 'DEPT_TYPE_06', '口腔科', NULL, 6, 1),
                                                                     (7, 'DEPT_TYPE_07', '皮肤科', NULL, 7, 1),
                                                                     (8, 'DEPT_TYPE_08', '中医科', NULL, 8, 1),
                                                                     (9, 'DEPT_TYPE_09', '康复科', NULL, 9, 1),
                                                                     (10, 'DEPT_TYPE_10', '急诊科', NULL, 10, 1);

-- ==================== 2. 科室表（精简版，便于测试）====================
INSERT INTO department (id, code, name, type_id, level, intro, leader_id, phone, location, sort_order, status) VALUES
                                                                                                                   (1, 'DEPT_01', '心血管内科', 1, 2, '心血管疾病诊疗中心', NULL, '010-12340001', '1号楼2层', 1, 1),
                                                                                                                   (2, 'DEPT_02', '消化内科', 1, 2, '消化系统疾病诊疗', NULL, '010-12340002', '1号楼3层', 2, 1),
                                                                                                                   (3, 'DEPT_03', '普通外科', 2, 2, '普外手术中心', NULL, '010-12340003', '2号楼1层', 1, 1),
                                                                                                                   (4, 'DEPT_04', '骨科', 2, 2, '关节脊柱微创治疗', NULL, '010-12340004', '2号楼2层', 2, 1),
                                                                                                                   (5, 'DEPT_05', '妇科', 3, 2, '妇科肿瘤微创手术', NULL, '010-12340005', '3号楼1层', 1, 1),
                                                                                                                   (6, 'DEPT_06', '产科', 3, 2, '高危孕产妇救治中心', NULL, '010-12340006', '3号楼2层', 2, 1),
                                                                                                                   (7, 'DEPT_07', '小儿内科', 4, 2, '儿童疾病诊疗', NULL, '010-12340007', '5号楼1层', 1, 1),
                                                                                                                   (8, 'DEPT_08', '眼科', 5, 2, '眼病诊疗', NULL, '010-12340008', '6号楼1层', 1, 1),
                                                                                                                   (9, 'DEPT_09', '耳鼻喉科', 5, 2, '耳鼻咽喉疾病', NULL, '010-12340009', '6号楼2层', 2, 1),
                                                                                                                   (10, 'DEPT_10', '皮肤科', 7, 2, '皮肤病性病诊疗', NULL, '010-12340010', '8号楼1层', 1, 1);

-- ==================== 3. 用户表 ====================
INSERT INTO user (id, id_number, name, gender, birth_date, phone, native_place, address, email, password, status) VALUES
                                                                                                                      (1, '11010119900307663X', '张明', '男', '1990-03-07', '13800000001', '北京市', '北京市朝阳区', 'zhangming@example.com', 'e10adc3949ba59abbe56e057f20f883e', 1),
                                                                                                                      (2, '110101198505129021', '李芳', '女', '1985-05-12', '13800000002', '上海市', '上海市浦东新区', 'lifang@example.com', 'e10adc3949ba59abbe56e057f20f883e', 1);

-- ==================== 4. 就诊人表 ====================
INSERT INTO patient (id, user_id, name, gender, id_number, phone, relationship, is_default, create_time) VALUES
                                                                                                             (1, 1, '张明', '男', '11010119900307663X', '13800000001', '本人', '1', NOW()),
                                                                                                             (2, 1, '张建国', '男', '110101196505127012', '13800000011', '父亲', '0', NOW()),
                                                                                                             (3, 2, '李芳', '女', '110101198505129021', '13800000002', '本人', '1', NOW());

-- ==================== 5. 医生表（ID从100开始，避免冲突）====================
INSERT INTO doctor (id, code, name, gender, birth_date, dept_id, title, level, specialty, practice_year, pol_status, education, resume, phone, email, sort_order, status) VALUES
-- 心血管内科 (dept_id=1)
(100, 'DOC0101', '陈敏华', '女', '1975-06-15', 1, 3, 2, '冠心病介入治疗', 25, '主任医师', '博士', '擅长冠状动脉支架植入术', '13901010001', 'chenmh@hospital.com', 1, 1),
(101, 'DOC0102', '孙建国', '男', '1982-09-20', 1, 2, 2, '心力衰竭', 15, '副主任医师', '硕士', '擅长难治性心衰综合治疗', '13901010002', 'sunjg@hospital.com', 2, 1),
-- 消化内科 (dept_id=2)
(102, 'DOC0201', '李卫东', '男', '1978-03-10', 2, 3, 2, '消化道早癌内镜治疗', 20, '主任医师', '博士', '擅长ESD内镜下微创手术', '13901020001', 'liwd@hospital.com', 1, 1),
(103, 'DOC0202', '王雅茹', '女', '1985-11-02', 2, 2, 2, '炎症性肠病', 12, '副主任医师', '硕士', '擅长克罗恩病诊治', '13901020002', 'wangyr@hospital.com', 2, 1),
-- 普通外科 (dept_id=3)
(104, 'DOC0301', '张伟', '男', '1970-12-01', 3, 4, 3, '肝胆胰外科', 30, '主任医师', '博士', '擅长腹腔镜肝切除', '13901030001', 'zhangw@hospital.com', 1, 1),
(105, 'DOC0302', '刘志远', '男', '1980-07-19', 3, 3, 2, '胃肠肿瘤外科', 18, '主任医师', '博士', '擅长胃癌根治手术', '13901030002', 'liuzy@hospital.com', 2, 1),
-- 骨科 (dept_id=4)
(106, 'DOC0401', '王建国', '男', '1976-02-28', 4, 3, 2, '关节外科', 22, '主任医师', '博士', '擅长髋膝关节置换', '13901040001', 'wangjg@hospital.com', 1, 1),
(107, 'DOC0402', '周明', '男', '1983-08-14', 4, 2, 2, '脊柱外科', 14, '副主任医师', '硕士', '擅长椎间孔镜手术', '13901040002', 'zhoum@hospital.com', 2, 1),
-- 妇科 (dept_id=5)
(108, 'DOC0501', '刘芳', '女', '1974-11-30', 5, 3, 2, '妇科肿瘤', 26, '主任医师', '博士', '擅长卵巢癌根治手术', '13901050001', 'liuf@hospital.com', 1, 1),
(109, 'DOC0502', '赵丽华', '女', '1981-05-21', 5, 2, 2, '妇科微创', 16, '副主任医师', '硕士', '擅长宫腹腔镜手术', '13901050002', 'zhaolh@hospital.com', 2, 1),
-- 产科 (dept_id=6)
(110, 'DOC0601', '李秀英', '女', '1979-09-09', 6, 3, 2, '高危妊娠管理', 20, '主任医师', '博士', '擅长妊娠期高血压管理', '13901060001', 'lixy@hospital.com', 1, 1),
-- 小儿内科 (dept_id=7)
(111, 'DOC0701', '陈晓东', '男', '1980-03-03', 7, 3, 2, '小儿呼吸', 18, '主任医师', '硕士', '擅长儿童哮喘诊治', '13901070001', 'chenxd@hospital.com', 1, 1),
-- 眼科 (dept_id=8)
(112, 'DOC0801', '张晓东', '男', '1982-07-07', 8, 2, 2, '白内障', 15, '副主任医师', '硕士', '擅长白内障超声乳化手术', '13901080001', 'zhangxd@hospital.com', 1, 1),
-- 耳鼻喉科 (dept_id=9)
(113, 'DOC0901', '韩冰', '男', '1975-08-08', 9, 3, 2, '鼻科', 23, '主任医师', '博士', '擅长鼻内镜手术', '13901090001', 'hanb@hospital.com', 1, 1),
-- 皮肤科 (dept_id=10)
(114, 'DOC1001', '黄建国', '男', '1978-11-11', 10, 3, 2, '银屑病', 20, '主任医师', '博士', '擅长银屑病生物制剂治疗', '13901100001', 'huangjg@hospital.com', 1, 1);

-- ==================== 6. 固定排班表（使用正确的医生ID）====================
INSERT INTO fixed_schedule (id, dept_id, doctor_id, time_slot, `period`, week_day, total_quota, fee) VALUES
-- 陈敏华 周一、三、五上午
(1, 1, 100, '08:00-12:00', '上午', 1, 30, 80.00),
(2, 1, 100, '13:30-17:00', '下午', 1, 25, 80.00),
(3, 1, 100, '08:00-12:00', '上午', 3, 30, 80.00),
(4, 1, 100, '08:00-12:00', '上午', 5, 30, 80.00),
-- 孙建国 周二、四全天
(5, 1, 101, '08:00-12:00', '上午', 2, 30, 60.00),
(6, 1, 101, '13:30-17:00', '下午', 2, 25, 60.00),
(7, 1, 101, '08:00-12:00', '上午', 4, 30, 60.00),
(8, 1, 101, '13:30-17:00', '下午', 4, 25, 60.00),
-- 李卫东 周一、三、五上午
(9, 2, 102, '08:00-12:00', '上午', 1, 30, 80.00),
(10, 2, 102, '08:00-12:00', '上午', 3, 30, 80.00),
(11, 2, 102, '08:00-12:00', '上午', 5, 30, 80.00),
-- 张伟 周一、三、五上午
(12, 3, 104, '08:00-12:00', '上午', 1, 25, 120.00),
(13, 3, 104, '08:00-12:00', '上午', 3, 25, 120.00),
(14, 3, 104, '08:00-12:00', '上午', 5, 25, 120.00),
-- 刘芳 周一、三、五上午
(15, 5, 108, '08:00-12:00', '上午', 1, 30, 90.00),
(16, 5, 108, '08:00-12:00', '上午', 3, 30, 90.00),
(17, 5, 108, '08:00-12:00', '上午', 5, 30, 90.00),
-- 李秀英 周二、四上午
(18, 6, 110, '08:00-12:00', '上午', 2, 25, 80.00),
(19, 6, 110, '08:00-12:00', '上午', 4, 25, 80.00),
-- 陈晓东 周二、四全天
(20, 7, 111, '08:00-12:00', '上午', 2, 30, 60.00),
(21, 7, 111, '13:30-17:00', '下午', 2, 25, 60.00),
(22, 7, 111, '08:00-12:00', '上午', 4, 30, 60.00),
(23, 7, 111, '13:30-17:00', '下午', 4, 25, 60.00);

-- ==================== 7. 动态排班表（一周数据，2026-05-30 至 2026-06-07）====================
INSERT INTO dynamic_schedule (schedule_id, doctor_id, schedule_date, time_slot, `period`, total_quota, remaining_quota, status)
SELECT
    fs.id,
    fs.doctor_id,
    DATE_ADD('2026-05-30', INTERVAL (fs.week_day - 1) DAY) AS schedule_date,
    fs.time_slot,
    fs.period,
    fs.total_quota,
    fs.total_quota,
    1
FROM fixed_schedule fs
WHERE fs.week_day BETWEEN 1 AND 5
  AND DATE_ADD('2026-05-30', INTERVAL (fs.week_day - 1) DAY) <= '2026-06-07';

-- ==================== 8. 验证数据 ====================
-- 查看周一（2026-06-01）的排班，确认能看到医生信息
SELECT
    ds.id,
    ds.schedule_date,
    ds.time_slot,
    ds.period,
    ds.total_quota,
    ds.remaining_quota,
    d.id AS doctor_id,
    d.name AS doctor_name,
    d.title,
    d.specialty,
    dept.name AS dept_name,
    fs.fee
FROM dynamic_schedule ds
         JOIN doctor d ON ds.doctor_id = d.id
         JOIN department dept ON d.dept_id = dept.id
         JOIN fixed_schedule fs ON ds.schedule_id = fs.id
WHERE ds.schedule_date = '2026-06-01'
  AND ds.status = 1
ORDER BY ds.time_slot;