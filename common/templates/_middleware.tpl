{{/* vim: set filetype=mustache: */}}

{{/*
Return the proper mysql host
{{ include "common.middleware.mysql.host" . }}
*/}}
{{- define "common.middleware.mysql.host" }}
{{- if .Values.mysql }}
   {{- if .Values.mysql.host }}
      {{- .Values.mysql.host }}
   {{- else if .Values.global.mysql }}
      {{- .Values.global.mysql.host }}
   {{- end }}
{{- else if .Values.global.mysql }}
   {{- .Values.global.mysql.host }}
{{- end }}
{{- end }}

{{/*
Return the proper mysql port
{{ include "common.middleware.mysql.port" . }}
*/}}
{{- define "common.middleware.mysql.port" }}
{{- if .Values.mysql }}
  {{- if .Values.mysql.port }}
    {{- .Values.mysql.port }}
  {{- else if .Values.global.mysql }}
    {{- .Values.global.mysql.port }}
  {{- end }}
{{- else if .Values.global.mysql }}
   {{- .Values.global.mysql.port }}
{{- end }}
{{- end }}

{{/*
Return the proper mysql username
{{ include "common.middleware.mysql.username" . }}
*/}}
{{- define "common.middleware.mysql.username" }}
{{- if .Values.auth }}
   {{- if .Values.auth.mysql }}
      {{- if .Values.auth.mysql.username }}
        {{- .Values.auth.mysql.username }}
      {{- else }}
        {{- .Values.global.auth.mysql.username }}
      {{- end }}
   {{- else }}
      {{- .Values.global.auth.mysql.username }}
   {{- end }}
{{- else if .Values.global.auth.mysql }}
   {{- .Values.global.auth.mysql.username }}
{{- end }}
{{- end }}

{{/*
Return the proper mysql password
{{ include "common.middleware.mysql.password" . }}
*/}}
{{- define "common.middleware.mysql.password" }}
{{- if .Values.auth }}
   {{- if .Values.auth.mysql }}
      {{- if .Values.auth.mysql.password }}
        {{- .Values.auth.mysql.password }}
      {{- else }}
        {{- .Values.global.auth.mysql.password }}
      {{- end }}
   {{- else }}
      {{- .Values.global.auth.mysql.password }}
   {{- end }}
{{- else if .Values.global.auth.mysql }}
   {{- .Values.global.auth.mysql.password }}
{{- end }}
{{- end }}

{{/*
Return the proper mongodb host
{{ include "common.middleware.mongodb.host" . }}
*/}}
{{- define "common.middleware.mongodb.host" }}
{{- if .Values.mongodb }}
   {{- if .Values.mongodb.host }}
      {{- .Values.mongodb.host }}
   {{- else if .Values.global.mongodb }}
      {{- .Values.global.mongodb.host }}
   {{- end }}
{{- else if .Values.global.mongodb }}
   {{- .Values.global.mongodb.host }}
{{- end }}
{{- end }}

{{/*
Return the proper mongodb port
{{ include "common.middleware.mongodb.port" . }}
*/}}
{{- define "common.middleware.mongodb.port" }}
{{- if .Values.mongodb }}
   {{- if .Values.mongodb.port }}
      {{- .Values.mongodb.port }}
   {{- else if .Values.global.mongodb }}
      {{- .Values.global.mongodb.port }}
   {{- end }}
{{- else if .Values.global.mongodb }}
   {{- .Values.global.mongodb.port }}
{{- end }}
{{- end }}

{{/*
Return the proper mongodb username
{{ include "common.middleware.mongodb.username" . }}
*/}}
{{- define "common.middleware.mongodb.username" }}
{{- if .Values.auth }}
   {{- if .Values.auth.mongodb }}
      {{- if .Values.auth.mongodb.username }}
        {{- .Values.auth.mongodb.username }}
      {{- else }}
        {{- .Values.global.auth.mongodb.username }}
      {{- end }}
   {{- else }}
      {{- .Values.global.auth.mongodb.username }}
   {{- end }}
{{- else if .Values.global.auth.mongodb }}
   {{- .Values.global.auth.mongodb.username }}
{{- end }}
{{- end }}

