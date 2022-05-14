{{/* vim: set filetype=mustache: */}}
{{/*
Kubernetes standard deployment
*/}}
{{- define "common.crobjob" }}
apiVersion: {{ include "common.capabilities.cronjob.apiVersion" . }}
kind: CronJob
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
spec:
  schedule: {{ .Values.schedule.schedule }}
  successfulJobsHistoryLimit: {{ .Values.schedule.successfulJobsHistoryLimit }}
  failedJobsHistoryLimit: {{ .Values.schedule.failedJobsHistoryLimit }}
  jobTemplate:
    metadata:
    {{- if .Values.matchLabels }}
      labels: {{- include "common.tplvalues.render" ( dict "value" .Values.matchLabels "context" $ ) | nindent 8  }}
    {{- else }}
      labels: {{- include "common.labels.matchLabels" . | nindent 8 }}
    {{- end }}
    spec:
      template:
        spec:
          {{- if .Values.restartPolicy }}
          restartPolicy: {{ .Values.restartPolicy }}
          {{- end }}
          {{- if .Values.initContainers }}
          initContainers: {{- toYaml .Values.initContainers | nindent 12 }}
          {{- end }}
          {{- if .Values.podSecurityContext }}
          securityContext: {{- include "common.tplvalues.render" ( dict "value" .Values.podSecurityContext "context" $ ) | nindent 12  }}
          {{- end }}
          {{- if .Values.hostNetwork }}
          hostNetwork: {{ .Values.hostNetwork }}
          {{- end }}
          containers:
            - name: {{ include "common.names.fullname" . }}
              image: {{ include "common.tplvalues.render" ( dict "value" .Values.image.name "context" $ ) }}
              {{- if .Values.image.pullPolicy }}
              imagePullPolicy: {{ .Values.image.pullPolicy | quote }}
              {{- end }}
              {{- if .Values.containerPort }}
              ports: {{- .Values.containerPort | toYaml | nindent 16 }}
              {{- end }}
              {{- if .Values.resources }}
              resources: {{- include "common.tplvalues.render" ( dict "value" .Values.resources "context" $ ) | nindent 16  }}
              {{- end }}
              {{- if .Values.command }}
              command: {{- include "common.tplvalues.render" ( dict "value" .Values.command "context" $ ) | nindent 16  }}
              {{- end }}
              {{- if .Values.args }}
              args: {{- include "common.tplvalues.render" ( dict "value" .Values.args "context" $ ) | nindent 16  }}
              {{- end }}
              {{- if .Values.env }}
              env: 
              {{- include "common.tplvalues.render" ( dict "value" .Values.env "context" $ ) | nindent 16  }}
              {{- end }}
              {{- if .Values.readinessProbe }}
              readinessProbe: {{- include "common.tplvalues.render" ( dict "value" .Values.readinessProbe "context" $ ) | nindent 16  }}
              {{- end }}
              {{- if .Values.livenessProbe }}
              livenessProbe: {{- include "common.tplvalues.render" ( dict "value" .Values.livenessProbe "context" $ ) | nindent 16  }}
              {{- end }}
              {{- if .Values.volumeMounts }}
              volumeMounts: {{- include "common.tplvalues.render" ( dict "value" .Values.volumeMounts "context" $ ) | nindent 16  }}
              {{- end }}
              {{- if .Values.startupProbe }}
              startupProbe: {{- include "common.tplvalues.render" ( dict "value" .Values.startupProbe "context" $ ) | nindent 16  }}
              {{- end }}
              {{- if .Values.containerSecurityContext }}
              securityContext: {{- include "common.tplvalues.render" ( dict "value" .Values.containerSecurityContext "context" $ ) | nindent 16  }}
              {{- end }}
          {{- if .Values.volumes }}
          volumes: {{- include "common.tplvalues.render" ( dict "value" .Values.volumes "context" $ ) | nindent 12  }}
          {{- end }}
          {{- if .Values.nodeSelector }}
          nodeSelector: {{- include "common.tplvalues.render" ( dict "value" .Values.nodeSelector "context" $ ) | nindent 12  }}
          {{- end }}
          {{- if .Values.tolerations }}
          tolerations: {{- include "common.tplvalues.render" ( dict "value" .Values.tolerations "context" $ ) | nindent 12  }}
          {{- end }}
          {{- if .Values.hostAliases }}
          hostAliases: {{- include "common.tplvalues.render" ( dict "value" .Values.hostAliases "context" $ ) | nindent 12  }}
          {{- end }}
          {{- if .Values.affinity }}
          affinity: {{- include "common.tplvalues.render" ( dict "value" .Values.affinity "context" $ ) | nindent 12  }}
          {{- end }}
          {{- if .Values.dnsPolicy }}
          dnsPolicy: {{- include "common.tplvalues.render" ( dict "value" .Values.dnsPolicy "context" $ ) | nindent 12  }}
          {{- end }}
          {{- if .Values.serviceAccount }}
          {{- if .Values.serviceAccount.name }}
          serviceAccount: {{ .Values.serviceAccount.name }}
          serviceAccountName: {{ .Values.serviceAccount.name }}
          {{- else }}
          serviceAccount: {{ include "common.names.fullname" . }}
          serviceAccountName: {{ include "common.names.fullname" . }}
          {{- end }}
          {{- end }}
 {{- if .Values.updateStrategy }}
  strategy: {{ include "common.tplvalues.render" (dict "value" .Values.updateStrategy "context" $ ) | nindent 4 }}
 {{- end }}
{{- end }}
























