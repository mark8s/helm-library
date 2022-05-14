# Common

**Common** 是一个公共的库类型chart，里面定义了一些公共的模板，它不能单独install，只能通过引用去使用它里面预定义的函数。

在开始本次内容前，首先了解一下本文中出现比较频繁的几个名词的含义：
- 模板：即函数的集合，是以`.tpl`为后缀的文件。如`deployment.tpl`就是一个存放包含`common.deployment`函数的模板。
- 函数：即我们理解中的函数，是一个通用代码的集合。在helm中可以通过 ``{{ include }}`` 去引用它。
- 资源：即kubernetes中的资源，如 deployment、service、configmap等。

## 使用common
修改需要引入common的helm charts 的Chart.yaml文件，添加如下代码:

```yaml
dependencies:
  - name: common
    version: "1.0.0"
    repository: "file://../../../common"
```

假如，现在引入common的charts包名为test，当添加完以上代码后，需要执行命令去下载`common`到test中，执行如下命令：

`helm dependency update test`

执行后，如果在test的charts目录下看到一个名称带有`common`的tgz文件，就说明common引入成功了。

现在，在test的templates目录下就可以使用common的模板了。如，我们直接使用里面的deployment模板，生成一个完整的deployment资源文件。

先创建一个deployment.yaml文件，然后放置以下代码

```gotemplate
{{- include "common.deployment" . }}
```

配合test的values.yaml中的内容，就可以生成一个deployment资源了。

那么`common` 包含着哪些函数，以及如何使用里面的函数？？？请继续往下看。

## 函数

### common中包含的函数

下面列举了一些较为常用的函数：

| 函数名                      | 描述                                      |   使用  |
| ------------------------- | ----------------------------------------- | ------------ |
| `common.deployment`    | 生成deployment资源                     | 以 {{ include "common.deployment" . }} 进行引用，“.” 代表全局作用域。以下所以函数都可以使用此方式进行引用，后面不做多余赘述 
| `common.service` | 生成service资源 | 以 {{ include "common.service" . }} 进行引用，“.” 代表全局作用域
| `common.labels.standard` | metadata下面的label |
| `common.labels.matchLabels` | spec.selector下面的matchLabel | 
| `common.names.fullname` | 设置资源的名称，默认读取values.yaml中的fullnameOverride值 | 
| `common.rbac.serviceAccount` | 生成serviceAccount资源 |
| `common.rbac.clusterRole` | 生成clusterRole资源 |
| `common.rbac.role` | 生成Role资源 |
| `common.rbac.clusterRoleBinding` | 生成clusterRoleBinding资源 |
| `common.rbac.roleBinding` | 生成roleBinding资源 |
| `common.capabilities.kubeVersion` | k8s版本 |
| `common.capabilities.deployment.apiVersion` | 当前集群deployment的apiVersion |
| `common.capabilities.rbac.apiVersion` | 当前集群rbac相关资源的apiVersion |
| ... | | 

以上列举了`common`模板中绝大部分的内容，下面这里再补充说明一下。

（1）global与local的定义

我们在执行`helm install`的时候，会使用 `-f` 标识符指定我们要使用的`values.yaml`文件，我们把这个文件称之为 ”global“。 目前来说，这个“global”文件对应的就是`/values.yaml`文件。

除了这个“global”文件，其实在每个chart中，还存在一个values.yaml文件， 我们可以把这个文件称之为“local”文件。

在上面提供的有关相关函数中，common根据这两个文件做了一个约定：它会优先使用“local”中的配置。

以`common.tools.mail.username`为例，假设在“global”中有以下配置：

```yaml
global:
  mail:
    username: "notice@cos.cn"
```
如果我们“local”配置中，不存在以下配置：
```yaml
mail:
  username: "local-notice@cos.cn"
```
那么，当你使用 ``common.tools.mail.username``去引用这个值的时候，username的值就是notice@cos.cn。

而，如果我们“local”配置中，存在这个配置，那么username的值就是local-notice@cos.cn。