{{/*
Return the proper mongodb password
{{ include "common.middleware.mongodb.password" . }}
*/}}
{{- define "common.middleware.mongodb.password" }}
{{- if .Values.auth }}
   {{- if .Values.auth.mongodb }}
      {{- if .Values.auth.mongodb.password }}
        {{- .Values.auth.mongodb.password }}
      {{- else }}
        {{- .Values.global.auth.mongodb.password }}
      {{- end }}
   {{- else }}
      {{- .Values.global.auth.mongodb.password }}
   {{- end }}
{{- else if .Values.global.auth.mongodb }}
   {{- .Values.global.auth.mongodb.password }}
{{- end }}
{{- end }}

{{/*
Return the proper rabbitmq host
{{ include "common.middleware.rabbitmq.host" . }}
*/}}
{{- define "common.middleware.rabbitmq.host" }}
{{- if .Values.rabbitmq }}
   {{- if .Values.rabbitmq.host }}
     {{- .Values.rabbitmq.host }}
   {{- else if .Values.global.rabbitmq }}
     {{- .Values.global.rabbitmq.host }}
   {{- end }}
{{- else if .Values.global.rabbitmq }}
   {{- .Values.global.rabbitmq.host }}
{{- end }}
{{- end }}

{{/*
Return the proper rabbitmq port
{{ include "common.middleware.rabbitmq.port" . }}
*/}}
{{- define "common.middleware.rabbitmq.port" }}
{{- if .Values.rabbitmq }}
   {{- if .Values.rabbitmq.port }}
      {{- .Values.rabbitmq.port }}
   {{- else if .Values.global.rabbitmq }}
      {{- .Values.global.rabbitmq.port }}
   {{- end }}
{{- else if .Values.global.rabbitmq }}
   {{- .Values.global.rabbitmq.port }}
{{- end }}
{{- end }}

{{/*
Return the proper rabbitmq management port
{{ include "common.middleware.rabbitmq.managementPort" . }}
*/}}
{{- define "common.middleware.rabbitmq.managementPort" }}
{{- if .Values.rabbitmq }}
   {{- if .Values.rabbitmq.management_port }}
      {{- .Values.rabbitmq.management_port }}
   {{- else if .Values.global.rabbitmq }}
      {{- .Values.global.rabbitmq.management_port }}
   {{- end }}
{{- else if .Values.global.rabbitmq }}
   {{- .Values.global.rabbitmq.management_port }}
{{- end }}
{{- end }}

{{/*
Return the proper rabbitmq username
{{ include "common.middleware.rabbitmq.username" . }}
*/}}
{{- define "common.middleware.rabbitmq.username" }}
{{- if .Values.auth }}
   {{- if .Values.auth.rabbitmq }}
      {{- if .Values.auth.rabbitmq.username }}
        {{- .Values.auth.rabbitmq.username }}
      {{- else }}
        {{- .Values.global.auth.rabbitmq.username }}
      {{- end }}
   {{- else }}
      {{- .Values.global.auth.rabbitmq.username }}
   {{- end }}
{{- else if .Values.global.auth.rabbitmq }}
   {{- .Values.global.auth.rabbitmq.username }}
{{- end }}
{{- end }}

{{/*
Return the proper rabbitmq password
{{ include "common.middleware.rabbitmq.password" . }}
*/}}
{{- define "common.middleware.rabbitmq.password" }}
{{- if .Values.auth }}
   {{- if .Values.auth.rabbitmq }}
      {{- if .Values.auth.rabbitmq.password }}
        {{- .Values.auth.rabbitmq.password }}
      {{- else }}
        {{- .Values.global.auth.rabbitmq.password }}
      {{- end }}
   {{- else }}
      {{- .Values.global.auth.rabbitmq.password }}
   {{- end }}
{{- else if .Values.global.auth.rabbitmq }}
   {{- .Values.global.auth.rabbitmq.password }}
{{- end }}
{{- end }}

{{/*
Return the proper redis host
{{ include "common.middleware.redis.host" . }}
*/}}
{{- define "common.middleware.redis.host" }}
{{- if .Values.redis }}
   {{- if .Values.redis.host }}
      {{- .Values.redis.host }}
   {{- else if .Values.global.redis }}
      {{- .Values.global.redis.host }}
   {{- end }}
{{- else if .Values.global.redis }}
   {{- .Values.global.redis.host }}
{{- end }}
{{- end }}

