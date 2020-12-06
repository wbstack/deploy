resource "google_monitoring_uptime_check_config" "tfer--projects-002F-wbstack-002F-uptimeCheckConfigs-002F-addshore-002D-alpha-002D-query-002D-service-002D-ui" {
  content_matchers {
    content = "query-helper-help"
    matcher = "CONTAINS_STRING"
  }

  display_name = "addshore-alpha Query Service UI"

  http_check {
    mask_headers   = "false"
    path           = "/query/"
    port           = "443"
    request_method = "GET"
    use_ssl        = "true"
    validate_ssl   = "true"
  }

  monitored_resource {
    labels = {
      host       = "addshore-alpha.wiki.opencura.com"
      project_id = "wbstack"
    }

    type = "uptime_url"
  }

  period  = "300s"
  project = "wbstack"
  timeout = "10s"
}

resource "google_monitoring_uptime_check_config" "tfer--projects-002F-wbstack-002F-uptimeCheckConfigs-002F-addshore-002D-alpha-002D-sparql-002D-query" {
  content_matchers {
    content = "<literal xml:lang='en'>UptimeCheck</literal>"
    matcher = "CONTAINS_STRING"
  }

  display_name = "addshore-alpha SPARQL query"

  http_check {
    mask_headers   = "false"
    path           = "/query/sparql?query=SELECT%20*%20WHERE%20%7B%20<http%3A%2F%2Faddshore-alpha.wiki.opencura.com%2Fentity%2FQ6>%20%3Fb%20%3Fc%20%7D#SELECT%20%3FdateModified%20WHERE%20%7B%20<http%3A%2F%2Faddshore-alpha.wiki.opencura.com%2Fentity%2FQ6>%20schema%3AdateModified%20%3FdateModified%20%7D"
    port           = "443"
    request_method = "GET"
    use_ssl        = "true"
    validate_ssl   = "true"
  }

  monitored_resource {
    labels = {
      host       = "addshore-alpha.wiki.opencura.com"
      project_id = "wbstack"
    }

    type = "uptime_url"
  }

  period  = "300s"
  project = "wbstack"
  timeout = "60s"
}

resource "google_monitoring_uptime_check_config" "tfer--projects-002F-wbstack-002F-uptimeCheckConfigs-002F-addshore-002D-alpha-002D-toosl-002D-quickstatements" {
  content_matchers {
    content = "wmflabs.org"
    matcher = "CONTAINS_STRING"
  }

  display_name = "addshore-alpha Tools Quickstatements"

  http_check {
    mask_headers   = "false"
    path           = "/tools/quickstatements/"
    port           = "443"
    request_method = "GET"
    use_ssl        = "true"
    validate_ssl   = "true"
  }

  monitored_resource {
    labels = {
      host       = "addshore-alpha.wiki.opencura.com"
      project_id = "wbstack"
    }

    type = "uptime_url"
  }

  period  = "300s"
  project = "wbstack"
  timeout = "10s"
}

resource "google_monitoring_uptime_check_config" "tfer--projects-002F-wbstack-002F-uptimeCheckConfigs-002F-addshore-002D-alpha-002D-wiki-002D-opencura-002D-com-002D-wiki-002D-main-002D-page" {
  content_matchers {
    content = "7syaf98afusaufusa98ufa"
    matcher = "CONTAINS_STRING"
  }

  display_name = "addshore-alpha MediaWiki UptimeCheck Page"

  http_check {
    mask_headers   = "false"
    path           = "/wiki/UptimeCheck"
    port           = "443"
    request_method = "GET"
    use_ssl        = "true"
    validate_ssl   = "true"
  }

  monitored_resource {
    labels = {
      host       = "addshore-alpha.wiki.opencura.com"
      project_id = "wbstack"
    }

    type = "uptime_url"
  }

  period  = "60s"
  project = "wbstack"
  timeout = "30s"
}

resource "google_monitoring_uptime_check_config" "tfer--projects-002F-wbstack-002F-uptimeCheckConfigs-002F-https-002D-addshore-002D-alpha-002D-wiki-002D-opencura-002D-com-002D-w-002D-api-002D-php-002D-action-002D-query-002D-format-002D-json-002D-maxlag-002D-5-002D-1577092431" {
  content_matchers {
    content = "maxlag"
    matcher = "NOT_CONTAINS_STRING"
  }

  display_name = "addshore-alpha MediaWiki API maxlag check"

  http_check {
    mask_headers   = "false"
    path           = "/w/api.php?action=query\u0026format=json\u0026maxlag=5"
    port           = "443"
    request_method = "GET"
    use_ssl        = "true"
    validate_ssl   = "true"
  }

  monitored_resource {
    labels = {
      host       = "addshore-alpha.wiki.opencura.com"
      project_id = "wbstack"
    }

    type = "uptime_url"
  }

  period  = "300s"
  project = "wbstack"
  timeout = "30s"
}

resource "google_monitoring_uptime_check_config" "tfer--projects-002F-wbstack-002F-uptimeCheckConfigs-002F-www-002D-wbstack-002D-com" {
  display_name = "www.wbstack.com"

  http_check {
    mask_headers   = "false"
    path           = "/"
    port           = "443"
    request_method = "GET"
    use_ssl        = "true"
    validate_ssl   = "true"
  }

  monitored_resource {
    labels = {
      host       = "www.wbstack.com"
      project_id = "wbstack"
    }

    type = "uptime_url"
  }

  period  = "60s"
  project = "wbstack"
  timeout = "10s"
}