也可以称之为 “本地优先” 。


（2）values.yaml中变量字段的说明

当前“global”配置文件中，存在一些定义不太恰当或冗余的字段。如：

```yaml
mysql:
  mysql_host: "10.10.14.8"
  mysql_port: 3306
redis:
  redis_host: "10.10.14.5"
  redis_port: 6379
  redis_hostport: "10.10.14.5:6379"
```

我们认为，改成以下会更加合理：

```yaml
mysql:
  host: "10.10.14.8"
  port: 3306
redis:
  host: "10.10.14.5"
  port: 6379
```
这样，字段长度可以瘦身，另外hostPort本身就可以通过host和port拼接得到，再定义一个字段有些冗余。
其他与之类似的情况不多赘述。

（3）deployment和service函数的说明

deployment和service对于我们来说是操作k8s最核心的两种资源，common中提供了生成两种资源文件的函数。
我们参考了一些比较优秀的开源charts中的写法，然后结合目前使用中的情况，进行了一些改造。如果有小伙伴用起来后，觉得有些不方便，
或是不适配你目前的需要，可以找我们来提建议，我们一起做好这件事。


（4）什么样的变量要维护到common的函数中？

上述提供的函数还是比较简陋的，后续根据实际使用场景，会进行一些补充。那么，什么样的变量要维护到common的函数中呢？

这其实就关乎到common的定义了，个人认为只要达到全局通用就可以维护到common中。

对于k8s的资源来说，这相对比较简单，它没那么强关联业务，只要它确实在某些地方用到，我们就可以将其维护到common中。


## Values文件规范

values.yaml文件中的内容，本质上还是为k8s的一些常见的资源去服务的，如deployment、service、configmap，所以values里面定义的一些变量也与k8s相关。
下面，列举一些values.yaml常见的内容，可以供你后续自定义charts时作为参考。

以下内容是使用common中deployment函数时，values.yaml文件中字段的标准写法！

#### replicaCount
定义资源使用的副本数，使用`replicaCount`：如：
```yaml
replicaCount: 1
```
可以通过 ``{{ .Values.replicaCount }}`` 去引用它。

#### image
定义image去描述资源使用的镜像，如：
```yaml
image:
  name: nginx
  pullPolicy: IfNotPresent
```
image.name: 代表一个完整的镜像地址。如果值是引用其他的变量值，需要加双引号，如 name: `"{{- .Values.global.dockerRegisty }}/{{- .Values.global.orchorImage }}"`
image.pullPolicy: 定义镜像拉取策略。

#### [fullnameOverride]

定义资源名称，common的模板或者helm chart默认生成的_helper.tpl模板中，资源名称默认是使用的releaseName。如果想更改，可以在values中设置fullnameOverride。
如果是使用common中的deployment模板，并且使用helm一次性部署多个chart时，需要明确定义这个字段，因为deployment模板在fullnameOverride为空时，默认取release值，如果是一次性部署多个chart会出现资源名称冲突问题。
如：
```yaml
fullnameOverride: "demo"
```

#### [env]
定义资源中使用的环境变量，这里是一个整体替换的逻辑处理，将原生yaml代码弄过来即可，如：
```yaml
env:
  - name: DISABLE_HTTP2
    value: "1"
  - name: NODE_IP
    valueFrom:
      fieldRef:
        apiVersion: v1
        fieldPath: status.hostIP
  - name: APIServerEndpoint
    value: turtle:16020
```

#### [service]
定义k8s service资源。如果项目中用到了service，可以使用如下定义，如：
```yaml
service:
  type: ClusterIP
  ports:
    - name: tcp-port-1400
      port: 1400
      protocol: TCP
      targetPort: 1400
```
service的名称由`fullnameOverride`字段控制。

然后可以结合 `common.service`函数，去生成service资源。

#### [serviceAccount]
定义是否创建serviceAccount。create字段的值为true,代表创建serviceAccount。name表示serviceAccount的名称，可选，不写的话值默认和资源名称值相同。
```yaml
serviceAccount:
  create: true
  name: "demo"
```

