{{/*
Expand the name of the chart.
*/}}
{{- define "skupper.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "skupper.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "skupper.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "skupper.labels" -}}
helm.sh/chart: {{ include "skupper.chart" . }}
{{ include "skupper.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "skupper.selectorLabels" -}}
application: skupper-controller
app.kubernetes.io/name: {{ include "skupper.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "skupper.serviceAccountName" -}}
{{- if .Values.rbac.create }}
{{- default (include "skupper.fullname" .) .Values.rbac.serviceAccountName }}
{{- else }}
{{- required "A valid overrideServiceAccount is requried" .Values.controller.overrideServiceAccount }}
{{- end }}
{{- end }}


{{/*
Controller Arguments
*/}}
{{- define "skupper.args" -}}
{{- if .Values.grants.enabled -}}
- "-enable-grants"
{{- end }}
{{- if .Values.grants.autoconfigure }}
- "-grant-server-autoconfigure"
{{- else }}
- "-grant-server-base-url={{ .Values.grants.baseURL }}"
- "-grant-server-podname={{ .Values.grants.serverPodname }}"
- "-grant-server-port={{ .Values.grants.serverPort }}"
- "-grant-server-tls-credentials={{ .Values.grants.serverTLSCredentials }}"
{{- end }}
{{- if .Values.access.defaultType }}
- "-default-access-type={{ .Values.access.defaultType }}"
{{- end }}
{{- if .Values.access.enabledTypes }}
- "-enabled-access-types={{ .Values.access.enabledTypes }}"
{{- end }}
{{- if .Values.access.gateway.class }}
- "-gateway-class={{ .Values.access.gateway.class }}"
{{- end }}
{{- if .Values.access.gateway.domain }}
- "-gateway-domain={{ .Values.access.gateway.domain }}"
{{- end }}
{{- if .Values.access.gateway.port }}
- "-gateway-port={{ .Values.access.gateway.port }}"
{{- end }}
{{- if .Values.access.nodeport.clusterHost }}
- "-cluster-host={{ .Values.access.nodeport.clusterHost }}"
{{- end }}
{{- if .Values.access.nginx.domain }}
- "-ingress-domain={{ .Values.access.nginx.domain }}"
{{- end }}
{{- if .Values.access.contour.domain }}
- "-http-proxy-domain={{ .Values.access.contour.domain }}"
{{- end }}
{{- end }}
