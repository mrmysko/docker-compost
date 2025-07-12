<?php
return array (
  'environment' => 'production',
  'salt' => getenv('SALT'),
  'base_url' => getenv('BASE_URL'),
  'auto_update_url' => 'https://update.freshrss.org',
  'language' => 'en',
  'title' => 'FreshRSS',
  'meta_description' => '',
  'logo_html' => '',
  'default_user' => getenv('DEFAULT_USER'),
  'force_email_validation' => false,
  'allow_anonymous' => false,
  'allow_anonymous_refresh' => false,
  'auth_type' => 'http_auth',
  'http_auth_auto_register' => false,
  'http_auth_auto_register_email_field' => '',
  'api_enabled' => true,
  'unsafe_autologin_enabled' => false,
  'simplepie_syslog_enabled' => true,
  'pubsubhubbub_enabled' => true,
  'allow_robots' => false,
  'allow_referrer' => false,
  'nb_parallel_refresh' => 10,
  'limits' => 
  array (
    'cookie_duration' => 172800,
    'cache_duration' => 800,
    'cache_duration_min' => 60,
    'cache_duration_max' => 86400,
    'timeout' => 20,
    'max_inactivity' => 9223372036854775807,
    'max_feeds' => 600,
    'max_categories' => 100,
    'max_registrations' => 1,
  ),
  'curl_options' => 
  array (
  ),
  'db' => 
  array (
    'type' => getenv('DB_TYPE'),
    'host' => getenv('DB_HOST'),
    'user' => getenv('DB_USER'),
    'password' => getenv('DB_PASSWORD'),
    'base' => 'freshrss',
    'prefix' => 'rss_',
    'connection_uri_params' => '',
    'pdo_options' => 
    array (
      1009 => getenv('CA_CERT'),
      1014 => true,
    ),
  ),
  'mailer' => 'mail',
  'smtp' => 
  array (
    'hostname' => '',
    'host' => 'localhost',
    'port' => 25,
    'auth' => false,
    'auth_type' => '',
    'username' => '',
    'password' => '',
    'secure' => '',
    'from' => 'root@localhost',
  ),
  'extensions_enabled' => 
  array (
  ),
  'extensions' => 
  array (
  ),
  'disable_update' => true,
  'trusted_sources' => 
  array (
    0 => '127.0.0.0/8',
    1 => '::1/128',
  ),
);