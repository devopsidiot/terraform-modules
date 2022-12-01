{{- define "devopsidiot-deployment.name" }}{{ .Release.Name }}{{- end }}
{{- define "devopsidiot-deployment.fullname" }}{{ .Release.Name }}-{{ .Values.territory }}-{{ .Values.environment }}{{- end }}
{{- define "devopsidiot-deployment.flux-path" }}./devopsidiot-services/{{ .Values.businessRegion }}/{{ .Values.environment }}/{{ .Values.territory}}{{- end }}