#### [resources]
定义deployment的resource，这里是一个整体替换的逻辑处理，将原生yaml代码弄过来即可，如：
```yaml
resources:
  limits: {}
  requests:
    memory: 512Mi
    cpu: 300m
```

#### [restartPolicy]
定义deployment的重启策略，如：
```yaml
restartPolicy: Always
```

#### [command]
定义container的command，这里是一个整体替换的逻辑处理，将原生yaml代码弄过来即可，如：
```yaml
command:
  - printenv
```

#### [args]
定义container的args，这里是一个整体替换的逻辑处理，将原生yaml代码弄过来即可，如：
```yaml
args:
    - "-zone={{- .Values.global.dnsa.args.zones }}"
    - -mode=master
    - -dnsa=dnsa-master:1401
    - "-mongo={{- .Values.global.dnsa.args.mongostr }}"
    - -dynamicheck=true
    - "-enablehttps={{ .Values.global.enable_https }}"
```

#### [updateStrategy]
定义deployment的更新策略，如：
```yaml
updateStrategy:
  type: RollingUpdate
```

#### [commonLabels]
定义deployment的标准labels，也就是k8s资源中metadata下面的labels，如：
```yaml
commonLabels:
  app: demo
```

#### [commonAnnotations]

定义deployment的标准annotations，也就是k8s资源中metadata下面的annotations，如：
```yaml
commonAnnotations:
  creater: mark
```

#### [matchLabels]
定义deployment(或sts、ds)匹配pod的matchLabels和pod的labels。如果不填，默认生成 "app": "服务名" 的label， 如：

```yaml
matchLabels:
  app: test
```

#### [podAnnotations]
定义配pod的annotations，如：
```yaml
podAnnotations:
  creater: mark
```

#### [containerPort]
定义deployment等资源中的容器端口，这里是一个整体替换的逻辑处理，将原生yaml代码弄过来即可，如：
```yaml
containerPort:
  - name: http
    containerPort: 80
    protocol: TCP
```

#### [readinessProbe]
定义deployment等资源中的就绪探针，这里是一个整体替换的逻辑处理，将原生yaml代码弄过来即可，如：
```yaml
readinessProbe:
  exec:
    command:
      - cat
      - /tmp/healthy
  initialDelaySeconds: 5
  periodSeconds: 5
```

#### [livenessProbe]
定义deployment等资源中的存活探针，这里是一个整体替换的逻辑处理，将原生yaml代码弄过来即可，如：
```yaml
livenessProbe:
  httpGet:
    path: /healthz
    port: liveness-port
  failureThreshold: 1
  periodSeconds: 10
```

#### [startupProbe]
定义deployment等资源中的启动探针，这里是一个整体替换的逻辑处理，将原生yaml代码弄过来即可，如：
```yaml
startupProbe:
  httpGet:
    path: /healthz
    port: liveness-port
  failureThreshold: 30
  periodSeconds: 10
```

#### [volumes]
定义volumes，这里是一个整体替换的逻辑处理，将原生yaml代码弄过来即可，如：
```yaml
volumes:
  - name: pvc-sfs-example
    persistentVolumeClaim:
      claimName:  pvc-example
```

#### [volumeMounts]
定义volumeMounts，这里是一个整体替换的逻辑处理，将原生yaml代码弄过来即可，如：
```yaml
volumeMounts: 
  - mountPath: /tmp    # 挂载路径
    name: pvc-sfs-example
```
#### [nodeSelector]
定义nodeSelector,这里是一个整体替换的逻辑处理，将原生yaml代码弄过来即可，如：
```yaml
nodeSelector:      # 节点选择，当节点拥有gpu=true时才在节点上创建Pod
  gpu: true
```

