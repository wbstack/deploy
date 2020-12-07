{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "mediawiki.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "mediawiki.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "mediawiki.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "mediawiki.labels" -}}
app.kubernetes.io/name: {{ include "mediawiki.name" . }}
helm.sh/chart: {{ include "mediawiki.chart" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Common deployment environment variables
*/}}
{{- define "mediawiki.env" -}}
- name: MW_DB_SERVER_MASTER
  value: {{ .Values.mw.db.master }}
- name: MW_DB_SERVER_REPLICA
  value: {{ .Values.mw.db.replica }}
- name: MW_REDIS_SERVER_READ
  value: {{ .Values.mw.redis.readServer }}
- name: MW_REDIS_SERVER_WRITE
  value: {{ .Values.mw.redis.writeServer }}
- name: MW_REDIS_PASSWORD
  value: {{ .Values.mw.redis.password }}
- name: MW_MAILGUN_API_KEY
  value: {{ .Values.mw.mailgun.apikey }}
- name: MW_MAILGUN_DOMAIN
  value: {{ .Values.mw.mailgun.domain }}
- name: MW_EMAIL_DOMAIN
  value: {{ .Values.mw.mailgun.domain }}
- name: MW_RECAPTCHA_SITEKEY
  value: {{ .Values.mw.recaptcha.sitekey }}
- name: MW_RECAPTCHA_SECRETKEY
  value: {{ .Values.mw.recaptcha.secretkey }}
- name: PLATFORM_API_BACKEND_HOST
  value: {{ .Values.mw.platform.apiBackendHost }}
{{- end -}}

{{/*
Common deployment probes
*/}}
{{- define "mediawiki.probes" -}}
livenessProbe:
  httpGet:
    path: /w/health.php
    port: http
readinessProbe:
  httpGet:
    path: /w/health.php
    port: http
{{- end -}}