{{/*
Return the proper redis port
{{ include "common.middleware.redis.port" . }}
*/}}
{{- define "common.middleware.redis.port" }}
{{- if .Values.redis }}
   {{- if .Values.redis.port }}
      {{- .Values.redis.port }}
   {{- else if .Values.global.redis }}
      {{- .Values.global.redis.port }}
   {{- end }}
{{- else if .Values.global.redis }}
   {{- .Values.global.redis.port }}
{{- end }}
{{- end }}

{{/*
Return the proper redis cluster_max_redirects
{{ include "common.middleware.redis.cluster_max_redirects" . }}
*/}}
{{- define "common.middleware.redis.cluster_max_redirects" }}
{{- if .Values.redis }}
   {{- if .Values.redis.cluster_max_redirects }}
      {{- .Values.redis.cluster_max_redirects }}
   {{- else if .Values.global.redis }}
      {{- .Values.global.redis.cluster_max_redirects }}
   {{- end }}
{{- else if .Values.global.redis }}
   {{- .Values.global.redis.cluster_max_redirects }}
{{- end }}
{{- end }}

{{/*
Return the proper redis pool_max_active
{{ include "common.middleware.redis.pool_max_active" . }}
*/}}
{{- define "common.middleware.redis.pool_max_active" }}
{{- if .Values.redis }}
   {{- if .Values.redis.pool_max_active }}
      {{- .Values.redis.pool_max_active }}
   {{- else if .Values.global.redis }}
      {{- .Values.global.redis.pool_max_active }}
   {{- end }}
{{- else if .Values.global.redis }}
   {{- .Values.global.redis.pool_max_active }}
{{- end }}
{{- end }}

{{/*
Return the proper redis redis_pool_max_idle
{{ include "common.middleware.redis.pool_max_idle" . }}
*/}}
{{- define "common.middleware.redis.pool_max_idle" }}
{{- if .Values.redis }}
   {{- if .Values.redis.pool_max_idle }}
      {{- .Values.redis.pool_max_idle }}
   {{- else if .Values.global.redis }}
      {{- .Values.global.redis.pool_max_idle }}
   {{- end }}
{{- else if .Values.global.redis }}
   {{- .Values.global.redis.pool_max_idle }}
{{- end }}
{{- end }}

{{/*
Return the proper redis pool_max_wait
{{ include "common.middleware.redis.pool_max_wait" . }}
*/}}
{{- define "common.middleware.redis.pool_max_wait" }}
{{- if .Values.redis }}
   {{- if .Values.redis.pool_max_wait }}
      {{- .Values.redis.pool_max_wait }}
   {{- else if .Values.global.redis }}
      {{- .Values.global.redis.pool_max_wait }}
   {{- end }}
{{- else if .Values.global.redis }}
   {{- .Values.global.redis.pool_max_wait }}
{{- end }}
{{- end }}

{{/*
Return the proper redis redis_pool_min_idle
{{ include "common.middleware.redis.pool_min_idle" . }}
*/}}
{{- define "common.middleware.redis.pool_min_idle" }}
{{- if .Values.redis }}
   {{- if .Values.redis.pool_min_idle }}
      {{- .Values.redis.pool_min_idle }}
   {{- else if .Values.global.redis }}
      {{- .Values.global.redis.pool_min_idle }}
   {{- end }}
{{- else if .Values.global.redis }}
   {{- .Values.global.redis.pool_min_idle }}
{{- end }}
{{- end }}

{{/*
Return the proper redis redis_timeout
{{ include "common.middleware.redis.timeout" . }}
*/}}
{{- define "common.middleware.redis.timeout" }}
{{- if .Values.redis }}
   {{- if .Values.redis.timeout }}
      {{- .Values.redis.timeout }}
   {{- else if .Values.global.redis }}
      {{- .Values.global.redis.timeout }}
   {{- end }}
{{- else if .Values.global.redis }}
   {{- .Values.global.redis.timeout }}
{{- end }}
{{- end }}

{{/*
Return the proper redis password
{{ include "common.middleware.redis.password" . }}
*/}}
{{- define "common.middleware.redis.password" }}
{{- if .Values.auth }}
   {{- if .Values.auth.redis }}
     {{- if .Values.auth.redis.password }}
       {{- .Values.auth.redis.password }}
     {{- else }}
       {{- .Values.global.auth.redis.password }}
     {{- end }}
   {{- else }}
     {{- .Values.global.auth.redis.password }}
   {{- end }}
{{- else if .Values.global.auth.redis }}
   {{- .Values.global.auth.redis.password }}
{{- end }}
{{- end }}