#### [affinity]
定义affinity,这里是一个整体替换的逻辑处理，将原生yaml代码弄过来即可，如：
```yaml
affinity:
  nodeAffinity:
    requiredDuringSchedulingIgnoredDuringExecution:
      nodeSelectorTerms:
        - matchExpressions:
          - key: gpu
            operator: In
            values:
            - "true"
```

#### [tolerations]
定义tolerations，这里是一个整体替换的逻辑处理，将原生yaml代码弄过来即可，如：
```yaml
tolerations:
  - key: "key1"
    operator: "Equal"
    value: "value1"
    effect: "NoSchedule" 
```

#### [hostAliases]
定义hostAliases，这里是一个整体替换的逻辑处理，将原生yaml代码弄过来即可，如：
```yaml
hostAliases:
  - ip: 127.0.0.1
    hostnames:
    - foo.local
    - bar.local
  - ip: 10.1.2.3
    hostnames:
    - foo.remote
    - bar.remote
```

#### [initContainers]
定义初始化容器，这里是一个整体替换的逻辑处理，将原生yaml代码弄过来即可，如：
```yaml
- name: init-myservice
    image: busybox:1.28
    command: ['sh', '-c', "until nslookup myservice.$(cat /var/run/secrets/kubernetes.io/serviceaccount/namespace).svc.cluster.local; do echo waiting for myservice; sleep 2; done"]
```

#### [podSecurityContext]
定义pod的securityContext，如：
```yaml
podSecurityContext:
  enabled: true
  fsGroup: 1001
```

#### [containerSecurityContext]
定义容器的securityContext，如：
```yaml
containerSecurityContext:
  enabled: true
  runAsUser: 1001
  runAsNonRoot: true
```

#### [hostNetwork]
定义hostNetwork，如：
```yaml
hostNetwork: true
```

#### [ingress]
是否开启ingress,默认生成`template/NOTES.txt`中有判断该字段是否存在，可加上，如
```yaml
ingress:
  enabled: false
  annotations: {}
    # kubernetes.io/ingress.class: nginx
    # kubernetes.io/tls-acme: "true"
  hosts:
    - host: chart-example.local
      paths: []
  tls: []
  #  - secretName: chart-example-tls
  #    hosts:
  #      - chart-example.local
```


## 改造我们自己的项目
改造我们自己的服务，有两种方式，第一种是在原先yaml格式的资源文件中使用 {{ include }} 方式，引入common中定义的如names等非deployment、service模板。
第二种是完全使用common中提供的deployment、service模板，将原先yaml格式的资源文件，全部拆解到values.yaml中。推荐使用第二种方式。

我们看一个较为完整的案例，改造`openresty` 的deployment和service。
### 使用common中的deployment和service

首先原始deployment.yaml如下：

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: openresty
  namespace: cos-system
spec:
  replicas: 1
  selector:
    matchLabels:
      name: openresty
  template:
    metadata:
      labels:
        name: openresty
    spec:
      restartPolicy: Always
      containers:       
        - name: openresty
          image: "{{ .Values.global.dockerRegisty }}/{{ .Values.global.openrestyImage }}"
          #===========先以系统环境变量传进来，再用$()使用它=============
          env:  #在环境变量中使用configmap
          - name: COS_FILESTORAGE_SERVICE_ADDRESS
            valueFrom:
              configMapKeyRef:
                name: cm-openresty
                key: COS_FILESTORAGE_SERVICE_ADDRESS
          - name: COS_WEBX_SERVICE_ADDRESS
            valueFrom:
              configMapKeyRef:
                name: cm-openresty
                key: COS_WEBX_SERVICE_ADDRESS
          - name: OPENRESTY_JWT_SIGNING_KEY
            valueFrom:
              configMapKeyRef:
                name: cm-openresty
                key: OPENRESTY_JWT_SIGNING_KEY
          - name: TITAN_IDE_WORKSPACE_ADDRESS
            valueFrom:
              configMapKeyRef:
                name: cm-openresty
                key: TITAN_IDE_WORKSPACE_ADDRESS
          readinessProbe:
            tcpSocket:
              port: 80
            initialDelaySeconds: 5
            periodSeconds: 5
