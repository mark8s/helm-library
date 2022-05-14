{{/* vim: set filetype=mustache: */}}
{{/*
Return the proper  mail host
{{ include "common.tools.mail.host" . }}
*/}}
{{- define "common.tools.mail.host" }}
    {{- if .Values.mail }}
       {{- if .Values.mail.host }}
          {{- .Values.mail.host }}
       {{- else if .Values.global.mail }}
          {{- .Values.global.mail.host }}
       {{- end }}
    {{- else if .Values.global.mail }}
       {{- .Values.global.mail.host }}
    {{- end }}
{{- end }}

{{/*
Return the proper  mail port
{{ include "common.tools.mail.port" . }}
*/}}
{{- define "common.tools.mail.port" }}
    {{- if .Values.mail }}
       {{- if .Values.mail.port }}
          {{- .Values.mail.port }}
       {{- else if .Values.global.mail }}
          {{- .Values.global.mail.port }}
       {{- end }}
    {{- else if .Values.global.mail }}
       {{- .Values.global.mail.port }}
    {{- end }}
{{- end }}

{{/*
Return the proper  mail username
{{ include "common.tools.mail.username" . }}
*/}}
{{- define "common.tools.mail.username" }}
    {{- if .Values.mail }}
       {{- if .Values.mail.username }}
          {{- .Values.mail.username }}
       {{- else if .Values.global.mail }}
          {{- .Values.global.mail.username }}
       {{- end }}
    {{- else if .Values.global.mail }}
       {{- .Values.global.mail.username }}
    {{- end }}
{{- end }}

{{/*
Return the proper  mail password
{{ include "common.tools.mail.password" . }}
*/}}
{{- define "common.tools.mail.password" }}
    {{- if .Values.mail }}
       {{- if .Values.mail.password }}
          {{- .Values.mail.password }}
       {{- else if .Values.global.password }}
          {{- .Values.global.mail.password }}
       {{- end }}
    {{- else if .Values.global.password }}
       {{- .Values.global.mail.password }}
    {{- end }}
{{- end }}

{{/*
Return the proper  mail nickname
{{ include "common.tools.mail.nickname" . }}
*/}}
{{- define "common.tools.mail.nickname" }}
    {{- if .Values.mail }}
       {{- if .Values.mail.nickname }}
          {{- .Values.mail.nickname }}
       {{- else if .Values.global.mail }}
          {{- .Values.global.mail.nickname }}
       {{- end }}
    {{- else if .Values.global.mail }}
       {{- .Values.global.mail.nickname }}
    {{- end }}
{{- end }}
