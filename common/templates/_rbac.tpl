{{/* vim: set filetype=mustache: */}}

{{/*
Kubernetes standard clusterrole
*/}}
{{- define "common.rbac.clusterRole" }}
{{- if .Values.rbac.clusterRole.create }}
apiVersion: {{ include "common.capabilities.rbac.apiVersion" . }}
kind: ClusterRole
metadata:
  {{- if .Values.rbac.clusterRole.name }}
  name: {{ .Values.rbac.clusterRole.name }}
  {{- else }}
  name: {{ include "common.names.fullname" . }}
  {{- end }}
  labels: {{- include "common.labels.standard" . | nindent 4 }}
  {{- if .Values.commonLabels }}
    {{- include "common.tplvalues.render" ( dict "value" .Values.commonLabels "context" $ ) | nindent 4 }}
  {{- end }}
  {{- if .Values.commonAnnotations }}
  annotations: {{- include "common.tplvalues.render" ( dict "value" .Values.commonAnnotations "context" $ ) | nindent 4 }}
  {{- end }}
rules: 
{{- include "common.tplvalues.render" ( dict "value" .Values.rbac.clusterRole.rules "context" $ ) | nindent 2 }}

{{- end }}
{{- end }}

{{/*
Kubernetes standard role
*/}}
{{- define "common.rbac.role" }}
{{- if .Values.rbac.role.create }}
apiVersion: {{ include "common.capabilities.rbac.apiVersion" . }}
kind: Role
metadata:
  {{- if .Values.rbac.role.name }}
  name: {{ .Values.rbac.role.name }}
  {{- else }}
  name: {{ include "common.names.fullname" . }}
  {{- end }}
  namespace: {{ .Release.Namespace | quote }}
  labels: {{- include "common.labels.standard" . | nindent 4 }}
  {{- if .Values.commonLabels }}
    {{- include "common.tplvalues.render" ( dict "value" .Values.commonLabels "context" $ ) | nindent 4 }}
  {{- end }}
  {{- if .Values.commonAnnotations }}
  annotations: {{- include "common.tplvalues.render" ( dict "value" .Values.commonAnnotations "context" $ ) | nindent 4 }}
  {{- end }}
rules: {{- include "common.tplvalues.render" ( dict "value" .Values.rbac.role.rules "context" $ ) | nindent }}

{{- end }}
{{- end }}


{{/*
Kubernetes standard clusterrolebinding
*/}}
{{- define "common.rbac.clusterRoleBinding" }}
{{- if .Values.rbac.clusterRoleBinding.create }}
apiVersion: {{ include "common.capabilities.rbac.apiVersion" . }}
kind: ClusterRoleBinding
metadata:
  {{- if .Values.rbac.clusterRoleBinding.name }}
  name: {{ .Values.rbac.clusterRoleBinding.name }}
  {{- else }}
  name: {{ include "common.names.fullname" . }}
  {{- end }}
  labels: {{- include "common.labels.standard" . | nindent 4 }}
  {{- if .Values.commonLabels }}
    {{- include "common.tplvalues.render" ( dict "value" .Values.commonLabels "context" $ ) | nindent 4 }}
  {{- end }}
  {{- if .Values.commonAnnotations }}
  annotations: {{- include "common.tplvalues.render" ( dict "value" .Values.commonAnnotations "context" $ ) | nindent 4 }}
  {{- end }}
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  {{- if .Values.rbac.clusterRoleBinding.clusterroleName }}
  name: {{ .Values.rbac.clusterRoleBinding.clusterroleName }}
  {{- else }}
  name: {{ include "common.names.fullname" . }}
  {{- end }}
subjects:
- kind: ServiceAccount
  {{- if .Values.rbac.clusterRoleBinding.serviceAccountName }}
  name: {{ .Values.rbac.clusterRoleBinding.serviceAccountName }}
  {{- else }}
  name: {{ include "common.names.fullname" . }}
  {{- end }}
  namespace: {{ .Release.Namespace | quote }}
{{- end }}
{{- end }}


{{/*
Kubernetes standard rolebinding
*/}}
{{- define "common.rbac.roleBinding" }}
{{- if .Values.rbac.roleBinding.create }}
apiVersion: {{ include "common.capabilities.rbac.apiVersion" . }}
kind: RoleBinding
metadata:
  {{- if .Values.rbac.roleBinding.name }}
  name: {{ .Values.rbac.roleBinding.name }}
  {{- else }}
  name: {{ include "common.names.fullname" . }}
  {{- end }}
  labels: {{- include "common.labels.standard" . | nindent 4 }}
  {{- if .Values.commonLabels }}
    {{- include "common.tplvalues.render" ( dict "value" .Values.commonLabels "context" $ ) | nindent 4 }}
  {{- end }}
  {{- if .Values.commonAnnotations }}
  annotations: {{- include "common.tplvalues.render" ( dict "value" .Values.commonAnnotations "context" $ ) | nindent 4 }}
  {{- end }}

roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: Role
  {{- if .Values.rbac.roleBinding.roleName }}
  name: {{ .Values.rbac.roleBinding.roleName }}
  {{- else }}
  name: {{ include "common.names.fullname" . }}
  {{- end }}
subjects:
- kind: ServiceAccount
  {{- if .Values.rbac.roleBinding.serviceAccountName }}
  name: {{ .Values.rbac.roleBinding.serviceAccountName }}
  {{- else }}
  name: {{ include "common.names.fullname" . }}
  {{- end }}
  namespace: {{ .Release.Namespace | quote }}
{{- end }}
{{- end }}


{{/* vim: set filetype=mustache: */}}
{{/*
Kubernetes standard serviceAccount
*/}}
{{- define "common.rbac.serviceAccount" }}
{{- if .Values.serviceAccount }}
{{- if .Values.serviceAccount.create }}

apiVersion: v1
kind: ServiceAccount
metadata:
  name: {{ include "common.names.fullname" . }}
  namespace: {{ .Release.Namespace | quote }}
  labels: {{- include "common.labels.standard" . | nindent 4 }}
  {{- if .Values.commonLabels }}
    {{- include "common.tplvalues.render" ( dict "value" .Values.commonLabels "context" $ ) | nindent 4 }}
  {{- end }}
  {{- if .Values.commonAnnotations }}
  annotations: {{- include "common.tplvalues.render" ( dict "value" .Values.commonAnnotations "context" $ ) | nindent 4 }}
  {{- end }}
   {{- end }}

{{- end }}
{{- end }}