```

以上deployment，我们需要在values.yaml定义以下几个内容：

- 资源名称(fullnameOverride)
- 副本数(replicaCount)
- 镜像名称(image)
- deployment匹配pod的matchLabels(matchLabels)
- 环境变量(env)
- 就绪探针(readinessProbe)

然后修改values.yaml文件内容：

```yaml
fullnameOverride: "openresty"

replicaCount: 1

image:
  name: "{{ .Values.global.dockerRegisty }}/{{ .Values.global.openrestyImage }}"

matchLabels:
  name: openresty

env:
  - name: COS_FILESTORAGE_SERVICE_ADDRESS
    valueFrom:
      configMapKeyRef:
        name: cm-openresty
        key: COS_FILESTORAGE_SERVICE_ADDRESS
  - name: COS_WEBX_SERVICE_ADDRESS
    valueFrom:
      configMapKeyRef:
        name: cm-openresty
        key: COS_WEBX_SERVICE_ADDRESS
  - name: OPENRESTY_JWT_SIGNING_KEY
    valueFrom:
      configMapKeyRef:
        name: cm-openresty
        key: OPENRESTY_JWT_SIGNING_KEY
  - name: TITAN_IDE_WORKSPACE_ADDRESS
    valueFrom:
      configMapKeyRef:
        name: cm-openresty
        key: TITAN_IDE_WORKSPACE_ADDRESS

readinessProbe:
  tcpSocket:
    port: 80
  initialDelaySeconds: 5
  periodSeconds: 5

```
将deployment.yaml中原有内容清空，放置以下代码：

```gotemplate
{{- include "common.deployment" . }}
```
我们可以先测试以下，测试前，保证Chart.yaml中有以下代码：

```yaml
dependencies:
  - name: common
    version: "1.0.0"
    repository: "file://../../../common"
```

其中`repository`后面的common路径视具体情况而定。

确保Chart.yaml中有以上代码后，执行以下命令，将common依赖引入到当前charts中：

```yaml
helm dependency update “当前chart包名”
```

执行效果：
```shell
[root@infra charts]# helm dependency update openresty/
Hang tight while we grab the latest from your chart repositories...
Update Complete. ⎈Happy Helming!⎈
Saving 1 charts
Deleting outdated charts
[root@infra charts]# 

```

ok，执行`helm dry-run` 去看看刚才改造的效果：

```shell
helm install openresty openresty/ -n example -f ~/mark/helm/cloud-playbook/main/cos/values.yaml --dry-run --debug
```

效果：
```yaml
---
# Source: openresty/templates/deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: openresty
  namespace: "example"
  labels:
    app.kubernetes.io/name: openresty
    helm.sh/chart: openresty-0.1.0
    app.kubernetes.io/instance: openresty
    app.kubernetes.io/managed-by: Helm
spec:
  replicas: 1
  selector:
    matchLabels:
      name: openresty
  template:
    metadata:
      labels:
        name: openresty
    spec:
      containers:
        - name: openresty
          image: openresty
          env:
            - name: COS_FILESTORAGE_SERVICE_ADDRESS
              valueFrom:
                configMapKeyRef:
                  key: COS_FILESTORAGE_SERVICE_ADDRESS
                  name: cm-openresty
            - name: COS_WEBX_SERVICE_ADDRESS
              valueFrom:
                configMapKeyRef:
                  key: COS_WEBX_SERVICE_ADDRESS
                  name: cm-openresty
            - name: OPENRESTY_JWT_SIGNING_KEY
              valueFrom:
                configMapKeyRef:
                  key: OPENRESTY_JWT_SIGNING_KEY
                  name: cm-openresty
            - name: TITAN_IDE_WORKSPACE_ADDRESS
              valueFrom:
                configMapKeyRef:
                  key: TITAN_IDE_WORKSPACE_ADDRESS
                  name: cm-openresty
          readinessProbe:
            initialDelaySeconds: 5
            periodSeconds: 5
            tcpSocket:
              port: 80

