{{/* vim: set filetype=mustache: */}}

{{/*
Return the proper global version
{{ include "common.global.version" . | quote }}
*/}}
{{- define "common.global.version" }}
{{- if .Values }}
   {{- if .Values.version }}
      {{- .Values.version }}
   {{- else if and .Values.global .Values.global.version  }}
      {{- .Values.global.version }}
   {{- end }}
{{- end }}
{{- end }}

{{/*
Return the proper global vm_promxy
{{ include "common.global.vm_promxy" . | quote }}
*/}}
{{- define "common.global.vm_promxy" }}
{{- if .Values }}
   {{- if .Values.vm_promxy }}
      {{- .Values.vm_promxy }}
   {{- else if and .Values.global .Values.global.vm_promxy  }}
      {{- .Values.global.vm_promxy }}
   {{- end }}
{{- end }}
{{- end }}

{{/*
Return the proper global monitoring_ip
{{ include "common.global.monitoring_ip" . | quote }}
*/}}
{{- define "common.global.monitoring_ip" }}
{{- if .Values }}
   {{- if .Values.monitoring_ip }}
      {{- .Values.monitoring_ip }}
   {{- else if and .Values.global .Values.global.monitoring_ip  }}
      {{- .Values.global.monitoring_ip }}
   {{- end }}
{{- end }}
{{- end }}
{{/*
Return the proper global default_registry
{{ include "common.global.default_registry" . | quote }}
*/}}
{{- define "common.global.default_registry" }}
{{- if .Values }}
   {{- if .Values.default_registry }}
      {{- .Values.default_registry }}
   {{- else if and .Values.global .Values.global.default_registry  }}
      {{- .Values.global.default_registry }}
   {{- end }}
{{- end }}
{{- end }}

{{/*
Return the proper global data_center_id
{{ include "common.global.data_center_id" . | quote }}
*/}}
{{- define "common.global.data_center_id" }}
{{- if .Values }}
   {{- if .Values.data_center_id }}
      {{- .Values.data_center_id }}
   {{- else if and .Values.global .Values.global.data_center_id  }}
      {{- .Values.global.data_center_id }}
   {{- end }}
{{- end }}
{{- end }}
{{/*
Return the proper global cluster_id
{{ include "common.global.cluster_id" . | quote }}
*/}}
{{- define "common.global.cluster_id" }}
{{- if .Values }}
   {{- if .Values.cluster_id }}
      {{- .Values.cluster_id }}
   {{- else if and .Values.global .Values.global.cluster_id  }}
      {{- .Values.global.cluster_id }}
   {{- end }}
{{- end }}
{{- end }}
{{/*
Return the proper global master_vip
{{ include "common.global.master_vip" . | quote }}
*/}}
{{- define "common.global.master_vip" }}
{{- if .Values }}
   {{- if .Values.master_vip }}
      {{- .Values.master_vip }}
   {{- else if and .Values.global .Values.global.master_vip  }}
      {{- .Values.global.master_vip }}
   {{- end }}
{{- end }}
{{- end }}

{{/*
Return the proper global business_vip
{{ include "common.global.business_vip" . | quote }}
*/}}
{{- define "common.global.business_vip" }}
{{- if .Values }}
   {{- if .Values.business_vip }}
      {{- .Values.business_vip }}
   {{- else if and .Values.global .Values.global.business_vip  }}
      {{- .Values.global.business_vip }}
   {{- end }}
{{- end }}
{{- end }}

{{/*
Return the proper global middleware_vip
{{ include "common.global.middleware_vip" . | quote }}
*/}}
{{- define "common.global.middleware_vip" }}
{{- if .Values }}
   {{- if .Values.middleware_vip }}
      {{- .Values.middleware_vip }}
   {{- else if and .Values.global .Values.global.middleware_vip  }}
      {{- .Values.global.middleware_vip }}
   {{- end }}
{{- end }}
{{- end }}

{{/*
Return the proper global ingress_controller_replicas
{{ include "common.global.ingress_controller_replicas" . | quote }}
*/}}
{{- define "common.global.ingress_controller_replicas" }}
{{- if .Values }}
   {{- if .Values.ingress_controller_replicas }}
      {{- .Values.ingress_controller_replicas }}
   {{- else if and .Values.global .Values.global.ingress_controller_replicas  }}
      {{- .Values.global.ingress_controller_replicas }}
   {{- end }}
{{- end }}
{{- end }}

