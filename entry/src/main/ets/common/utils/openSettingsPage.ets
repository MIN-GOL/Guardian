import { bundleManager, common } from '@kit.AbilityKit';

// 拉起设置应用的指定页面
export function openSettingsPage(uri: SettingPageUri) {
  // 获取上下文
  const context = getContext() as common.UIAbilityContext
  // 获取包信息
  const bundleInfo = bundleManager.getBundleInfoForSelfSync(bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_APPLICATION)
  // 打开 ability
  context.startAbility({
    bundleName: 'com.huawei.hmos.settings',
    abilityName: 'com.huawei.hmos.settings.MainAbility',
    uri: uri,
    parameters: {
      // 自动获取包名
      pushParams: bundleInfo.name
    }
  })
}

type SettingPageUri = | '/'
  | 'wifi_entry'
  | 'bluetooth_entry'
  | 'mobile_network_entry'
  | 'hotspot_data_settings'
  | 'password_entry'
  | 'connected_device_entry'
  | 'more_share_entry'
  | 'more_connections_settings'
  | 'nfc_settings'
  | 'display_settings'
  | 'screen_zoom'
  | 'screen_refresh_rate_entry'
  | 'volume_settings'
  | 'systemui_notification_settings'
  | 'accessibility_feature'
  | 'accessibility_operation_entry'
  | 'accessibility_more_settings_entry'
  | 'application_and_service_settings'
  | 'application_settings'
  | 'application_info_entry'
  | 'storage_settings'
  | 'battery'
  | 'biometrics_and_password_settings'
  | 'lock_screen_password_title'
  | 'change_six_to_number_entry'
  | 'change_six_to_mixed_entry'
  | 'fingerprint_settings_entry'
  | 'privacy_settings'
  | 'location_help_entry'
  | 'users_accounts'
  | 'current_user'
  | 'system_and_updates'
  | 'time_zone_settings'
  | 'date_and_time'
  | 'set_language'
  | 'set_language_region'
  | 'reset_settings'
  | 'developer_options_settings'
  | 'edit_language_entry'
  | 'add_language_entry'
  | 'select_region_entry'
  | 'reset_factory_settings'
  | 'reset_net_settings'
  | 'reset_confirm_settings'
  | 'reset_net_confirm_settings'
  | 'about_device'
  | 'device_name'