[root@infra charts]# 


```
大家在执行的时候可能会出现一些错误，我上面是将除deployment.yaml文件之外的资源文件加了bak后缀，先忽略执行了。

改造完deployment，再改造service.yaml。
首先原始service.yaml如下：

```yaml
apiVersion: v1
kind: Service
metadata:
  name: openresty
  namespace: cos-system
  labels:
    app: openresty
spec:
  selector:
    name: openresty
  ports:
    - port: 80
      name: http-port
      protocol: TCP
      targetPort: 80

```
以上service，此时需要在values.yaml定义以下内容：
- 服务的端口(service)

修改values.yaml文件，在最后面增加以下内容：
```yaml
## 服务相关
service:
  type: ClusterIP
  ports:
    - port: 80
      name: http-port
      protocol: TCP
      targetPort: 80
```
然后清空service.yaml中原有的内容，放置如下代码：
```yaml
{{- include "common.service" . }}
```

更新依赖：
```shell
[root@infra charts]# helm dependency update openresty/
```
调试：
```shell
[root@infra charts]# helm install openresty openresty/ -n example -f ~/mark/helm/cloud-playbook/main/cos/values.yaml --dry-run --debug
```
效果：
```yaml
# Source: openresty/templates/service.yaml
apiVersion: v1
kind: Service
metadata:
  name: openresty
  namespace: "example"
  labels:
    app.kubernetes.io/name: openresty
    helm.sh/chart: openresty-0.1.0
    app.kubernetes.io/instance: openresty
    app.kubernetes.io/managed-by: Helm
spec:
  selector:
    name: openresty
  ports:
    - name: http-port
      port: 80
      protocol: TCP
      targetPort: 80
```

### 在原有的deployment的基础上进行改造

改造后的效果如下：
```yaml
apiVersion: {{ include "common.capabilities.deployment.apiVersion" . }}
kind: Deployment
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
  replicas: {{ required "A pod replicas is required!" .Values.replicaCount }}
  selector:
    {{- if .Values.matchLabels }}
    matchLabels: {{- include "common.tplvalues.render" ( dict "value" .Values.matchLabels "context" $ ) | nindent 6  }}
    {{- else }}
    matchLabels: {{- include "common.labels.matchLabels" . | nindent 6 }}
  {{- end }}
  template:
    metadata:
      {{- if .Values.matchLabels }}
      labels: {{- include "common.tplvalues.render" ( dict "value" .Values.matchLabels "context" $ ) | nindent 8  }}
      {{- else }}
      labels: {{- include "common.labels.matchLabels" . | nindent 8 }}
    {{- end }}
    spec:
      restartPolicy: Always
      containers:
        - name: openresty
          image: "{{ .Values.global.dockerRegisty }}/{{ .Values.global.openrestyImage }}"
          #===========先以系统环境变量传进来，再用$()使用它=============
          env:  #在环境变量中使用configmap
            - name: COS_FILESTORAGE_SERVICE_ADDRESS
              valueFrom:
                configMapKeyRef:
                  name: cm-openresty
                  key: COS_FILESTORAGE_SERVICE_ADDRESS
            - name: COS_WEBX_SERVICE_ADDRESS
              valueFrom:
                configMapKeyRef:
                  name: cm-openresty
                  key: COS_WEBX_SERVICE_ADDRESS
            - name: OPENRESTY_JWT_SIGNING_KEY
              valueFrom:
                configMapKeyRef:
                  name: cm-openresty
                  key: OPENRESTY_JWT_SIGNING_KEY
            - name: TITAN_IDE_WORKSPACE_ADDRESS
              valueFrom:
                configMapKeyRef:
                  name: cm-openresty
                  key: TITAN_IDE_WORKSPACE_ADDRESS
          readinessProbe:
            tcpSocket:
              port: 80
            initialDelaySeconds: 5
            periodSeconds: 5
```

service不多赘述，大同小异。