{{/*
Return the proper global domain
{{ include "common.global.domain" . | quote }}
*/}}
{{- define "common.global.domain" }}
{{- if .Values }}
   {{- if .Values.domain }}
      {{- .Values.domain }}
   {{- else if and .Values.global .Values.global.domain  }}
      {{- .Values.global.domain }}
   {{- end }}
{{- end }}
{{- end }}

{{/*
Return the proper global dockerRegisty
{{ include "common.global.dockerRegisty" . | quote }}
*/}}
{{- define "common.global.dockerRegisty" }}
{{- if .Values }}
   {{- if .Values.dockerRegisty }}
      {{- .Values.dockerRegisty }}
   {{- else if and .Values.global .Values.global.dockerRegisty  }}
      {{- .Values.global.dockerRegisty }}
   {{- end }}
{{- end }}
{{- end }}


{{/*
Return the proper global dnsaMasterImage
{{ include "common.global.dnsaMasterImage" . | quote }}
*/}}
{{- define "common.global.dnsaMasterImage" }}
{{- if .Values }}
   {{- if .Values.dnsaMasterImage }}
      {{- .Values.dnsaMasterImage }}
   {{- else if and .Values.global .Values.global.dnsaMasterImage  }}
      {{- .Values.global.dnsaMasterImage }}
   {{- end }}
{{- end }}
{{- end }}


{{/*
Return the proper global buildpackdImage
{{ include "common.global.buildpackdImage" . | quote }}
*/}}
{{- define "common.global.buildpackdImage" }}
{{- if .Values }}
   {{- if .Values.buildpackdImage }}
      {{- .Values.buildpackdImage }}
   {{- else if and .Values.global .Values.global.buildpackdImage  }}
      {{- .Values.global.buildpackdImage }}
   {{- end }}
{{- end }}
{{- end }}

{{/*
Return the proper global buildpackJobImage
{{ include "common.global.buildpackJobImage" . | quote }}
*/}}
{{- define "common.global.buildpackJobImage" }}
{{- if .Values }}
   {{- if .Values.buildpackJobImage }}
      {{- .Values.buildpackJobImage }}
   {{- else if and .Values.global .Values.global.buildpackJobImage  }}
      {{- .Values.global.buildpackJobImage }}
   {{- end }}
{{- end }}
{{- end }}


{{/*
Return the proper global agentOrcaImage
{{ include "common.global.agentOrcaImage" . | quote }}
*/}}
{{- define "common.global.agentOrcaImage" }}
{{- if .Values }}
   {{- if .Values.agentOrcaImage }}
      {{- .Values.agentOrcaImage }}
   {{- else if and .Values.global .Values.global.agentOrcaImage  }}
      {{- .Values.global.agentOrcaImage }}
   {{- end }}
{{- end }}
{{- end }}


{{/*
Return the proper global elastalertImage
{{ include "common.global.elastalertImage" . | quote }}
*/}}
{{- define "common.global.elastalertImage" }}
{{- if .Values }}
   {{- if .Values.elastalertImage }}
      {{- .Values.elastalertImage }}
   {{- else if and .Values.global .Values.global.elastalertImage  }}
      {{- .Values.global.elastalertImage }}
   {{- end }}
{{- end }}
{{- end }}

{{/*
Return the proper global etcdBackupImage
{{ include "common.global.etcdBackupImage" . | quote }}
*/}}
{{- define "common.global.etcdBackupImage" }}
{{- if .Values }}
   {{- if .Values.etcdBackupImage }}
      {{- .Values.etcdBackupImage }}
   {{- else if and .Values.global .Values.global.etcdBackupImage  }}
      {{- .Values.global.etcdBackupImage }}
   {{- end }}
{{- end }}
{{- end }}

{{/*
Return the proper global filebeatPilotImage
{{ include "common.global.filebeatPilotImage" . | quote }}
*/}}
{{- define "common.global.filebeatPilotImage" }}
{{- if .Values }}
   {{- if .Values.filebeatPilotImage }}
      {{- .Values.filebeatPilotImage }}
   {{- else if and .Values.global .Values.global.filebeatPilotImage  }}
      {{- .Values.global.filebeatPilotImage }}
   {{- end }}
{{- end }}
{{- end }}

