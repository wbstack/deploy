resource "google_monitoring_alert_policy" "tfer--projects-002F-wbstack-002F-alertPolicies-002F-14657974770943482131" {
  combiner = "OR"

  conditions {
    condition_threshold {
      aggregations {
        alignment_period     = "60s"
        cross_series_reducer = "REDUCE_SUM"
        group_by_fields      = ["resource.label.container_name"]
        per_series_aligner   = "ALIGN_RATE"
      }

      comparison      = "COMPARISON_GT"
      duration        = "600s"
      filter          = "metric.type=\"logging.googleapis.com/byte_count\" resource.type=\"k8s_container\" resource.label.\"project_id\"=\"wbstack\" resource.label.\"cluster_name\"=\"cluster-1\""
      threshold_value = "25000"

      trigger {
        count   = "1"
        percent = "0"
      }
    }

    display_name = "Log bytes for wbstack, cluster-1 by label.container_name [SUM]"
  }

  conditions {
    condition_threshold {
      aggregations {
        alignment_period     = "60s"
        cross_series_reducer = "REDUCE_SUM"
        group_by_fields      = ["resource.label.project_id"]
        per_series_aligner   = "ALIGN_RATE"
      }

      comparison      = "COMPARISON_GT"
      duration        = "600s"
      filter          = "metric.type=\"logging.googleapis.com/byte_count\" resource.type=\"k8s_container\" resource.label.\"cluster_name\"=\"cluster-1\" resource.label.\"project_id\"=\"wbstack\""
      threshold_value = "40000"

      trigger {
        count   = "1"
        percent = "0"
      }
    }

    display_name = "Log bytes for cluster-1, wbstack, all services, [SUM]"
  }

  display_name          = "Log bytes for wbstack, cluster-1 too high for 10 mins"
  enabled               = "true"
  notification_channels = ["projects/wbstack/notificationChannels/15581505725416829869", "projects/wbstack/notificationChannels/4385531164912670587"]
  project               = "wbstack"
}

resource "google_monitoring_alert_policy" "tfer--projects-002F-wbstack-002F-alertPolicies-002F-15878296207558158764" {
  combiner = "OR"

  conditions {
    condition_threshold {
      aggregations {
        alignment_period     = "1200s"
        cross_series_reducer = "REDUCE_COUNT_FALSE"
        group_by_fields      = ["resource.*"]
        per_series_aligner   = "ALIGN_NEXT_OLDER"
      }

      comparison      = "COMPARISON_GT"
      duration        = "120s"
      filter          = "metric.type=\"monitoring.googleapis.com/uptime_check/check_passed\" resource.type=\"uptime_url\" metric.label.\"check_id\"=\"www-wbstack-com\""
      threshold_value = "1"

      trigger {
        count   = "1"
        percent = "0"
      }
    }

    display_name = "Check passed for www-wbstack-com by * [COUNT FALSE]"
  }

  display_name = "Uptime Checks www.wbstack.com"

  documentation {
    content   = "Notify me if the main site goes down"
    mime_type = "text/markdown"
  }

  enabled               = "true"
  notification_channels = ["projects/wbstack/notificationChannels/15581505725416829869", "projects/wbstack/notificationChannels/4385531164912670587"]
  project               = "wbstack"
}

resource "google_monitoring_alert_policy" "tfer--projects-002F-wbstack-002F-alertPolicies-002F-5675359594189485038" {
  combiner = "OR"

  conditions {
    condition_threshold {
      aggregations {
        alignment_period   = "60s"
        per_series_aligner = "ALIGN_RATE"
      }

      comparison      = "COMPARISON_GT"
      duration        = "60s"
      filter          = "metric.type=\"logging.googleapis.com/user/wbstack.platform.queue.job.failure\""
      threshold_value = "0"

      trigger {
        count   = "1"
        percent = "0"
      }
    }

    display_name = "logging/user/wbstack.platform.queue.job.failure"
  }

  display_name          = "Platform Job Failures"
  enabled               = "true"
  notification_channels = ["projects/wbstack/notificationChannels/15581505725416829869", "projects/wbstack/notificationChannels/4385531164912670587"]
  project               = "wbstack"
}

