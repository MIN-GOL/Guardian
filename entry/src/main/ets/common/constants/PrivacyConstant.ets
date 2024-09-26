// 隐私空间设置
export const PRIVACY_SETTINGS = 'PRIVACY_SETTINGS'

// 隐私空间设置类型
export interface PrivacySettings {
  patternPassword?: string     // 图案锁密码
  isOpenUserAuthLock?: boolean // 是否启用指纹或面容ID解锁
  protectQuestionIndex?: number // 密保问题下标
  protectQuestionAnswer?: string // 密保问题答案
  isOpenAntiCracking?: boolean // 是否开启防破解
  antiCrackingLastFailedTimeStamp?: number // 上次失败尝试时间戳
}

/** 密保问题 */
export const PRIVACY_QUESTION_LIST: SelectOption[] = [
  { value: '高中时最好的朋友叫什么？' },
  { value: '你养的第一只宠物的名字是什么？' },
  { value: '你学会做的第一道菜是什么？' },
  { value: '第一次乘飞机是去哪里？' },
  { value: '你最喜欢的小学老师是谁？' },
  { value: '最理想的工作是什么？' },
  { value: '小时候最喜欢哪本书？' },
  { value: '你的第一个老板是谁？' },
  { value: '你最喜欢的电影明星是谁？' },
  { value: '你的父母是在哪里相遇的？' },
]

// 隐私图片的沙箱文件夹
export const PRIVACY_PHOTO_FOLDER = 'privacy_photo'

// 隐私图片的沙箱文件夹
export const PRIVACY_RECORDER_FOLDER = 'privacy_recorder'

// 隐私图片的沙箱文件夹
export const PRIVACY_NOTE_FOLDER = 'privacy_note'

// 隐私密码本的沙箱文件夹
export const PRIVACY_CODEBOOK_FOLDER = 'privacy_codebook'