{{/*
Return the proper global hapaMasterImage
{{ include "common.global.hapaMasterImage" . | quote }}
*/}}
{{- define "common.global.hapaMasterImage" }}
{{- if .Values }}
   {{- if .Values.hapaMasterImage }}
      {{- .Values.hapaMasterImage }}
   {{- else if and .Values.global .Values.global.hapaMasterImage  }}
      {{- .Values.global.hapaMasterImage }}
   {{- end }}
{{- end }}
{{- end }}


{{/*
Return the proper global logsImage
{{ include "common.global.logsImage" . | quote }}
*/}}
{{- define "common.global.logsImage" }}
{{- if .Values }}
   {{- if .Values.logsImage }}
      {{- .Values.logsImage }}
   {{- else if and .Values.global .Values.global.logsImage  }}
      {{- .Values.global.logsImage }}
   {{- end }}
{{- end }}
{{- end }}


{{/*
Return the proper global majorQueryImage
{{ include "common.global.majorQueryImage" . | quote }}
*/}}
{{- define "common.global.majorQueryImage" }}
{{- if .Values }}
   {{- if .Values.majorQueryImage }}
      {{- .Values.majorQueryImage }}
   {{- else if and .Values.global .Values.global.majorQueryImage  }}
      {{- .Values.global.majorQueryImage }}
   {{- end }}
{{- end }}
{{- end }}


{{/*
Return the proper global monitoringImage
{{ include "common.global.monitoringImage" . | quote }}
*/}}
{{- define "common.global.monitoringImage" }}
{{- if .Values }}
   {{- if .Values.monitoringImage }}
      {{- .Values.monitoringImage }}
   {{- else if and .Values.global .Values.global.monitoringImage  }}
      {{- .Values.global.monitoringImage }}
   {{- end }}
{{- end }}
{{- end }}

{{/*
Return the proper global enable_https
{{ include "common.global.enable_https" . | quote }}
*/}}
{{- define "common.global.enable_https" }}
{{- if .Values }}
   {{- if .Values.enable_https }}
      {{- .Values.enable_https }}
   {{- else if and .Values.global .Values.global.enable_https  }}
      {{- .Values.global.enable_https }}
   {{- end }}
{{- end }}
{{- end }}

{{/*
Return the proper global etcd_servers
{{ include "common.global.etcd_servers" . | quote }}
*/}}
{{- define "common.global.business_etcd_servers" }}
{{- if .Values }}
   {{- if .Values.etcd_servers }}
      {{- .Values.etcd_servers }}
   {{- else if and .Values.global .Values.global.etcd_servers  }}
      {{- .Values.global.etcd_servers }}
   {{- end }}
{{- end }}
{{- end }}

{{/*
Return the proper global nfs_server
{{ include "common.global.nfs_server" . | quote }}
*/}}
{{- define "common.global.nfs_server" }}
{{- if .Values }}
   {{- if .Values.nfs_server }}
      {{- .Values.nfs_server }}
   {{- else if and .Values.global .Values.global.nfs_server  }}
      {{- .Values.global.nfs_server }}
   {{- end }}
{{- end }}
{{- end }}

{{/*
Return the proper global gateway_ip
{{ include "common.global.gateway_ip" . | quote }}
*/}}
{{- define "common.global.gateway_ip" }}
{{- if .Values }}
   {{- if .Values.gateway_ip }}
      {{- .Values.gateway_ip }}
   {{- else if and .Values.global .Values.global.gateway_ip  }}
      {{- .Values.global.gateway_ip }}
   {{- end }}
{{- end }}
{{- end }}

{{/*
Return the proper global primary_ip
{{ include "common.global.primary_ip" . | quote }}
*/}}
{{- define "common.global.primary_ip" }}
{{- if .Values }}
   {{- if .Values.primary_ip }}
      {{- .Values.primary_ip }}
   {{- else if and .Values.global .Values.global.primary_ip  }}
      {{- .Values.global.primary_ip }}
   {{- end }}
{{- end }}
{{- end }}

{{/*
Return the proper global business_pod_cidr
{{ include "common.global.business_pod_cidr" . | quote }}
*/}}
{{- define "common.global.business_pod_cidr" }}
{{- if .Values }}
   {{- if .Values.business_pod_cidr }}
      {{- .Values.business_pod_cidr }}
   {{- else if and .Values.global .Values.global.business_pod_cidr  }}
      {{- .Values.global.business_pod_cidr }}
   {{- end }}
{{- end }}
{{- end }}






























