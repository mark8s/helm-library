# helm-library
Helm 3 中引入了一种新的 Chart 类型，名为 Library Chart 。它不会部署出一些具体的资源，只能被其他的 Chart 所引用，提高代码的可用复用性。当一个 Chart 想要使用该 Library Chart内的一些模板时，可以在 Chart.yaml 的 dependencies 依赖项中指定。

## 使用helm charts
在helm chart包中，编辑Chart.yaml，然后增加以下代码
``` yaml
  dependencies:
  - name: common
    version: "1.0.0"
    repository: "file://../../../common"
```
common：模块名

version: 模块版本

repository：模块的位置，这里通过file引入

当我们执行完以上的步骤后，我们需要执行以下命令进行common模块的引入
``` shell
   helm dependency update XXXXchartName
```
当执行完后，理论上在charts中会生成一个common-1.0.0.tgz的包

现在我们已经将common模块引入到我们自己的charts中，那么如何使用呢？

我们可以通过使用 `{{ include 模块func名 作用域 }} `的语法，在我们的yaml或tpl文件去使用它。

关于include的用法，可以查看以下文档
> https://helm.sh/zh/docs/chart_template_guide/named_templates/

举个栗子

在common中，有一个名为 `_label.tpl` 的文件，它的内容大致如下：

```yaml
{{- define "common.labels.standard" -}}
app.kubernetes.io/name: {{ include "common.names.name" . }}
helm.sh/chart: {{ include "common.names.chart" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}
```
`{{- define }} {{ end }}` 中间包含的就是一组k8s中的labels，这里可以看作一个function，而 `common.labels.standard` 就相当于这个function的方法名

如何使用这个function呢？

我们回到自己的chart的template中，修改deployment.yaml文件

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: test
  namespace: {{ .Release.Namespace }}
  labels:
    {{- include "common.labels.standard" . | nindent 4 }}
...
```

`{{- include "common.labels.standard" . | nindent 4 }}` ,就这样，就可以将 common.labels.standard 这个function引入进来

然后我们执行helm install 去查看效果

```yaml
# Source: test/templates/deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: test
  namespace: example
  labels:
    app.kubernetes.io/name: test
    helm.sh/chart: test-0.1.0
    app.kubernetes.io/instance: test
    app.kubernetes.io/managed-by: Helm
...
```

### 如何启动我们的helm chart？
在安装前我们需要做一些前置的操作。

检查charts中是否引用了common模块。如果，你的charts中使用到了common模块的内容，在install之前你需要执行以下命令
```shell
helm dependency update
```

### 部署服务

检查是否使用了common模块

```shell
[root@infra cloudtogo]# cat Chart.yaml 
apiVersion: v2
name: agentorca
description: A Helm chart for Kubernetes

# A chart can be either an 'application' or a 'library' chart.
#
# Application charts are a collection of templates that can be packaged into versioned archives
# to be deployed.
#
# Library charts provide useful utilities or functions for the chart developer. They're included as
# a dependency of application charts to inject those utilities and functions into the rendering
# pipeline. Library charts do not define any templates and therefore cannot be deployed.
type: application

# This is the chart version. This version number should be incremented each time you make changes
# to the chart and its templates, including the app version.
# Versions are expected to follow Semantic Versioning (https://semver.org/)
version: 0.1.0

# This is the version number of the application being deployed. This version number should be
# incremented each time you make changes to the application. Versions are not expected to
# follow Semantic Versioning. They should reflect the version the application is using.
# It is recommended to use it with quotes.
appVersion: "1.16.0"

dependencies:
  - name: common
    version: "1.0.0"
    repository: "file://../../../common"
```
引用了common模块，在install之前，我们首先执行以下命令，防止出现依赖非最新导致的异常情况

```shell
[root@infra cloudtogo]# helm dependency update test
Hang tight while we grab the latest from your chart repositories...
Update Complete. ⎈Happy Helming!⎈
Saving 1 charts
Deleting outdated charts
```
更新完毕，现在可以进行install了