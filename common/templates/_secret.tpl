{{/* vim: set filetype=mustache: */}}
{{/*
Kubernetes standard deployment
*/}}
{{- define "common.secret" }}
apiVersion: v1
kind: Secret
metadata:
  annotations:
    meta.helm.sh/release-name: {{ include "common.names.fullname" . }}
    meta.helm.sh/release-namespace: {{ .Release.Namespace | quote }}
  name: {{ include "common.names.fullname" . }}-secret
  namespace: {{ .Release.Namespace | quote }}
data:
{{- include "common.tplvalues.render" ( dict "value" .Values.secret "context" $ ) | nindent 2  }}
{{- end }}
