resource "google_monitoring_alert_policy" "tfer--projects-002F-wbstack-002F-alertPolicies-002F-7421219913163345211" {
  combiner = "OR"

  conditions {
    condition_threshold {
      aggregations {
        alignment_period     = "1200s"
        cross_series_reducer = "REDUCE_COUNT_FALSE"
        group_by_fields      = ["resource.*"]
        per_series_aligner   = "ALIGN_NEXT_OLDER"
      }

      comparison      = "COMPARISON_GT"
      duration        = "120s"
      filter          = "metric.type=\"monitoring.googleapis.com/uptime_check/check_passed\" resource.type=\"uptime_url\" metric.label.\"check_id\"=\"addshore-alpha-wiki-opencura-com-wiki-main-page\""
      threshold_value = "1"

      trigger {
        count   = "1"
        percent = "0"
      }
    }

    display_name = "Uptime Health Check on addshore-alpha MediaWiki UptimeCheck Page"
  }

  conditions {
    condition_threshold {
      aggregations {
        alignment_period     = "1200s"
        cross_series_reducer = "REDUCE_COUNT_FALSE"
        group_by_fields      = ["resource.*"]
        per_series_aligner   = "ALIGN_NEXT_OLDER"
      }

      comparison      = "COMPARISON_GT"
      duration        = "120s"
      filter          = "metric.type=\"monitoring.googleapis.com/uptime_check/check_passed\" resource.type=\"uptime_url\" metric.label.\"check_id\"=\"https-addshore-alpha-wiki-opencura-com-w-api-php-action-query-format-json-maxlag-5-1577092431\""
      threshold_value = "1"

      trigger {
        count   = "1"
        percent = "0"
      }
    }

    display_name = "Uptime Health Check on addshore-alpha MediaWiki API maxlag check"
  }

  conditions {
    condition_threshold {
      aggregations {
        alignment_period     = "1200s"
        cross_series_reducer = "REDUCE_COUNT_FALSE"
        group_by_fields      = ["resource.*"]
        per_series_aligner   = "ALIGN_NEXT_OLDER"
      }

      comparison      = "COMPARISON_GT"
      duration        = "120s"
      filter          = "metric.type=\"monitoring.googleapis.com/uptime_check/check_passed\" resource.type=\"uptime_url\" metric.label.\"check_id\"=\"addshore-alpha-sparql-query\""
      threshold_value = "1"

      trigger {
        count   = "1"
        percent = "0"
      }
    }

    display_name = "Uptime Health Check on addshore-alpha SPARQL query"
  }

  conditions {
    condition_threshold {
      aggregations {
        alignment_period     = "1200s"
        cross_series_reducer = "REDUCE_COUNT_FALSE"
        group_by_fields      = ["resource.*"]
        per_series_aligner   = "ALIGN_NEXT_OLDER"
      }

      comparison      = "COMPARISON_GT"
      duration        = "120s"
      filter          = "metric.type=\"monitoring.googleapis.com/uptime_check/check_passed\" resource.type=\"uptime_url\" metric.label.\"check_id\"=\"addshore-alpha-query-service-ui\""
      threshold_value = "1"

      trigger {
        count   = "1"
        percent = "0"
      }
    }

    display_name = "Uptime Health Check on addshore-alpha Query Service UI"
  }

  conditions {
    condition_threshold {
      aggregations {
        alignment_period     = "1200s"
        cross_series_reducer = "REDUCE_COUNT_FALSE"
        group_by_fields      = ["resource.*"]
        per_series_aligner   = "ALIGN_NEXT_OLDER"
      }

      comparison      = "COMPARISON_GT"
      duration        = "120s"
      filter          = "metric.type=\"monitoring.googleapis.com/uptime_check/check_passed\" resource.type=\"uptime_url\" metric.label.\"check_id\"=\"addshore-alpha-toosl-quickstatements\""
      threshold_value = "1"

      trigger {
        count   = "1"
        percent = "0"
      }
    }

    display_name = "Uptime Health Check on addshore-alpha Tools Quickstatements"
  }

  display_name          = "Uptime Checks addshore-alpha"
  enabled               = "true"
  notification_channels = ["projects/wbstack/notificationChannels/15581505725416829869", "projects/wbstack/notificationChannels/4385531164912670587"]
  project               = "wbstack"
}
