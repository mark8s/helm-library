{{/* vim: set filetype=mustache: */}}
{{/*
Kubernetes standard deployment
*/}}
{{- define "common.configmap" }}
apiVersion: v1
kind: configmap
metadata:
  annotations:
    meta.helm.sh/release-name: {{ include "common.names.fullname" . }}
    meta.helm.sh/release-namespace: {{ .Release.Namespace | quote }}
  name: {{ include "common.names.fullname" . }}-configmap
  namespace: {{ .Release.Namespace | quote }}
data:
{{- include "common.tplvalues.render" ( dict "value" .Values.configmap "context" $ ) | nindent 2  }}
{{- end }}