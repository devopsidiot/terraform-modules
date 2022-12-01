{{- define "devopsidiot-cronjob.name" }}{{ .Release.Name }}{{- end }}
{{- define "devopsidiot-cronjob.fullname" }}{{ .Release.Name }}-{{ .Values.territory }}-{{ .Values.environment }}{{- end }}
{{- define "devopsidiot-cronjob.flux-path" }}./devopsidiot-services/{{ .Values.businessRegion }}/{{ .Values.environment }}/{{ .Values.territory}}{{- end }}
