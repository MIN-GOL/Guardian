// 用户设置
export const USER_SETTING = 'USER_SETTING'

// 登录信息
export const LOGIN_INFO = 'LOGIN_INFO'

/** 登录响应 */
export interface LoginInfoResponse {
  /** 访问token */
  accessToken?: string;

  /** 头像 */
  avatar?: string;

  /** 昵称 */
  nickname?: string;

  /** 续期token */
  renewalToken?: string;
}
