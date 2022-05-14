
{{- define "common.service" }}
apiVersion: v1
kind: Service
metadata:
  name: {{ include "common.names.fullname" . }}
  namespace: {{ .Release.Namespace | quote }}
  labels: {{- include "common.labels.standard" . | nindent 4 }}
    {{- if .Values.commonLabels }}
    {{- include "common.tplvalues.render" ( dict "value" .Values.commonLabels "context" $ ) | nindent 4 }}
    {{- end }}
  {{- if .Values.service.annotations }}
  annotations: {{ include "common.tplvalues.render" ( dict "value" .Values.service.annotations "context" $ ) | nindent 4 }}
  {{- end }}
spec:
  selector:
    {{- if .Values.matchLabels }}
    {{- toYaml .Values.matchLabels | nindent 4 }}
    {{- else }}
    {{- include "common.labels.matchLabels" . | nindent 4 }}
    {{- end }}
  ports: {{- toYaml .Values.service.ports | nindent 4 }}
  {{- if .Values.service.type }}
  type: {{ .Values.service.type }}
  {{- if and .Values.service.clusterIP (eq .Values.service.type "ClusterIP") }}
  clusterIP: {{ .Values.service.clusterIP }}
  {{- end }}
  {{- if (or (eq .Values.service.type "LoadBalancer") (eq .Values.service.type "NodePort")) }}
  externalTrafficPolicy: {{ .Values.service.externalTrafficPolicy | quote }}
  {{- end }}
  {{- if (and (eq .Values.service.type "LoadBalancer") .Values.service.loadBalancerSourceRanges) }}
  loadBalancerSourceRanges: {{- toYaml . | nindent 4 }}
  {{- end }}
  {{- if (and (eq .Values.service.type "LoadBalancer") (not (empty .Values.service.loadBalancerIP))) }}
  loadBalancerIP: {{ .Values.service.loadBalancerIP }}
  {{- end }}
  {{- end }}

{{- end }}

